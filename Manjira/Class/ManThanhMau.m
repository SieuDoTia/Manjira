//
//  ManThanhMau.m
//  Manjira
//
//  Created by 小小 on 20/11/2556.
//
// +-------------------------------------------+
// | |<----- kBE_RONG__DANH_BA_MAU ---->|      |
// | +----------------------------------+  +-+ |
// | |            thanh màu             |  | | |
// | +----------------------------------+  +-+ |
// | ∆   ∆   ∆   ∆   ∆   ∆   ∆   ∆   ∆  ∆   ∆  |
// | +------------------------------+ +------+ |
// |       ∆                          |      | |
// | +------------------------------+ |      | |
// |                     ∆            |      | |
// | +------------------------------+ +------+ |
// |               ∆                           |
// | |<-- kBE_RONG__COT_CHON_MAU -->|          |
// +-------------------------------------------+

#import "ManThanhMau.h"
#import "ToBong.h"

#import "ToMau.h"

// ---- cho shader
enum {
   ATTRIB_DINH,
   ATTRIB_MAU
};


#define kBE_RONG__DANH_BA_MAU 1.8f
#define kBE_RONG__COT_CHON_MAU 1.5f
#define kLE_TRAI 0.025f
#define kVI_TRI_X__TAM_GIAC_MAU_TAP_HOP 0.915f

@implementation ManThanhMau

/*
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}*/

