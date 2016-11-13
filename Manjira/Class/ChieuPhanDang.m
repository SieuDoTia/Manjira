//
//  ChieuPhanDang.m
//  Manjira
//
//  Created by 小小 on 20/11/2556.
//

#import "ChieuPhanDang.h"
#import "ToBong.h"

// ---- màu cảnh sau
#define kMAU_CANH__DO   0.929f
#define kMAU_CANH__LUC  0.929f
#define kMAU_CANH__XANH 0.929f
#define kMAU_CANH__DUC  1.000f

#define kHOA_TIET__RONG 2048
#define kHOA_TIET__CAO  1024

// ---- cho shader
enum {
   ATTRIB_DINH,
   ATTRIB_HOA_TIET
};

@implementation ChieuPhanDang
/*
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}
*/
- (void)awakeFromNib; {

}


#pragma mark ---- Chuẩn Bị OpenGL

- (void)prepareOpenGL; {
   // initialize OpenGL state after creating the NSOpenGLContext object
   glEnable( GL_BLEND );
   glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );

   // ---- họa tiết
   glGenTextures(1, &hoaTietPhanDang );
   [self taoHoaTietCoBeRong:kHOA_TIET__RONG cao:kHOA_TIET__CAO choSoHoaTiet:hoaTietPhanDang];
   
   // ----
//   glClearColor( 0.929f, 0.929f, 0.929f, 1.0f );
   //glClearColor( 0.7f, 0.7f, 0.7f, 1.0f );

   // ---- ma trận chiếu
   CGRect khung = [self frame];
   float tiSoPhongTo = khung.size.width/khung.size.height;
   
   // ---- ma trận chiếu
   float phongTo = 1024.0f/khung.size.width;
   maTranChieu[0] = phongTo*2.0f;  // nhân 2 bề rộng họa tiết
   maTranChieu[5] = phongTo*tiSoPhongTo;   // nhân 2 bề cao họa tiết
   maTranChieu[10] = 1.0f;
   maTranChieu[15] = 1.0f;

   glClearColor( kMAU_CANH__DO, kMAU_CANH__LUC, kMAU_CANH__XANH, kMAU_CANH__DUC );
   
   // ===== SHADERS =====
   NSString *applicationBundleFilePath;
   
   // ---- compile shaders
   // ----------- shader -----------
   unsigned int shaderDinh = 0;
   unsigned int shaderDiemAnh = 0;
	applicationBundleFilePath = [[NSBundle mainBundle] pathForResource:@"TôBóng_HọaTiết" ofType:@"vsh"];
	[ToBong compileShader:&shaderDinh type:GL_VERTEX_SHADER filePath:applicationBundleFilePath];
	applicationBundleFilePath = [[NSBundle mainBundle] pathForResource:@"TôBóng_HọaTiết" ofType:@"fsh"];
	[ToBong compileShader:&shaderDiemAnh type:GL_FRAGMENT_SHADER filePath:applicationBundleFilePath];
   
   // ---- tạo nên chương trìng tô bóng
   soChuongTrinhVe = [ToBong createShaderProgramWithVertexShader:shaderDinh andFragmentShader:shaderDiemAnh];
   
   // need to do this before linking
   glBindAttribLocation(soChuongTrinhVe, ATTRIB_DINH, "dinh");
   glBindAttribLocation(soChuongTrinhVe, ATTRIB_HOA_TIET, "toaDoHoaTiet");
   //   glBindAttribLocation(shaderProgramArray[GLSL_PROGRAM_FLAT_SHADER], FLAT_SHADER_ATTRIB_PHAP_TUYEN, "phapTuyen");
   
   
	[ToBong linkAndValidateProgram:soChuongTrinhVe];
   
	uniform_MaTranChieu = glGetUniformLocation(soChuongTrinhVe, "maTranChieu");
   
   //  enable attributes for shaders
   glEnableVertexAttribArray( ATTRIB_DINH );
   glEnableVertexAttribArray( ATTRIB_HOA_TIET );
}

#pragma mark ---- Vẽ
- (void)drawRect:(NSRect)dirtyRect; {
   
   float mangDinhChuNhat[8] = {
      -1.0, 1.0,  -1.0f, -1.0f,
       1.0, 1.0,   1.0f, -1.0f};
   
   float mangToaDoHoaTiet[16] = {
      0.0f, 1.0f,   0.0f, 0.0f,
      1.0f, 1.0f,   1.0f, 0.0f,
   };
   
   glClear( GL_COLOR_BUFFER_BIT );

   if( hoaTietPhanDang ) {
      glUseProgram( soChuongTrinhVe );
      glUniformMatrix4fv( uniform_MaTranChieu, 1, GL_FALSE, maTranChieu );
      glBindTexture(GL_TEXTURE_2D, hoaTietPhanDang);

      glVertexAttribPointer(ATTRIB_DINH, 2, GL_FLOAT, NO, 0, mangDinhChuNhat );
      glVertexAttribPointer(ATTRIB_HOA_TIET, 2, GL_FLOAT, YES, 0, mangToaDoHoaTiet );
      glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
   }

   glFlush();
}