- (void)awakeFromNib; {
   
   // ---- ba cột chọn màu
   cacCotChonMau_dinh[0] = -1.0f + kLE_TRAI;
   cacCotChonMau_dinh[1] = 0.1f;
   cacCotChonMau_dinh[2] = -1.0f + kLE_TRAI;
   cacCotChonMau_dinh[3] = 0.0f;
   cacCotChonMau_dinh[4] = -1.0f + kLE_TRAI + kBE_RONG__COT_CHON_MAU;
   cacCotChonMau_dinh[5] = 0.1f;
   cacCotChonMau_dinh[6] = -1.0f + kLE_TRAI + kBE_RONG__COT_CHON_MAU;
   cacCotChonMau_dinh[7] = 0.0f;
   // ----
   cacCotChonMau_dinh[8] = -1.0f + kLE_TRAI + kBE_RONG__COT_CHON_MAU;
   cacCotChonMau_dinh[9] = 0.0f;
   cacCotChonMau_dinh[10] = -1.0f + kLE_TRAI;
   cacCotChonMau_dinh[11] = -0.3f;
   // ----
   cacCotChonMau_dinh[12] = -1.0f + kLE_TRAI;
   cacCotChonMau_dinh[13] = -0.3f;
   cacCotChonMau_dinh[14] = -1.0f + kLE_TRAI;
   cacCotChonMau_dinh[15] = -0.4f;
   cacCotChonMau_dinh[16] = -1.0f + kLE_TRAI + kBE_RONG__COT_CHON_MAU;
   cacCotChonMau_dinh[17] = -0.3f;
   cacCotChonMau_dinh[18] = -1.0f + kLE_TRAI + kBE_RONG__COT_CHON_MAU;
   cacCotChonMau_dinh[19] = -0.4f;
   // ----
   cacCotChonMau_dinh[20] = -1.0f + kLE_TRAI + kBE_RONG__COT_CHON_MAU;
   cacCotChonMau_dinh[21] = -0.4f;
   cacCotChonMau_dinh[22] = -1.0f + kLE_TRAI;
   cacCotChonMau_dinh[23] = -0.7f;
   // ----
   cacCotChonMau_dinh[24] = -1.0f + kLE_TRAI;
   cacCotChonMau_dinh[25] = -0.7f;
   cacCotChonMau_dinh[26] = -1.0f + kLE_TRAI;
   cacCotChonMau_dinh[27] = -0.8f;
   cacCotChonMau_dinh[28] = -1.0f + kLE_TRAI + kBE_RONG__COT_CHON_MAU;
   cacCotChonMau_dinh[29] = -0.7f;
   cacCotChonMau_dinh[30] = -1.0f + kLE_TRAI + kBE_RONG__COT_CHON_MAU;
   cacCotChonMau_dinh[31] = -0.8f;

   // ---- cột cho màu đỏ
   cacCotChonMau_mau[0] = 0.0f;
   cacCotChonMau_mau[1] = 0.0f;
   cacCotChonMau_mau[2] = 0.0f;
   cacCotChonMau_mau[3] = 1.0f;
   cacCotChonMau_mau[4] = 0.0f;
   cacCotChonMau_mau[5] = 0.0f;
   cacCotChonMau_mau[6] = 0.0f;
   cacCotChonMau_mau[7] = 1.0f;

   cacCotChonMau_mau[8] = 1.0f;
   cacCotChonMau_mau[9] = 0.0f;
   cacCotChonMau_mau[10] = 0.0f;
   cacCotChonMau_mau[11] = 1.0f;
   cacCotChonMau_mau[12] = 1.0f;
   cacCotChonMau_mau[13] = 0.0f;
   cacCotChonMau_mau[14] = 0.0f;
   cacCotChonMau_mau[15] = 1.0f;
   // ---- hai tam giác không xuất hiện
   cacCotChonMau_mau[16] = 0.0f;
   cacCotChonMau_mau[17] = 0.0f;
   cacCotChonMau_mau[18] = 0.0f;
   cacCotChonMau_mau[19] = 0.0f;
   cacCotChonMau_mau[20] = 0.0f;
   cacCotChonMau_mau[21] = 0.0f;
   cacCotChonMau_mau[22] = 0.0f;
   cacCotChonMau_mau[23] = 0.0f;
   // ---- cột màu lục
   cacCotChonMau_mau[24] = 0.0f;
   cacCotChonMau_mau[25] = 0.0f;
   cacCotChonMau_mau[26] = 0.0f;
   cacCotChonMau_mau[27] = 1.0f;
   cacCotChonMau_mau[28] = 0.0f;
   cacCotChonMau_mau[29] = 0.0f;
   cacCotChonMau_mau[30] = 0.0f;
   cacCotChonMau_mau[31] = 1.0f;
   
   cacCotChonMau_mau[32] = 0.0f;
   cacCotChonMau_mau[33] = 1.0f;
   cacCotChonMau_mau[34] = 0.0f;
   cacCotChonMau_mau[35] = 1.0f;
   cacCotChonMau_mau[36] = 0.0f;
   cacCotChonMau_mau[37] = 1.0f;
   cacCotChonMau_mau[38] = 0.0f;
   cacCotChonMau_mau[39] = 1.0f;
   // ---- hai tam giác không xuất hiện
   cacCotChonMau_mau[40] = 0.0f;
   cacCotChonMau_mau[41] = 0.0f;
   cacCotChonMau_mau[42] = 0.0f;
   cacCotChonMau_mau[43] = 0.0f;
   cacCotChonMau_mau[44] = 0.0f;
   cacCotChonMau_mau[45] = 0.0f;
   cacCotChonMau_mau[46] = 0.0f;
   cacCotChonMau_mau[47] = 0.0f;
   // ----
   cacCotChonMau_mau[48] = 0.0f;
   cacCotChonMau_mau[49] = 0.0f;
   cacCotChonMau_mau[50] = 0.0f;
   cacCotChonMau_mau[51] = 1.0f;
   cacCotChonMau_mau[52] = 0.0f;
   cacCotChonMau_mau[53] = 0.0f;
   cacCotChonMau_mau[54] = 0.0f;
   cacCotChonMau_mau[55] = 1.0f;
   
   cacCotChonMau_mau[56] = 0.0f;
   cacCotChonMau_mau[57] = 0.0f;
   cacCotChonMau_mau[58] = 1.0f;
   cacCotChonMau_mau[59] = 1.0f;
   cacCotChonMau_mau[60] = 0.0f;
   cacCotChonMau_mau[61] = 0.0f;
   cacCotChonMau_mau[62] = 1.0f;
   cacCotChonMau_mau[63] = 1.0f;
   
   cacTamGiacChonMau_dinh[0] = -1.0f + kLE_TRAI;
   cacTamGiacChonMau_dinh[1] = 0.0f;
   cacTamGiacChonMau_dinh[2] = -1.0f;
   cacTamGiacChonMau_dinh[3] = -0.2f;
   cacTamGiacChonMau_dinh[4] = -1.0f + kLE_TRAI + 0.025;
   cacTamGiacChonMau_dinh[5] = -0.2f;
   
   cacTamGiacChonMau_dinh[6] = -1.0f + kLE_TRAI;
   cacTamGiacChonMau_dinh[7] = -0.4f;
   cacTamGiacChonMau_dinh[8] = -1.0f;
   cacTamGiacChonMau_dinh[9] = -0.6f;
   cacTamGiacChonMau_dinh[10] = -1.0f + kLE_TRAI + 0.025;
   cacTamGiacChonMau_dinh[11] = -0.6f;
   
   cacTamGiacChonMau_dinh[12] = -1.0f + kLE_TRAI;
   cacTamGiacChonMau_dinh[13] = -0.8f;
   cacTamGiacChonMau_dinh[14] = -1.0f;
   cacTamGiacChonMau_dinh[15] = -1.0f;
   cacTamGiacChonMau_dinh[16] = -1.0f + kLE_TRAI + 0.025;
   cacTamGiacChonMau_dinh[17] = -1.0f;

   // ---- tam giác màu đỏ
   cacTamGiacChonMau_mau[0] = 0.6f;
   cacTamGiacChonMau_mau[1] = 0.6f;
   cacTamGiacChonMau_mau[2] = 0.6f;
   cacTamGiacChonMau_mau[3] = 1.0f;

   cacTamGiacChonMau_mau[4] = 0.2f;
   cacTamGiacChonMau_mau[5] = 0.2f;
   cacTamGiacChonMau_mau[6] = 0.2f;
   cacTamGiacChonMau_mau[7] = 1.0f;

   cacTamGiacChonMau_mau[8] = 0.2f;
   cacTamGiacChonMau_mau[9] = 0.2f;
   cacTamGiacChonMau_mau[10] = 0.2f;
   cacTamGiacChonMau_mau[11] = 1.0f;

   // ---- tam giác màu lục
   cacTamGiacChonMau_mau[12] = 0.6f;
   cacTamGiacChonMau_mau[13] = 0.6f;
   cacTamGiacChonMau_mau[14] = 0.6f;
   cacTamGiacChonMau_mau[15] = 1.0f;
   
   cacTamGiacChonMau_mau[16] = 0.2f;
   cacTamGiacChonMau_mau[17] = 0.2f;
   cacTamGiacChonMau_mau[18] = 0.2f;
   cacTamGiacChonMau_mau[19] = 1.0f;
   
   cacTamGiacChonMau_mau[20] = 0.2f;
   cacTamGiacChonMau_mau[21] = 0.2f;
   cacTamGiacChonMau_mau[22] = 0.2f;
   cacTamGiacChonMau_mau[23] = 1.0f;

   // ---- tam giác màu xanh
   cacTamGiacChonMau_mau[24] = 0.6f;
   cacTamGiacChonMau_mau[25] = 0.6f;
   cacTamGiacChonMau_mau[26] = 0.6f;
   cacTamGiacChonMau_mau[27] = 1.0f;
   
   cacTamGiacChonMau_mau[28] = 0.2f;
   cacTamGiacChonMau_mau[29] = 0.2f;
   cacTamGiacChonMau_mau[30] = 0.2f;
   cacTamGiacChonMau_mau[31] = 1.0f;
   
   cacTamGiacChonMau_mau[32] = 0.2f;
   cacTamGiacChonMau_mau[33] = 0.2f;
   cacTamGiacChonMau_mau[34] = 0.2f;
   cacTamGiacChonMau_mau[35] = 1.0f;

   // ---- chữ nhật chiếu màu
   chuNhatChieuMau_dinh[0] = -1.0f + kLE_TRAI + kBE_RONG__COT_CHON_MAU + 0.1f;
   chuNhatChieuMau_dinh[1] = 0.0f;
   chuNhatChieuMau_dinh[2] = -1.0f + kLE_TRAI + kBE_RONG__COT_CHON_MAU + 0.1f;
   chuNhatChieuMau_dinh[3] = -0.7f;
   chuNhatChieuMau_dinh[4] = 0.95f;
   chuNhatChieuMau_dinh[5] = 0.0f;
   chuNhatChieuMau_dinh[6] = 0.95f;
   chuNhatChieuMau_dinh[7] = -0.7f;
   
   // ---- độ đục mặc định
   chuNhatChieuMau_mau[3] = 1.0f;
   chuNhatChieuMau_mau[7] = 1.0f;
   chuNhatChieuMau_mau[11] = 1.0f;
   chuNhatChieuMau_mau[15] = 1.0f;
   
   // ---- chữ nhật tập hợp
   chuNhatMauTapHop_dinh[0] = kVI_TRI_X__TAM_GIAC_MAU_TAP_HOP - 0.05f;
   chuNhatMauTapHop_dinh[1] = 1.0f;
   chuNhatMauTapHop_dinh[2] = kVI_TRI_X__TAM_GIAC_MAU_TAP_HOP - 0.05f;
   chuNhatMauTapHop_dinh[3] = 0.5f;
   chuNhatMauTapHop_dinh[4] = kVI_TRI_X__TAM_GIAC_MAU_TAP_HOP + 0.05f;
   chuNhatMauTapHop_dinh[5] = 1.0f;
   chuNhatMauTapHop_dinh[6] = kVI_TRI_X__TAM_GIAC_MAU_TAP_HOP + 0.05f;
   chuNhatMauTapHop_dinh[7] = 0.5f;

   // ---- độ đục mặc định
   chuNhatMauTapHop_mau[3] = 1.0f;
   chuNhatMauTapHop_mau[7] = 1.0f;
   chuNhatMauTapHop_mau[11] = 1.0f;
   chuNhatMauTapHop_mau[15] = 1.0f;
}

#pragma mark ---- Đặt Màu Chuổi
- (void)datMau:(ToMau *)_toMau; {
   
   float *danhSachMau = [_toMau danhSachMau];
   soLuongMau = [_toMau soLuongMau];
   toMau = _toMau;
   
   float buoc = kBE_RONG__DANH_BA_MAU/(float)(soLuongMau - 1);
   
   unsigned short diaChiDanhSachMau = 0;
   unsigned short diaChiMangDinh = 0;
   unsigned short diaChiMangMau = 0;
   unsigned short diaChiMangTamGiac_dinh = 0;
   unsigned short diaChiMangTamGiac_mau = 0;
   unsigned short soMau = 0;

   float tungDo = -1.0f + kLE_TRAI;  // tung độ

   while( soMau < soLuongMau ) {
      // ---- mảng cho thanh màu
      mangThanhMau_dinh[diaChiMangDinh] = tungDo;
      mangThanhMau_dinh[diaChiMangDinh+1] = 1.0f;
      mangThanhMau_dinh[diaChiMangDinh+2] = tungDo;
      mangThanhMau_dinh[diaChiMangDinh+3] = 0.5f;
      
      mangThanhMau_mau[diaChiMangMau] = danhSachMau[diaChiDanhSachMau];
      mangThanhMau_mau[diaChiMangMau+1] = danhSachMau[diaChiDanhSachMau+1];
      mangThanhMau_mau[diaChiMangMau+2] = danhSachMau[diaChiDanhSachMau+2];
      mangThanhMau_mau[diaChiMangMau+3] = danhSachMau[diaChiDanhSachMau+3];
      mangThanhMau_mau[diaChiMangMau+4] = danhSachMau[diaChiDanhSachMau];
      mangThanhMau_mau[diaChiMangMau+5] = danhSachMau[diaChiDanhSachMau+1];
      mangThanhMau_mau[diaChiMangMau+6] = danhSachMau[diaChiDanhSachMau+2];
      mangThanhMau_mau[diaChiMangMau+7] = danhSachMau[diaChiDanhSachMau+3];

      // ---- các tam giác ở dưới chuổi màu
      mangTamGiac_dinh[diaChiMangTamGiac_dinh] = tungDo;
      mangTamGiac_dinh[diaChiMangTamGiac_dinh+1] = 0.5f;
      mangTamGiac_dinh[diaChiMangTamGiac_dinh+2] = -0.025f + tungDo;
      mangTamGiac_dinh[diaChiMangTamGiac_dinh+3] = 0.25;
      mangTamGiac_dinh[diaChiMangTamGiac_dinh+4] = 0.025f + tungDo;
      mangTamGiac_dinh[diaChiMangTamGiac_dinh+5] = 0.25;

      float mauXam[4] = {0.5f, 0.5f, 0.5f, 1.0f};
      [self choTamGiac:soMau mau:mauXam];

      diaChiMangDinh += 4;
      diaChiMangMau += 8;
      diaChiDanhSachMau += 4;
      diaChiMangTamGiac_dinh += 6;
      diaChiMangTamGiac_mau += 12;
      tungDo += buoc;
      soMau++;
   }
   
   // ---- tam giác tập hợp
   mangTamGiac_dinh[diaChiMangTamGiac_dinh] = kVI_TRI_X__TAM_GIAC_MAU_TAP_HOP;
   mangTamGiac_dinh[diaChiMangTamGiac_dinh+1] = 0.5f;
   mangTamGiac_dinh[diaChiMangTamGiac_dinh+2] = -0.025f + kVI_TRI_X__TAM_GIAC_MAU_TAP_HOP;
   mangTamGiac_dinh[diaChiMangTamGiac_dinh+3] = 0.25;
   mangTamGiac_dinh[diaChiMangTamGiac_dinh+4] = 0.025f + kVI_TRI_X__TAM_GIAC_MAU_TAP_HOP;
   mangTamGiac_dinh[diaChiMangTamGiac_dinh+5] = 0.25;

   float mauXam[4] = {0.5f, 0.5f, 0.5f, 1.0f};
   [self choTamGiac:soMau mau:mauXam];
   

   float mauXanh[] = {0.0f, 0.0f, 1.0f, 1.0f};
   [self choTamGiac:soMauDaChon mau:mauXanh];
   
   // ---- đặt bằng số màu từ danh sách hay tập hợp
   if( soMauDaChon < soLuongMau ) {
   unsigned short diaChi = soMauDaChon << 2;
      mauChon[0] = danhSachMau[diaChi];
      mauChon[1] = danhSachMau[diaChi+1];
      mauChon[2] = danhSachMau[diaChi+2];
      mauChon[3] = danhSachMau[diaChi+3];
   }
   // ---- màu tập hợp
   else {
      float *mauTapHop = [toMau mauTapHop];
      mauChon[0] = mauTapHop[0];
      mauChon[1] = mauTapHop[1];
      mauChon[2] = mauTapHop[2];
      mauChon[3] = mauTapHop[3];
   }
   
   // ---- nâng cấp màu của chữ nhật
   [self datMauChoChuNhatMau:mauChon];
   [self choCacCotMau:mauChon];

   [self setNeedsDisplay:YES];
}