#pragma mark ---- Họa Tiết

- (void)taoHoaTietCoBeRong:(unsigned int)rong cao:(unsigned int)cao choSoHoaTiet:(unsigned int)soHoaTiet; {
   
   // ---- dính tên họa tiết (tên là số)
   glBindTexture(GL_TEXTURE_2D, soHoaTiet );
   glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
   glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
   glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT );
   glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT );
   
   // ---- 
   float *hoaTietChanh = malloc( rong * cao * sizeof( float ) << 2 );
   
   if( hoaTietChanh ) {
      unsigned int chiSo = 0;
      unsigned int chiSoCuoi = rong * cao;
      while( chiSo < chiSoCuoi ) {
         hoaTietChanh[chiSo] = kMAU_CANH__DO;
         hoaTietChanh[chiSo+1] = kMAU_CANH__LUC;
         hoaTietChanh[chiSo+2] = kMAU_CANH__XANH;
         hoaTietChanh[chiSo+3] = kMAU_CANH__DUC;
         chiSo += 4;
      }
      
      glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA, rong, cao, 0, GL_RGBA, GL_FLOAT, hoaTietChanh );
      // ---- thả trí nhớ
      free( hoaTietChanh );
   }
   else
      NSLog( @"ChieuPhanDang: taoHoaTiet: Vấn đề dành trí nhớ" );
}


#pragma mark ---- Chép Ảnh
- (void)chepAnh:(float *)anh; {
   // ---- tính vị trí góc cho ở ching giữa màn chiếu
   unsigned short viTriX;
   unsigned short viTriY;
   
   if( kHOA_TIET__RONG > beRong ) {
      viTriX = (kHOA_TIET__RONG - beRong) >> 1;
      viTriY = (kHOA_TIET__CAO - beCao) >> 1;
   }
   else {
      viTriX = 0;
      viTriY = (kHOA_TIET__CAO - beCao) >> 1;
   }

   [self chepAnh:anh taiViTriX:viTriX vaViTriY:viTriY rong:beRong cao:beCao];
}


- (void)chepAnh:(float *)anh taiViTriX:(unsigned int)viTriX vaViTriY:(unsigned int)viTriY
           rong:(unsigned short)rong cao:(unsigned short)cao; {

   [[self openGLContext] makeCurrentContext];
   // ---- dính tên họa tiết (tên là số)
   glBindTexture(GL_TEXTURE_2D, hoaTietPhanDang );
   
   glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
   glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
   glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT );
   glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT );
//   NSLog( @"ChieuPhanDang: viTri %d  %d  +  %d %d =  %d %d  %d %d", viTriX, viTriY, rong, cao, viTriX + rong, viTriY + cao, 2*viTriX + rong, 2*viTriY + cao );
   glTexSubImage2D( GL_TEXTURE_2D, 0, viTriX, viTriY, rong, cao, GL_RGBA, GL_FLOAT, anh );
//   unsigned int error = glGetError();
   [self setNeedsDisplay:YES];
}

#pragma mark ---- Xóa
- (void)xoa; {
   
   [[self openGLContext] makeCurrentContext];
   // ---- dính tên họa tiết (tên là số)
   glBindTexture(GL_TEXTURE_2D, hoaTietPhanDang );
   
   glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
   glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
   glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT );
   glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT );
   
   float *anh = malloc( kHOA_TIET__RONG*kHOA_TIET__CAO*sizeof( float ) << 2 );
   
   if( anh ) {
      unsigned int chiSo = 0;
      unsigned int chiSoCuoi = kHOA_TIET__RONG*kHOA_TIET__CAO << 2;
      while( chiSo < chiSoCuoi ) {
         anh[chiSo] = kMAU_CANH__DO;
         anh[chiSo+1] = kMAU_CANH__LUC;
         anh[chiSo+2] = kMAU_CANH__XANH;
         anh[chiSo+3] = kMAU_CANH__DUC;
         chiSo +=4;
      }
      
      glTexSubImage2D( GL_TEXTURE_2D, 0, 0, 0, kHOA_TIET__RONG, kHOA_TIET__CAO, GL_RGBA, GL_FLOAT, anh );
      free( anh );
      //   unsigned int error = glGetError();
      [self setNeedsDisplay:YES];
   }
}