#pragma mark ----- Chuẩn Bị OpenGL
- (void)prepareOpenGL; {
   // initialize OpenGL state after creating the NSOpenGLContext object
   glEnable( GL_BLEND );
   glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );

   // ---- ma trận chiếu
   maTranChieu[0] = 1.0f;
   maTranChieu[5] = 1.0f;
   maTranChieu[10] = 1.0f;
   maTranChieu[15] = 1.0f;

   // ---- màu xóa là xám sáng
   glClearColor( 0.927f, 0.927f, 0.927f, 1.000f );

   // ===== Tô Bóng =====
   NSString *applicationBundleFilePath;
   
   // ---- biên địch chương trình tô bóng
   // ----------- chương trình tô bóng -----------
   unsigned int shaderDinh = 0;
   unsigned int shaderDiemAnh = 0;
	applicationBundleFilePath = [[NSBundle mainBundle] pathForResource:@"TôBóng" ofType:@"vsh"];
	[ToBong compileShader:&shaderDinh type:GL_VERTEX_SHADER filePath:applicationBundleFilePath];
	applicationBundleFilePath = [[NSBundle mainBundle] pathForResource:@"TôBóng" ofType:@"fsh"];
	[ToBong compileShader:&shaderDiemAnh type:GL_FRAGMENT_SHADER filePath:applicationBundleFilePath];
   
   // ---- tạo nên tô bóng
   soChuongTrinhVe = [ToBong createShaderProgramWithVertexShader:shaderDinh andFragmentShader:shaderDiemAnh];
   
   // need to do this before linking
   glBindAttribLocation(soChuongTrinhVe, ATTRIB_DINH, "dinh");
   glBindAttribLocation(soChuongTrinhVe, ATTRIB_MAU, "mau");
   //   glBindAttribLocation(shaderProgramArray[GLSL_PROGRAM_FLAT_SHADER], FLAT_SHADER_ATTRIB_VECTO_VOUNG_GOC, "normalVector");
   
	[ToBong linkAndValidateProgram:soChuongTrinhVe];
   
	uniform_MaTranChieu = glGetUniformLocation(soChuongTrinhVe, "maTranChieu");

   //  enable attributes for shaders
   glEnableVertexAttribArray( ATTRIB_DINH );
   glEnableVertexAttribArray( ATTRIB_MAU );
}


#pragma mark ---- Vẽ
// +--------------------------+
// |                          |
// +--------------------------+
- (void)drawRect:(NSRect)dirtyRect; {

/*   float mangDinh[12] = {
      -1.0f, 1.0f,  -1.0f, -1.0f,
      0.0f, 1.0f,  0.0f, -1.0f,
      1.0f, 1.0f,  1.0f, -1.0f}; */

/*   float mangMau[24] = {
      1.0f, 0.0f, 0.0f, 1.0f,   1.0f, 0.0f, 0.0f, 1.0f,
      1.0f, 1.0f, 0.0f, 1.0f,   1.0f, 1.0f, 0.0f, 1.0f,
      1.0f, 1.0f, 1.0f, 1.0f,   1.0f, 1.0f, 1.0f, 1.0f};*/
   
//   unsigned short mangDinhTamGiac[6] = {0, 1, 2, 3, 4, 5};
   [[self openGLContext] makeCurrentContext];
   
   glClear( GL_COLOR_BUFFER_BIT );
   
   glUseProgram(soChuongTrinhVe);
   glUniformMatrix4fv( uniform_MaTranChieu, 1, GL_FALSE, maTranChieu );
   
   // ---- thanh màu tô phần dạng
   glVertexAttribPointer(ATTRIB_DINH, 2, GL_FLOAT, NO, 0, mangThanhMau_dinh );
   glVertexAttribPointer(ATTRIB_MAU, 4, GL_FLOAT, YES, 0, mangThanhMau_mau );
   glDrawArrays(GL_TRIANGLE_STRIP, 0, soLuongMau << 1 );

   // ---- các mũi tên chỉ màu
   glVertexAttribPointer(ATTRIB_DINH, 2, GL_FLOAT, NO, 0, mangTamGiac_dinh );
   glVertexAttribPointer(ATTRIB_MAU, 4, GL_FLOAT, YES, 0, mangTamGiac_mau );
   glDrawArrays(GL_TRIANGLES, 0, (soLuongMau+1) * 3 );  // một tam giác cho màu tập hợp
   
   glVertexAttribPointer(ATTRIB_DINH, 2, GL_FLOAT, NO, 0, cacCotChonMau_dinh );
   glVertexAttribPointer(ATTRIB_MAU, 4, GL_FLOAT, YES, 0, cacCotChonMau_mau );
   glDrawArrays(GL_TRIANGLE_STRIP, 0, 16 );

   glVertexAttribPointer(ATTRIB_DINH, 2, GL_FLOAT, NO, 0, cacTamGiacChonMau_dinh );
   glVertexAttribPointer(ATTRIB_MAU, 4, GL_FLOAT, YES, 0, cacTamGiacChonMau_mau );
   glDrawArrays(GL_TRIANGLES, 0, 9 );

   // ---- chữ nhật chiếu màu
   glVertexAttribPointer(ATTRIB_DINH, 2, GL_FLOAT, NO, 0, chuNhatChieuMau_dinh );
   glVertexAttribPointer(ATTRIB_MAU, 4, GL_FLOAT, YES, 0, chuNhatChieuMau_mau );
   glDrawArrays(GL_TRIANGLE_STRIP, 0, 4 );

   // ---- chữ nhật màu tập hợp
   glVertexAttribPointer(ATTRIB_DINH, 2, GL_FLOAT, NO, 0, chuNhatMauTapHop_dinh );
   glVertexAttribPointer(ATTRIB_MAU, 4, GL_FLOAT, YES, 0, chuNhatMauTapHop_mau );
   glDrawArrays(GL_TRIANGLE_STRIP, 0, 4 );
   
	glFlush();
}