#pragma mark ---- Reshape
- (void)reshape {
	// We draw on a secondary thread through the display link
	// When resizing the view, -reshape is called automatically on the main thread
	// Add a mutex around to avoid the threads accessing the context simultaneously when resizing
	CGLLockContext([[self openGLContext] CGLContextObj]);
	
   CGRect khung = [self frame];
   beRong = khung.size.width;
   beCao = khung.size.height;
	glViewport(0, 0, khung.size.width, khung.size.height);
   
   float tiSoPhongTo = khung.size.width/khung.size.height;
   
   // ---- ma trận chiếu
   float phongTo = 1024.0f/khung.size.width;
   maTranChieu[0] = phongTo*2.0f;  // nhân 2 bề rộng họa tiết
   maTranChieu[5] = phongTo*tiSoPhongTo;   // nhân 2 bề cao họa tiết

   // ---- đặt hai ma trận thế giới
   //	setOrthographicProjection( maTranVuongTheGioi, -1.0, 1.0, -viewPortRatio, viewPortRatio, -5.0, 5.0 );
   //   datMaTranChieuPhoi( maTranChieuPhoi, -0.75f, 0.75f, -0.75*viewPortRatio, 0.75*viewPortRatio, 1.0f, 5.0f);
	
	CGLUnlockContext([[self openGLContext] CGLContextObj]);
}

#pragma mark ---- Chuột
- (void)mouseDown:(NSEvent *)suKien; {
   
   // ---- chưa biết sẽ kéo hình, đặt = SAI trước
   keoHinh = FALSE;
   viTriBamDau = [suKien locationInWindow];
}

- (void)mouseDragged:(NSEvent *)suKien; {
   
   keoHinh = TRUE;
}

- (void)mouseUp:(NSEvent *)suKien; {

   viTriBamTuongDoi = [suKien locationInWindow];

   // ---- chỉ làm nếu chưa kéo hình
   if( !keoHinh ) {

      CGRect chuNhatChieu = [self frame];
      
      // ---- vị trí trong cửa sổ
      viTriBamTuongDoi.x -= chuNhatChieu.origin.x;
      viTriBamTuongDoi.y -= chuNhatChieu.origin.y;
      
      // ---- vị trí với ảnh phần dạng
      viTriBamTuongDoi.x -= (chuNhatChieu.size.width - beRong)*0.5f;
      viTriBamTuongDoi.y -= (chuNhatChieu.size.height - beCao)*0.5f;
      
      // ----- tương đối với trung tâm
      viTriBamTuongDoi.x -= beRong*0.5;
      viTriBamTuongDoi.y -= beCao*0.5;
      
      // ---- chia bề cỡ thước ảnh phần ảnh (không phải của NSOenGLView)
      viTriBamTuongDoi.x /= (float)beRong;
      viTriBamTuongDoi.y /= (float)beCao;
      
      // ---- chỉ phạt nếu bấm ở trong ảnh phần dạng
      if( viTriBamTuongDoi.x <= 0.5f && viTriBamTuongDoi.x >= -0.5f && viTriBamTuongDoi.y <= 0.5f && viTriBamTuongDoi.y >= -0.5f ) {
         // ---- xem bấm đang phím shift
         if( [suKien modifierFlags] & NSShiftKeyMask )
            phimShift = YES;
         else
            phimShift = NO;
         
         [[NSNotificationCenter defaultCenter] postNotificationName:@"星凤BấmĐiểm" object:self];
      }
   }
   else {
      // ---- tính cách bị kéo đi
      cachKeoMan = CGPointMake( viTriBamTuongDoi.x - viTriBamDau.x, viTriBamTuongDoi.y - viTriBamDau.y );

      [[NSNotificationCenter defaultCenter] postNotificationName:@"星凤KéoMàn" object:self];
   }
}



#pragma mark --- Bàn Phím
- (BOOL)acceptsFirstResponder; {
   return YES;
}

//- (BOOL)resignFirstResponder; {
//   return YES;
//}

- (void)keyDown:(NSEvent *)event; {

   huong = [event keyCode];
   if( [event modifierFlags] & NSShiftKeyMask )
     phimShift = YES;
   else
      phimShift = NO;

   [[NSNotificationCenter defaultCenter] postNotificationName:@"星凤DiChuyển" object:self];
}


#pragma mark ---- Biến
//@synthesize anhViDu;
@synthesize beRong;
@synthesize beCao;
@synthesize viTriBamTuongDoi;
@synthesize phimShift;

@synthesize huong;
@synthesize cachKeoMan;

@end