#pragma mark ---- Reshape
- (void) reshape {
	// We draw on a secondary thread through the display link
	// When resizing the view, -reshape is called automatically on the main thread
	// Add a mutex around to avoid the threads accessing the context simultaneously when resizing
	CGLLockContext([[self openGLContext] CGLContextObj]);
	
	NSRect viewRect = [self bounds];
	glViewport(0, 0, viewRect.size.width, viewRect.size.height);
//	viewPortRect = viewRect;
//	viewPortRatio = viewRect.size.height/viewRect.size.width;
   
   // ---- đặt hai ma trận thế giới
//	setOrthographicProjection( maTranVuongTheGioi, -1.0, 1.0, -viewPortRatio, viewPortRatio, -5.0, 5.0 );
//   datMaTranChieuPhoi( maTranChieuPhoi, -0.75f, 0.75f, -0.75*viewPortRatio, 0.75*viewPortRatio, 1.0f, 5.0f);
	
	CGLUnlockContext([[self openGLContext] CGLContextObj]);
}

#pragma mark ---- Chuột
- (void)mouseDown:(NSEvent *)event; {

   CGPoint viTriBam = [event locationInWindow];
   CGRect chuNhatChieu = [self frame];
   
   // ---- tính vị trí tương đối với màn
   viTriBam.x -= chuNhatChieu.origin.x + chuNhatChieu.size.width*0.5f;
   viTriBam.y -= chuNhatChieu.origin.y + chuNhatChieu.size.height*0.5f;

   viTriBam.x /= chuNhatChieu.size.width*0.5f;
   viTriBam.y /= chuNhatChieu.size.height*0.5f;

   // ---- kiếm trả có bấm màu nào (nếu có cái nào)
//   NSLog( @"ChuoiMau: %6.4f %6.4f", viTriBam.x, viTriBam.y );
   diemBamDau = viTriBam;
}

- (void)mouseDragged:(NSEvent *)event; {
   
   CGPoint viTriBam = [event locationInWindow];
   CGRect chuNhatChieu = [self frame];
   
   // ---- tính vị trí tương đối với màn
   viTriBam.x -= chuNhatChieu.origin.x + chuNhatChieu.size.width*0.5f;
   viTriBam.y -= chuNhatChieu.origin.y + chuNhatChieu.size.height*0.5f;
   
   viTriBam.x /= chuNhatChieu.size.width*0.5f;
   viTriBam.y /= chuNhatChieu.size.height*0.5f;

   if( viTriBam.y < 0.1f ) {

      unsigned char diaChi = 0;
   
      while( diaChi < 18 ) {
         BOOL dangKeoNutChinhMau = YES;

         if( diemBamDau.x < cacTamGiacChonMau_dinh[diaChi+2] )
            dangKeoNutChinhMau = NO;
         else if( diemBamDau.x > cacTamGiacChonMau_dinh[diaChi+4] )
            dangKeoNutChinhMau = NO;
         else if( diemBamDau.y < cacTamGiacChonMau_dinh[diaChi+3] )
            dangKeoNutChinhMau = NO;
         else if( diemBamDau.y > cacTamGiacChonMau_dinh[diaChi+1] )
            dangKeoNutChinhMau = NO;
         
         if( dangKeoNutChinhMau ) {
            float cachKeo = viTriBam.x - diemBamDau.x;
            cacTamGiacChonMau_dinh[diaChi] += cachKeo;
            cacTamGiacChonMau_dinh[diaChi+2] += cachKeo;
            cacTamGiacChonMau_dinh[diaChi+4] += cachKeo;
            diemBamDau = viTriBam;
            
            // ---- đừng cho nút đi ra ngoài
            if( cacTamGiacChonMau_dinh[diaChi] < -1.0f + kLE_TRAI ) {
               cacTamGiacChonMau_dinh[diaChi] = -1.0f + kLE_TRAI;
               cacTamGiacChonMau_dinh[diaChi+2] = -1.0f + kLE_TRAI - 0.025f;
               cacTamGiacChonMau_dinh[diaChi+4] = -1.0f + kLE_TRAI + 0.025f;
            }
            else if( cacTamGiacChonMau_dinh[diaChi] > -1.0f + kLE_TRAI + kBE_RONG__COT_CHON_MAU ){
               cacTamGiacChonMau_dinh[diaChi] = -1.0f + kLE_TRAI + kBE_RONG__COT_CHON_MAU;
               cacTamGiacChonMau_dinh[diaChi+2] = -1.0f + kLE_TRAI + kBE_RONG__COT_CHON_MAU - 0.025f;
               cacTamGiacChonMau_dinh[diaChi+4] = -1.0f + kLE_TRAI + kBE_RONG__COT_CHON_MAU + 0.025f;
            }
            
            // ---- nâng cấp màu chọn và chuữ nhật màu
            if( diaChi < 6 ) {// màu đỏ
               mauChon[0] = (cacTamGiacChonMau_dinh[diaChi] - kLE_TRAI + 1.0f)/kBE_RONG__COT_CHON_MAU;
               // ---- cột lục
               cacCotChonMau_mau[24] = mauChon[0];
               cacCotChonMau_mau[28] = mauChon[0];
               cacCotChonMau_mau[32] = mauChon[0];
               cacCotChonMau_mau[36] = mauChon[0];
               // ---- cột xanh
               cacCotChonMau_mau[48] = mauChon[0];
               cacCotChonMau_mau[52] = mauChon[0];
               cacCotChonMau_mau[56] = mauChon[0];
               cacCotChonMau_mau[60] = mauChon[0];
            }
            else if( diaChi < 12 ) {
               mauChon[1] = (cacTamGiacChonMau_dinh[diaChi] - kLE_TRAI + 1.0f)/kBE_RONG__COT_CHON_MAU;
               // ---- cột đỏ
               cacCotChonMau_mau[1] = mauChon[1];
               cacCotChonMau_mau[5] = mauChon[1];
               cacCotChonMau_mau[9] = mauChon[1];
               cacCotChonMau_mau[13] = mauChon[1];
               // ---- cột xanh
               cacCotChonMau_mau[49] = mauChon[1];
               cacCotChonMau_mau[53] = mauChon[1];
               cacCotChonMau_mau[57] = mauChon[1];
               cacCotChonMau_mau[61] = mauChon[1];
            }
            else {
               mauChon[2] = (cacTamGiacChonMau_dinh[diaChi] - kLE_TRAI + 1.0f)/kBE_RONG__COT_CHON_MAU;
               // ---- cột đỏ
               cacCotChonMau_mau[2] = mauChon[2];
               cacCotChonMau_mau[6] = mauChon[2];
               cacCotChonMau_mau[10] = mauChon[2];
               cacCotChonMau_mau[14] = mauChon[2];
               // ---- cột lục
               cacCotChonMau_mau[26] = mauChon[2];
               cacCotChonMau_mau[30] = mauChon[2];
               cacCotChonMau_mau[34] = mauChon[2];
               cacCotChonMau_mau[38] = mauChon[2];
            }

            // ----

//            NSLog( @"soMauDaChon %d   soLuongMau %d", soMauDaChon, soLuongMau );
            if( soMauDaChon < soLuongMau )
               [self datMau:mauChon trongDanhBaTaiSo:soMauDaChon];
            else
               [self datMauTapHop:mauChon];
            
            [self datMauChoChuNhatMau:mauChon];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"星凤NângCấpMàu" object:self];
            // ----
            [self setNeedsDisplay:YES];
            break;
         }
         
         diaChi += 6;  // mỗi tam giác có 3 đỉnh (x; y)

      }

   }

}

- (void)mouseUp:(NSEvent *)event; {
   
   CGPoint viTriBam = [event locationInWindow];
   CGRect chuNhatChieu = [self frame];
   
   // ---- tính vị trí tương đối với màn
   viTriBam.x -= chuNhatChieu.origin.x + chuNhatChieu.size.width*0.5f;
   viTriBam.y -= chuNhatChieu.origin.y + chuNhatChieu.size.height*0.5f;
   
   viTriBam.x /= chuNhatChieu.size.width*0.5f;
   viTriBam.y /= chuNhatChieu.size.height*0.5f;
   
   if( daKeoChuot ) {
      daKeoChuot = NO;
      
   }
   else {  // ---- chọn màu từ danh bạ
//      NSLog( @"viTriBam %5.3f %5.3f", viTriBam.x, viTriBam.y );
      if( viTriBam.y < 0.1f ) {   // vùng cho các cột chỉnh màu
         // ---- xem có bấm trên cột àu không
         unsigned short diaChi = 0;
         unsigned short diaChiCuoi = (soLuongMau + 1) * 12; // thêm một tam giac cho màu tập hợp
         while( diaChi < diaChiCuoi ) {
            
            BOOL bamTrongCot = YES;
            
            if( viTriBam.x < cacCotChonMau_dinh[diaChi] - 0.025f )
               bamTrongCot = NO;
            else if( diemBamDau.x > cacCotChonMau_dinh[diaChi+4] + 0.025f )
               bamTrongCot = NO;
            else if( diemBamDau.y < cacCotChonMau_dinh[diaChi+3] - 0.1f )
               bamTrongCot = NO;
            else if( diemBamDau.y > cacCotChonMau_dinh[diaChi+1] + 0.025f )
               bamTrongCot = NO;
            
            if( bamTrongCot ) {
               float giaTri = (viTriBam.x - kLE_TRAI + 1.0f)/kBE_RONG__COT_CHON_MAU;
               
               // ---- không cho gía trị ra ngoài với hàng
               if( giaTri > 1.0f )
                  giaTri = 1.0f;
               else if( giaTri < 0.0f )
                  giaTri = 0.0f;
               
               if( diaChi == 0 ) {
                  mauChon[0] = giaTri;
               }
               else if ( diaChi == 12 ) {
                  mauChon[1] = giaTri;

               }
               else {
                  mauChon[2] = giaTri;

               }
               [[NSNotificationCenter defaultCenter] postNotificationName:@"星凤NângCấpMàu" object:self];
               
               // ----
               [self datMauChoChuNhatMau:mauChon];
               [self choCacCotMau:mauChon];
               
               // ----
               if( soMauDaChon < soLuongMau )
                  [self datMau:mauChon trongDanhBaTaiSo:soMauDaChon];
               else
                  [self datMauTapHop:mauChon];
               // ----
               [self setNeedsDisplay:YES];
               break;
            }
            diaChi += 12;
         }

      }
      else {   // danh bạ màu

         BOOL bamTrongNut = NO;

         unsigned short diaChi = 0;
         unsigned short diaChiCuoi = (soLuongMau + 1) * 6;  // thêm một tam giác chp màu tập hợp
         while( diaChi < diaChiCuoi ) {
            bamTrongNut = YES;
            
            if( diemBamDau.x < mangTamGiac_dinh[diaChi+2] )
               bamTrongNut = NO;
            else if( diemBamDau.x > mangTamGiac_dinh[diaChi+4] )
               bamTrongNut = NO;
            else if( diemBamDau.y < mangTamGiac_dinh[diaChi+3] )
               bamTrongNut = NO;
            else if( diemBamDau.y > mangTamGiac_dinh[diaChi+1] )
               bamTrongNut = NO;
            
            if( bamTrongNut ) {
               
               if( soMauDaChon != diaChi /6 ) {  // nếu bấm trên số màu đang chọn rồi không cần làm gi cả
                  // ----
                  float mauXam[] = {0.5f, 0.5f, 0.5f, 1.0f};
                  [self choTamGiac:soMauDaChon mau:mauXam];
                  // ---- số màu mới chọn
                  soMauDaChon = diaChi / 6;
                  float mauXanh[] = {0.0f, 0.0f, 1.0f, 1.0f};
                  [self choTamGiac:soMauDaChon mau:mauXanh];
                  
                  // ---- tô các cột và chữ nhật màu
                  if( soMauDaChon < soLuongMau ) {
                     diaChi = soMauDaChon << 3;
                     //            NSLog( @"ChuoiMau: mouseUp: %d" );
                     mauChon[0] = mangThanhMau_mau[diaChi];
                     mauChon[1] = mangThanhMau_mau[diaChi+1];
                     mauChon[2] = mangThanhMau_mau[diaChi+2];
                     mauChon[3] = mangThanhMau_mau[diaChi+3];
                  }
                  else {
                     mauChon[0] = chuNhatMauTapHop_mau[0];
                     mauChon[1] = chuNhatMauTapHop_mau[1];
                     mauChon[2] = chuNhatMauTapHop_mau[2];
                     mauChon[3] = chuNhatMauTapHop_mau[3];
                  }
                  
                  // ---- nâng cấp tam giác chiếu
                  [self datMauChoChuNhatMau:mauChon];

                  // ---- nâng cấp cột các màu
                  [self choCacCotMau:mauChon];
                  [self setNeedsDisplay:YES];
               }
               break;
            }
            
            diaChi += 6;  // mỗi tam giác có 3 đỉnh (x; y)
         }

         if( [event clickCount] > 1 && !bamTrongNut) {   // ---- tạo màu mới trong danh bạ
 //              NSLog( @"ChuoiMau: mouseUp: bamHaiLan %5.3f", viTriBam.x );
 //           viTriBam.x += kLE_TRAI;
            viTriBam.x /= kBE_RONG__DANH_BA_MAU;
            viTriBam.x += 0.5f;
            if( (viTriBam.x > 0.0f) && (viTriBam.x < 1.0f) ) {
               
               float cachGiuaMau = 1.0f/(float)(soLuongMau - 1);
               // ---- tô màu tam giác cho cột thành phần màu này
               float mauDen[] = {0.0f, 0.0f, 0.0f, 1.0f};
               [self choTamGiac:soMauDaChon mau:mauDen];
               // ---- số màu mới lập
               soMauDaChon = (int)(viTriBam.x/cachGiuaMau) + 1;
               // ---- báo cần chèn màu mới
               [[NSNotificationCenter defaultCenter] postNotificationName:@"星凤ChènMàuMới" object:self];
            }
         }
      }
   }
}

#pragma mark ---- Màu Nút (Tam Giác) Chuổi Màu
- (void)choTamGiac:(unsigned char)soTamGiac mau:(float *)mau; {
   
   unsigned short diaChi = soTamGiac * 12;
   mangTamGiac_mau[diaChi] = mau[0];
   mangTamGiac_mau[diaChi + 1] = mau[1];
   mangTamGiac_mau[diaChi + 2] = mau[2];
   mangTamGiac_mau[diaChi + 3] = mau[3];
   mangTamGiac_mau[diaChi + 4] = mau[0] + 0.3f;
   mangTamGiac_mau[diaChi + 5] = mau[1] + 0.3f;
   mangTamGiac_mau[diaChi + 6] = mau[2] + 0.3f;
   mangTamGiac_mau[diaChi + 7] = mau[3];
   mangTamGiac_mau[diaChi + 8] = mau[0] + 0.3f;
   mangTamGiac_mau[diaChi + 9] = mau[1] + 0.3f;
   mangTamGiac_mau[diaChi + 10] = mau[2] + 0.3f;
   mangTamGiac_mau[diaChi + 11] = mau[3];
}


#pragma mark ---- Màu Cho Chữ Nhật Màu
- (void)datMauChoChuNhatMau:(float *)mau; {

   chuNhatChieuMau_mau[0] = mau[0];
   chuNhatChieuMau_mau[1] = mau[1];
   chuNhatChieuMau_mau[2] = mau[2];
   chuNhatChieuMau_mau[3] = mau[3];
   chuNhatChieuMau_mau[4] = mau[0];
   chuNhatChieuMau_mau[5] = mau[1];
   chuNhatChieuMau_mau[6] = mau[2];
   chuNhatChieuMau_mau[7] = mau[3];
   chuNhatChieuMau_mau[8] = mau[0];
   chuNhatChieuMau_mau[9] = mau[1];
   chuNhatChieuMau_mau[10] = mau[2];
   chuNhatChieuMau_mau[11] = mau[3];
   chuNhatChieuMau_mau[12] = mau[0];
   chuNhatChieuMau_mau[13] = mau[1];
   chuNhatChieuMau_mau[14] = mau[2];
   chuNhatChieuMau_mau[15] = mau[3];
}

#pragma mark ---- Màu Cho Chữ Màu
- (void)datMauTapHop:(float *)mau; {
   
   chuNhatMauTapHop_mau[0] = mau[0];
   chuNhatMauTapHop_mau[1] = mau[1];
   chuNhatMauTapHop_mau[2] = mau[2];
   chuNhatMauTapHop_mau[3] = mau[3];
   chuNhatMauTapHop_mau[4] = mau[0];
   chuNhatMauTapHop_mau[5] = mau[1];
   chuNhatMauTapHop_mau[6] = mau[2];
   chuNhatMauTapHop_mau[7] = mau[3];
   chuNhatMauTapHop_mau[8] = mau[0];
   chuNhatMauTapHop_mau[9] = mau[1];
   chuNhatMauTapHop_mau[10] = mau[2];
   chuNhatMauTapHop_mau[11] = mau[3];
   chuNhatMauTapHop_mau[12] = mau[0];
   chuNhatMauTapHop_mau[13] = mau[1];
   chuNhatMauTapHop_mau[14] = mau[2];
   chuNhatMauTapHop_mau[15] = mau[3];
}


#pragma mark ---- Đặt Màu Cho Các Cột Chọn Màu
- (void)choCacCotMau:(float *)mau {

   // ---- cột lục
   cacCotChonMau_mau[24] = mau[0];
   cacCotChonMau_mau[28] = mau[0];
   cacCotChonMau_mau[32] = mau[0];
   cacCotChonMau_mau[36] = mau[0];
   // ---- cột xanh
   cacCotChonMau_mau[48] = mau[0];
   cacCotChonMau_mau[52] = mau[0];
   cacCotChonMau_mau[56] = mau[0];
   cacCotChonMau_mau[60] = mau[0];

   // ---- cột đỏ
   cacCotChonMau_mau[1] = mau[1];
   cacCotChonMau_mau[5] = mau[1];
   cacCotChonMau_mau[9] = mau[1];
   cacCotChonMau_mau[13] = mau[1];
   // ---- cột xanh
   cacCotChonMau_mau[49] = mau[1];
   cacCotChonMau_mau[53] = mau[1];
   cacCotChonMau_mau[57] = mau[1];
   cacCotChonMau_mau[61] = mau[1];

   // ---- cột đỏ
   cacCotChonMau_mau[2] = mau[2];
   cacCotChonMau_mau[6] = mau[2];
   cacCotChonMau_mau[10] = mau[2];
   cacCotChonMau_mau[14] = mau[2];
   // ---- cột lục
   cacCotChonMau_mau[26] = mau[2];
   cacCotChonMau_mau[30] = mau[2];
   cacCotChonMau_mau[34] = mau[2];
   cacCotChonMau_mau[38] = mau[2];
   
   // ---- đặt vị trí các tam giác của ba cột
   float viTriTamGiac = mauChon[0]*kBE_RONG__COT_CHON_MAU - 1.0f + kLE_TRAI;
   cacTamGiacChonMau_dinh[0] = viTriTamGiac;
   cacTamGiacChonMau_dinh[2] = viTriTamGiac - 0.025f;
   cacTamGiacChonMau_dinh[4] = viTriTamGiac + 0.025f;

   viTriTamGiac = mauChon[1]*kBE_RONG__COT_CHON_MAU - 1.0f + kLE_TRAI;
   cacTamGiacChonMau_dinh[6] = viTriTamGiac;
   cacTamGiacChonMau_dinh[8] = viTriTamGiac - 0.025f;
   cacTamGiacChonMau_dinh[10] = viTriTamGiac + 0.025f;

   viTriTamGiac = mauChon[2]*kBE_RONG__COT_CHON_MAU - 1.0f + kLE_TRAI;
   cacTamGiacChonMau_dinh[12] = viTriTamGiac;
   cacTamGiacChonMau_dinh[14] = viTriTamGiac - 0.025f;
   cacTamGiacChonMau_dinh[16] = viTriTamGiac + 0.025f;
}

#pragma mark ---- Đặt Màu Trong Danh Ba
- (void)datMau:(float *)mau trongDanhBaTaiSo:(unsigned char)soTrongDanhBa; {
   
   unsigned short diaChi = soTrongDanhBa << 3;
   mangThanhMau_mau[diaChi] = mau[0];
   mangThanhMau_mau[diaChi+1] = mau[1];
   mangThanhMau_mau[diaChi+2] = mau[2];
   mangThanhMau_mau[diaChi+3] = mau[3];
   mangThanhMau_mau[diaChi+4] = mau[0];
   mangThanhMau_mau[diaChi+5] = mau[1];
   mangThanhMau_mau[diaChi+6] = mau[2];
   mangThanhMau_mau[diaChi+7] = mau[3];
}


#pragma mark ---- Kiểm Tra
- (char)kiemTraSoMauTuVTri:(CGPoint)viTri; {
   
   if( viTri.y < 0.1f ) {
      NSLog( @"ChuoiMau: kiemTra: Chỉnh Màu  viTri" );
      // ---- nếu đang kéo giá trị màu
      
   }
   else {
      NSLog( @"ChuoiMau: kiemTra: Chón Màu" );
   }
   char soMau = -1;
   unsigned short soNut = 0;
   unsigned short diaChi = 0;
   while ( soNut < soLuongMau ) {
      BOOL oTrong = YES;   // ở trong
      if( viTri.x < mangTamGiac_dinh[diaChi+2] )
         oTrong = NO;
      else if( viTri.x > mangTamGiac_dinh[diaChi + 4])
         oTrong = NO;
      else if( viTri.y > mangTamGiac_dinh[diaChi+1] )
         oTrong = NO;
      else if( viTri.y < mangTamGiac_dinh[diaChi+3])
         oTrong = NO;
      
      if( oTrong ) {
         soMau = soNut;
         break;
      }

      soNut++;
      diaChi += 6;
   }

   return soMau;
}

#pragma mark --- Bàn Phím
- (BOOL)acceptsFirstResponder; {
   return YES;
}

- (void)keyDown:(NSEvent *)event; {
//   NSLog( @"ChuoiMau: keyDown: %d", [event keyCode] );
   if( [event keyCode] == 51 ) {
      [[NSNotificationCenter defaultCenter] postNotificationName:@"星凤BỏMàu" object:self];
   }
   else {
      huong = [event keyCode];
      if( [event modifierFlags] & NSShiftKeyMask )
         phimShift = YES;
      else
         phimShift = NO;

      [[NSNotificationCenter defaultCenter] postNotificationName:@"星凤DiChuyển" object:self];
   }
}


#pragma mark ---- Chép/Dáng/Cắt
// ---- phải dùng tên này
- (IBAction)copy:(id)sender; {
   
   NSColor *mau = [NSColor colorWithCalibratedRed:mauChon[0] green:mauChon[1] blue:mauChon[2] alpha:mauChon[3]];
   
   if (mau != NULL) {
      NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
      [pasteboard clearContents];
      NSArray *vatChep = [NSArray arrayWithObject:mau];
      [pasteboard writeObjects:vatChep];
   }
}

// ---- phải dùng tên này
- (IBAction)paste:(id)sender; {
   
   NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
   NSArray *classArray = [NSArray arrayWithObject:[NSColor class]];
   
   NSDictionary *options = [NSDictionary dictionary];
   
   BOOL ok = [pasteboard canReadObjectForClasses:classArray options:options];
   if (ok) {
      NSArray *objectsToPaste = [pasteboard readObjectsForClasses:classArray options:options];
      NSColor *mau = [objectsToPaste objectAtIndex:0];
      float mauMoi[4];
      mauMoi[0] = [mau redComponent];
      mauMoi[1] = [mau greenComponent];
      mauMoi[2] = [mau blueComponent];
      mauMoi[3] = [mau alphaComponent];

      [toMau thayMau:mauMoi choSo:soMauDaChon];
      [self datMau:toMau];
      [self setNeedsDisplay:YES];
   }
}

// ---- phải dùng tên này
- (IBAction)cut:(id)sender; {

   NSColor *mau = [NSColor colorWithCalibratedRed:mauChon[0] green:mauChon[1] blue:mauChon[2] alpha:mauChon[3]];
   
   if (mau != NULL) {
      NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
      [pasteboard clearContents];
      NSArray *vatChep = [NSArray arrayWithObject:mau];
      [pasteboard writeObjects:vatChep];
      
      [toMau boMauTaiChiSo:soMauDaChon];
      [self datMau:toMau];
      [self setNeedsDisplay:YES];
   }
}

#pragma mark ---- Biến
@synthesize soMauDaChon;
@synthesize soLuongMau;

- (float *)mauChon; {
   return mauChon;
}

@synthesize huong;
@synthesize phimShift;

@end
