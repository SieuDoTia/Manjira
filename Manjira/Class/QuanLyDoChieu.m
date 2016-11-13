//
//  QuanLyDoChieu.m
//  Manjira
//
//  Created by 小小 on 20/11/2556.
//
// ---- để tính cần:
// (x; y) góc vùng tính
// bước
// bè rộng và bề cao vùng tính
// mang số lặp lại cho giữ kết qủa
// giải thuật tính
//
//                 bề rộng
//              +--------------------+
//              +--------------------+ --
//              +--------------------+  ^
//              +--------------------+  | số lượng hàng
//              +--------------------+  v
// số hàng -->  +--------------------+ --
//              +--------------------+  bề cao
//              +--------------------+
//      góc --> +--------------------+
//

#import "QuanLyDoChieu.h"
#import "ChieuPhanDang.h"
#import "ManThanhMau.h"

#import "ThongTinPhanDang.h"

#import "TinhPhanDang1x1.h"
#import "TinhLaiPhanDang1x1.h"
#import "TinhPhanDang4x4.h"

#import "ToMau.h"
#import "ToMauPhanDang1x1.h"
#import "ToMauPhanDang4x4.h"

#import "GiaiThuat_MJ_2.h"
#import "GiaiThuat_MJ_3.h"
#import "GiaiThuat_MJ_4.h"
#import "GiaiThuat_MJ_5.h"
#import "GiaiThuat_MJ_PhanSo.h"
#import "GiaiThuat_MJ_Cosh.h"
#import "GiaiThuat_MJ_Exp.h"

#import "LuuHoaTietPNG.h"
#import "LuuEXR.h"
#import "ExrHalf.h"
#import "CacKho.h"
#import "HangSoManjira.h"


#define kBUOC_PHONG_TO 0.9

#define kTAP_TIN__EXR_HALF  0
#define kTAP_TIN__EXR_FLOAT 1
#define kTAP_TIN__PNG_8     2
#define kTAP_TIN__PNG_16    3

@interface QuanLyDoChieu ()

@end

@implementation QuanLyDoChieu
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil; {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
       
    }
    
    return self;
}
*/

- (void)awakeFromNib; {
   
//   if( toMau )
//      return;   // <------- Phải làm này khi dùng loadNib
   // ----
   [[[NSApplication sharedApplication] mainWindow] setTitle:@"マンジラ"];

   // ---- mặc định
   [self datMacDinh];

   // ---- phần dạng Mandelbrot chiếu
   [thongTinPhanDangChieu setSoLapLaiToiDa:soLuongLap];
   
   // ---- queue
   queueTinhPhanDang = [[NSOperationQueue alloc] init];
   
   [vanBanSoLapLai setStringValue:[NSString stringWithFormat:@"%d", 200]];
   [vanBanMuGiaiThuat setStringValue:[NSString stringWithFormat:@"%5.3f", 2.0f]];
   [vanBanMuGiaiThuat setEnabled:NO];

   [vanBanMuMau setStringValue:[NSString stringWithFormat:@"%3.1f", 0.5f]];
   [vanBanDich setStringValue:[NSString stringWithFormat:@"%d", 0]];
   [vanBanChuTrinhMau setStringValue:[NSString stringWithFormat:@"%d", 200]];
   
   // ----
   [vanBanSoLapLai setDelegate:self];
   [vanBanMuGiaiThuat setDelegate:self];

   [vanBanChuTrinhMau setDelegate:self];
   [vanBanMuMau setDelegate:self];
   [vanBanDich setDelegate:self];
   
   [vanBanX setDelegate:self];
   [vanBanY setDelegate:self];
   [vanBanPhongTo setDelegate:self];

   // ---- lời bán đời nhận
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phongTo:) name:@"星凤BấmĐiểm" object:NULL];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chinhMauVaVeLai:) name:@"星凤NângCấpMàu" object:NULL];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(boMau:) name:@"星凤BỏMàu" object:NULL];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chenMau:) name:@"星凤ChènMàuMới" object:NULL];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(diChuyen:) name:@"星凤DiChuyển" object:NULL];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keoMan:) name:@"星凤KéoMàn" object:NULL];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nangCapTua:) name:@"星凤HoạtĐộngLại" object:NULL];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dangDauChuongTrinh:) name:@"星凤DấuChươngTrình" object:NULL];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nangCapAnhChieu:) name:@"星凤NângCấpẢnhChiếu" object:NULL];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nangCapAnhXuat:) name:@"星凤NângCấpẢnhXuất" object:NULL];

   // ---- đặt giải thuật
   soGiaiThuat = GIAI_THUAT__MAN_MU_2;
   giaiThuat = [[GiaiThuat_MJ_2 alloc] init];
   [nutGiaiThuat selectItemAtIndex:soGiaiThuat];
   
   // ---- dạng ảnh mặc định
   thuTapTin = kTAP_TIN__EXR_HALF;
   [nutChonDangAnh selectItemAtIndex:kTAP_TIN__EXR_HALF];

   // ---- khổ mặc định
   soCoThuoc = 3;
   [nutChonCoThuoc selectItemAtIndex:soCoThuoc];
   [CacKho choAnhTinhBeRong:&beRongAnhTinh vaBeCao:&beCaoAnhTinh choSo:soCoThuoc];
   
   // ---- đặt bề rộng và bề cao cho ảnh chiếu trên màn
   __block unsigned short beCaoChieu;
   __block unsigned short beRongChieu;
   // ---- dùng block (cục) để đời cho chieuPhanDang xuất hiện
   dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^{
      // wait for the outline view to become set on a seperate thread. Do this off the main thread otherwise we would block the UI (spinning beach ball) which we don't want.
      while( !chieuPhanDang ) {
         //            NSLog(@"-nangCapThongTinDacDiem: waiting for outline view! ");
         [NSThread sleepForTimeInterval:1];
      }
      dispatch_async( dispatch_get_main_queue(), ^{

         beCaoChieu = [chieuPhanDang beCao];
         beRongChieu = ((float)beCaoChieu/(float)beCaoAnhTinh)*beRongAnhTinh;
         
         // ---- cho chiếu ảnh của phần dạng
         [chieuPhanDang setBeRong:beRongChieu];
         [chieuPhanDang setBeCao:beCaoChieu];
   
         // ---- chuẩn bị các mảng để tíng phần dạng
         [self chuanBiCacMangChieuBeRong:beRongChieu beCao:beCaoChieu];
         [thongTinPhanDangChieu datMangMau:mangAnhChieu mangSoLuongLapLai:mangSoLapLaiChieu vaSoLuongDiem:beRongChieu * beCaoChieu];
         
         // ---- chiếu gía trị mặc định
         [vanBanX setStringValue:[NSString stringWithFormat:@"%15.13f", -0.7] ];
         [vanBanY setStringValue:[NSString stringWithFormat:@"%15.13f", 0.0] ];
         [vanBanPhongTo setStringValue:[NSString stringWithFormat:@"%10.7E", 2.0] ];
         
         // ---- không cho đổi giá trị
         [vanBanRong setEnabled:NO];
         [vanBanCao setEnabled:NO];
         
         // ---- đặt màn chiếu phần dạng
         [[[NSApplication sharedApplication] mainWindow] makeFirstResponder:chieuPhanDang];
      });
   });

   dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^{
      // wait for the outline view to become set on a seperate thread. Do this off the main thread otherwise we would block the UI (spinning beach ball) which we don't want.
      while( !manThanhMau ) {
         //            NSLog(@"-nangCapThongTinDacDiem: waiting for outline view! ");
         [NSThread sleepForTimeInterval:1];
      }
      dispatch_async( dispatch_get_main_queue(), ^{
         // do this on the main thread because you're interacting with UI. All UI interaction must be done on main thread.

         
         // ---- thông tin mặc định cho phân dạng chiếu trên màn
         thongTinPhanDangChieu = [[ThongTinPhanDang alloc] initChoTrungTamX:-0.7 y:0.0 phongTo:2.0 beRong:beRongChieu beCao:beCaoChieu lapLaiToiDa:200 mangMau:mangAnhChieu mangSoLapLai:mangSoLapLaiChieu];
         
         // ---- thông tin mặc định cho phân dạng chiếu trên màn
         thongTinPhanDangXuat = [[ThongTinPhanDang alloc] initChoTrungTamX:-0.7 y:0.0 phongTo:2.0 beRong:beRongAnhTinh beCao:beCaoAnhTinh lapLaiToiDa:200 mangMau:mangAnhChieu mangSoLapLai:mangSoLapLaiTinh];
         
         // ---- cho chiếu danh bạ màu, PHẢI LÀM SAU chuẩn bị thongTinPhanDangChieu
         [manThanhMau datMau:[thongTinPhanDangChieu toMau]];

         // ---- bắt đầu tính cho chiếu trên màn
         [self batDauTinhAnhChieu];

      });
   });
}

- (void)datMacDinh; {

   // ---- coi chừng đang chiếu phân dạng Julia
   if( [thongTinPhanDangChieu tinhJulia] )
      [thongTinPhanDangChieu doiTrungTamX:0.0 y:0.0 vaPhongTo:2.0];
   else  // đang chiếu phần dạng Mandelbrot
      [thongTinPhanDangChieu doiTrungTamX:-0.7 y:0.0 vaPhongTo:2.0];
   
   soLuongLap = 200;
}

- (void)chuanBiCacMangChieuBeRong:(unsigned int)beRong beCao:(unsigned int)beCao; {//ChoAnhRong:(unsigned short)beRong cao:(unsigned short)beCao; {

   if( mangAnhChieu )
      free( mangAnhChieu );
   if( mangSoLapLaiChieu )
      free( mangSoLapLaiChieu );

//   NSLog( @"QLDoChieu: chuanBiMang: beRongAnhChieu %d * beCaoAnhChieu %d = %d  %d", beRong, beCao, beRong * beCao, beRong * beCao << 2 );
   // ---- xoá hết
   mangAnhChieu = calloc( beRong * beCao << 2, sizeof( float ) );
   mangSoLapLaiChieu = calloc( beRong * beCao, sizeof( unsigned int ));
}


- (void)chuanBiCacMangTinhBeRong:(unsigned int)beRong beCao:(unsigned int)beCao; {//ChoAnhRong:(unsigned short)beRong cao:(unsigned short)beCao; {
   
   // ---- tính bề rộng ảnh chiếu
   //   tiSoChieu = (float)beRong/(float)beCao;
   
   if( mangAnhTinh )
      free( mangAnhTinh );
   if( mangSoLapLaiTinh )
      free( mangSoLapLaiTinh );
   
//   NSLog( @"QLDoChieu: chuanBiMang: beRongAnhTinh %d * beCaoAnhTinh %d = %d  %d", beRong, beCao, beRong * beCao, beRong * beCao << 2 );
   // ---- xoá hết
   mangAnhTinh = calloc( beRong * beCao << 2, sizeof( float ) );
   mangSoLapLaiTinh = calloc( beRong * beCao << 2, sizeof( unsigned int ) );
}

- (void)batDauTinhAnhXuat; {
   
   // ---- đặt lại = 0, phải tính từ đầu
   [thongTinPhanDangXuat setSoHangDangTinh:0];

   // ---- tính ảnh xuất (độ phần giải cao)
   [self nangCapAnhXuat:NULL];
}

- (void)batDauTinhAnhChieu; {
   
   // ---- đặt lại = 0, phải tính từ đầu
   [thongTinPhanDangChieu setSoHangDangTinh:0];
   
   // ---- cho khi đỗi số lượng lặp lại
   if( [thongTinPhanDangXuat tinhLaiSoLapLai] )
      [self tinhLai_1x1:NULL];
   
   // ----- tính cho màn chiếu

   [self nangCapAnhChieu:NULL];
}

//   
#pragma mark ---- Phóng To Khi Bấm Chuột
- (void)phongTo:(NSNotification *)loiBao; {
   
   CGPoint viTriTuongDoi = [[loiBao object] viTriBamTuongDoi];
//   luongBam++;  // ----

   double tiSoPhongTo = 1.0;
   if( [[loiBao object] phimShift] )
      tiSoPhongTo /= kBUOC_PHONG_TO;
   else
      tiSoPhongTo *= kBUOC_PHONG_TO;

   // ---- chuẩn bị tính
   [thongTinPhanDangChieu tiSoPhongTo:tiSoPhongTo quangDiemX:(double)viTriTuongDoi.x y:(double)viTriTuongDoi.y];

   // ---- tiến giao diện
   [vanBanX setStringValue:[NSString stringWithFormat:@"%15.13f", [thongTinPhanDangChieu  trungTamX]] ];
   [vanBanY setStringValue:[NSString stringWithFormat:@"%15.13f", [thongTinPhanDangChieu  trungTamY]] ];
   [vanBanPhongTo setStringValue:[NSString stringWithFormat:@"%10.7E", [thongTinPhanDangChieu phongTo] ] ];

   [thongTinPhanDangChieu setTinhLaiSoLapLai:NO];
   [self batDauTinhAnhChieu];
}

#pragma mark ---- Tính Tiếp
- (void)tinhLai_1x1:(id)sender; {

   // ---- chỉ tính nếu còn hàng để tính
   if( [thongTinPhanDangChieu soHangDangTinh] < [thongTinPhanDangChieu beCao] ) {
      TinhLaiPhanDang1x1 *tinhLaiPhanDang1x1 = [[TinhLaiPhanDang1x1 alloc] initVoiThongTinPhanDang:thongTinPhanDangChieu
                                                                                       soLuongHang:8];
      [tinhLaiPhanDang1x1 setGiaiThuat:giaiThuat];
      [queueTinhPhanDang addOperation:tinhLaiPhanDang1x1];
      // ---- cộng thêm số lượng hàng cho
      [thongTinPhanDangChieu congThemVpoiSoHangDangTinh:8];
   }
   else // đã tính toàn bộ xong
      tinhAnh = NO;
}

#pragma mark ---- Nâng Cấp Ảnh
- (void)nangCapAnhChieu:(NSNotification *)loiBao; {
   
   if( loiBao != NULL ) {
      TinhPhanDang1x1 *tinhPhanDang1x1 = [loiBao object];
      
      ToMauPhanDang *toMauPhanDang = [[ToMauPhanDang alloc] initChoSoHang:[tinhPhanDang1x1 soHang]
                                                          soLuongHang:[tinhPhanDang1x1 soLuongHang] thongTinPhanDang:thongTinPhanDangChieu chieuPhanDang:chieuPhanDang];
      [[NSOperationQueue mainQueue] addOperation:toMauPhanDang];
   }

   if( [thongTinPhanDangChieu soHangDangTinh] < [thongTinPhanDangChieu beCao] ) {
      
      // ---- xem được nghỉ chưa
      if( [thongTinPhanDangChieu soLuongDiemDaTinh] < [thongTinPhanDangChieu soLuongDiem] ) {
         // ---- tính một khúc nữa
         TinhPhanDang1x1 *tinhPhanDang1x1 = [[TinhPhanDang1x1 alloc] initVoiThongTinPhanDang:thongTinPhanDangChieu
                                                                                 soLuongHang:8];
         [tinhPhanDang1x1 setGiaiThuat:giaiThuat];
         [queueTinhPhanDang addOperation:tinhPhanDang1x1];
         [thongTinPhanDangChieu congThemVpoiSoHangDangTinh:8];
      }
   }
   else {
      TinhLaiPhanDang1x1 *tinhLaiPhanDang1x1 = [loiBao object];
      
      ToMauPhanDang *toMauPhanDang = [[ToMauPhanDang alloc] initChoSoHang:[tinhLaiPhanDang1x1 soHang]
                                                          soLuongHang:[tinhLaiPhanDang1x1 soLuongHang] thongTinPhanDang:thongTinPhanDangChieu chieuPhanDang:chieuPhanDang];
      [[NSOperationQueue mainQueue] addOperation:toMauPhanDang];
      
      // ---- xem được nghỉ chưa
      if( [thongTinPhanDangChieu soLuongDiemDaTinh] < [thongTinPhanDangChieu soLuongDiem] ) {
         // ---- tính một khúc nữa
         [self tinhLai_1x1:NULL];
      }
   }

}


- (void)nangCapAnhXuat:(id)loiBao; {

   // ---- tô màu
   if( loiBao != NULL ) {
      TinhPhanDang4x4 *tinhPhanDang4x4 = [loiBao object];
      ToMauPhanDang4x4 *toMauPhanDang4x4 = [[ToMauPhanDang4x4 alloc] initChoSoHang:[tinhPhanDang4x4 soHang]
                                                                   soLuongHang:[tinhPhanDang4x4 soLuongHang] thongTinPhanDang:thongTinPhanDangXuat];
      [[NSOperationQueue mainQueue] addOperation:toMauPhanDang4x4];
   }
   
   if( [thongTinPhanDangXuat soHangDangTinh] < [thongTinPhanDangXuat beCao] ) {
      
      // ---- xem được nghỉ chưa
      if( [thongTinPhanDangXuat soLuongDiemDaTinh] < [thongTinPhanDangXuat soLuongDiem] ) {
         // ---- tính một khúc nữa
         // ---- chỉ tính nếu còn hàng để tính
         if( [thongTinPhanDangXuat soHangDangTinh] < [thongTinPhanDangXuat beCao] ) {
            TinhPhanDang4x4 *tinhPhanDang4x4 = [[TinhPhanDang4x4 alloc] initVoiThongTinPhanDang:thongTinPhanDangXuat soLuongHang:16];
            [tinhPhanDang4x4 setGiaiThuat:giaiThuat];
            [queueTinhPhanDang addOperation:tinhPhanDang4x4];
            [thongTinPhanDangXuat congThemVpoiSoHangDangTinh:16];
         }
      }

      // ---- nâng cấp tựa
      float tiSoTinhXong = ((float)([thongTinPhanDangXuat soHangDangTinh] - 16)/ (float)[thongTinPhanDangXuat beCao])*100.0f;
      NSString *tuaCuaSo = [NSString stringWithFormat:@"マンジラ: %d/%d  (%5.3f%%)", [thongTinPhanDangXuat soHangDangTinh] - 16, [thongTinPhanDangXuat beCao], tiSoTinhXong];
      [[[NSApplication sharedApplication] mainWindow] setTitle:tuaCuaSo];
   }
   else {
      dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^{
         // wait for the outline view to become set on a seperate thread. Do this off the main thread otherwise we would block the UI (spinning beach ball) which we don't want.
         while( [[NSOperationQueue mainQueue] operationCount] ) {
            NSLog(@" [[NSOperationQueue mainQueue] operationCount] %ld", [[NSOperationQueue mainQueue] operationCount] );
            [NSThread sleepForTimeInterval:1];
         }
         dispatch_async( dispatch_get_main_queue(), ^{
            // do this on the main thread because you're interacting with UI. All UI interaction must be done on main thread.
            NSLog(@" [[NSOperationQueue mainQueue] operationCount] %ld", [[NSOperationQueue mainQueue] operationCount] );
            tinhAnh = NO;
            if( thuTapTin == kTAP_TIN__PNG_8 ) {
               [self luuPNG_8];
            }
            else if( thuTapTin == kTAP_TIN__PNG_16 ) {
               [self luuPNG_16];
            }
            else if( thuTapTin == kTAP_TIN__EXR_HALF ) {
               [self luuEXR_half];
            }
            else if( thuTapTin == kTAP_TIN__EXR_FLOAT ) {
               [self luuEXR_float];
            }
            // --- đặt lại tựa nút
            [nutTinhAnh setTitle:@"Xuất"];
            
 //           [vanBanSoLapLai setEnabled:YES];
//            if( soGiaiThuat == GIAI_THUAT__MAN_MU_PHAN_SO )
//               [vanBanMuGiaiThuat setEnabled:YES];
            
//            [vanBanChuTrinhMau setEnabled:YES];
//            [vanBanMuMau setEnabled:YES];
//            [vanBanX setEnabled:YES];
//            [vanBanY setEnabled:YES];
//            [vanBanPhongTo setEnabled:YES];
//            [vanBanRong setEnabled:YES];
//            [vanBanCao setEnabled:YES];
//            [vanBanDich setEnabled:YES];
//            [nutChonCoThuoc setEnabled:YES];
//            [nutGiaiThuat setEnabled:YES];
            
            NSString *tuaCuaSo = [NSString stringWithFormat:@"マンジラ：終わりました！ (%@)",
                                  NSLocalizedString( @"Xong", @"Khi tính ảnh xong") ];
            [[[NSApplication sharedApplication] mainWindow] setTitle:tuaCuaSo];
            
         });
      });
      
   }

}


- (void)tinhTiepSoLapLai:(id)sender; {

   // ---- xem được nghỉ chưa
   if( [thongTinPhanDangChieu soLuongDiemDaTinh] < [thongTinPhanDangChieu soLuongDiem] ) {
      // ---- tính một khúc nữa
      [self tinhLai_1x1:NULL];
   }

   // ---- nâng cấp ảnh
   [chieuPhanDang chepAnh:mangAnhChieu];
   [chieuPhanDang setNeedsDisplay:YES];
}

#pragma mark ---- Chỉnh Màu Và Vẽ Lại
- (void)chinhMauVaVeLai:(NSNotification *)loiBao; {

   // ---- lấy màu và số màu để chỉnh
   unsigned char soMau = [[loiBao object] soMauDaChon];
   float *mau = [[loiBao object] mauChon];
   
   unsigned short soLuongMau = [[loiBao object] soLuongMau];

   // ---- nâng cấp màu mới
   if( soMau < soLuongMau )
      [[thongTinPhanDangChieu toMau] thayMau:mau choSo:soMau];
   else
      [[thongTinPhanDangChieu toMau] thayMauTapHop:mau];
   [ToMau toMauLai:[thongTinPhanDangChieu toMau] choThongTinPhanDang:thongTinPhanDangChieu];

   // ---- vẽ lại phằn dạng
   [chieuPhanDang chepAnh:mangAnhChieu];
   [chieuPhanDang setNeedsDisplay:YES];
}

#pragma mark ---- Chèn Màu
- (void)chenMau:(NSNotification *)loiBao; {

   // ---- lấy màu và chổ để chén vào
   unsigned char soMau = [[loiBao object] soMauDaChon];
   float *mauMoi = [[loiBao object] mauChon];

   // ---- chèn màu mới vào
   [[thongTinPhanDangChieu toMau] chenMau:mauMoi taiChiSo:soMau];
   [ToMau toMauLai:[thongTinPhanDangChieu toMau] choThongTinPhanDang:thongTinPhanDangChieu];
   
   // ---- vẽ lại phằn dạng
   [chieuPhanDang chepAnh:mangAnhChieu];
   [chieuPhanDang setNeedsDisplay:YES];
   
   // ---- nâng cấp chuỗi màu
   [manThanhMau datMau:[thongTinPhanDangChieu toMau]];
   [manThanhMau setNeedsDisplay:YES];
}

#pragma mark ---- Bỏ Màu
- (void)boMau:(NSNotification *)loiBao; {

   // ---- nếu bỏ màu thành công
   unsigned char soMau = [[loiBao object] soMauDaChon];

   if( [[thongTinPhanDangChieu toMau] boMauTaiChiSo:soMau] ) {
      [ToMau toMauLai:[thongTinPhanDangChieu toMau] choThongTinPhanDang:thongTinPhanDangChieu];
      // ----
      [chieuPhanDang chepAnh:mangAnhChieu];
      [chieuPhanDang setNeedsDisplay:YES];

      // ---- nâng cấp chuỗi mài
      [manThanhMau datMau:[thongTinPhanDangChieu toMau]];
      [manThanhMau setNeedsDisplay:YES];
   }
}

#pragma mark ---- Di Chuyển
- (void)diChuyen:(NSNotification *)loiBao; {

   unsigned char huong = [[loiBao object] huong];
   
   unsigned char cachDiChuyen = 1;
   if( [[loiBao object] phimShift] )
      cachDiChuyen = 10;

   if( huong == 123 ) {
      [thongTinPhanDangChieu diChuyenSoBuoc:cachDiChuyen huong:huong];
      // ---- vẽ lại màn
      [self batDauTinhAnhChieu];
      // ---- chiếu gía trị mới
      float trungTamX = (float)[thongTinPhanDangChieu trungTamX];
      [vanBanX setStringValue:[NSString stringWithFormat:@"%15.13f", trungTamX]];
   }
   else if( huong == 124 ) {
      [thongTinPhanDangChieu diChuyenSoBuoc:cachDiChuyen huong:huong];
      // ---- vẽ lại màn
      [self batDauTinhAnhChieu];
      // ---- chiếu gía trị mới
      float trungTamX = (float)[thongTinPhanDangChieu trungTamX];
      [vanBanX setStringValue:[NSString stringWithFormat:@"%15.13f", trungTamX]];
   }
   else if( huong == 125 ) {
      [thongTinPhanDangChieu diChuyenSoBuoc:cachDiChuyen huong:huong];
      // ---- vẽ lại màn
      [self batDauTinhAnhChieu];
      // ---- chiếu gía trị mới
      float trungTamY = (float)[thongTinPhanDangChieu trungTamY];
      [vanBanY setStringValue:[NSString stringWithFormat:@"%15.13f", trungTamY]];
   }
   else if( huong == 126 ) {
      [thongTinPhanDangChieu diChuyenSoBuoc:cachDiChuyen huong:huong];
   // ---- vẽ lại màn
      [self batDauTinhAnhChieu];
      // ---- chiếu gía trị mới
      float trungTamY = (float)[thongTinPhanDangChieu trungTamY];
      [vanBanY setStringValue:[NSString stringWithFormat:@"%15.13f", trungTamY]];
   }
}


#pragma mark ---- Di Chuyển
- (void)keoMan:(NSNotification *)loiBao; {

   CGPoint cachKeoMan = [[loiBao object] cachKeoMan];
   float phongTo = [thongTinPhanDangChieu phongTo]/(float)[thongTinPhanDangChieu beRong];
   
   cachKeoMan.x *= phongTo;
   cachKeoMan.y *= phongTo;
   float trungTamX = (float)[thongTinPhanDangChieu trungTamX] - cachKeoMan.x;
   float trungTamY = (float)[thongTinPhanDangChieu trungTamY] - cachKeoMan.y;

   // ---- nâng cấp thông tin
   [thongTinPhanDangChieu setGocX:[thongTinPhanDangChieu gocX] - cachKeoMan.x];
   [thongTinPhanDangChieu setGocY:[thongTinPhanDangChieu gocY] - cachKeoMan.y];

   // ---- vẽ lại màn
   [self batDauTinhAnhChieu];
   
   // ---- nâng cấp tọa độ chiếu
   [vanBanX setStringValue:[NSString stringWithFormat:@"%15.13f", trungTamX]];
   [vanBanY setStringValue:[NSString stringWithFormat:@"%15.13f", trungTamY]];
}


#pragma mark ---- Bấm Tính
- (IBAction)doiDanhAnhXuat:(id)vatGoi; {
   
   // ---- dạng ảnh trong danh bạ
   thuTapTin = (unsigned short)[vatGoi indexOfSelectedItem];
}

- (IBAction)bamXuatAnh:(id)vatGoi; {

   tinhAnh = !tinhAnh;
   
   if( tinhAnh ) {
      NSSavePanel *sheet = [NSSavePanel savePanel];   // declares and initializes a save panel?
      
      if( (thuTapTin == kTAP_TIN__PNG_8) || (thuTapTin == kTAP_TIN__PNG_16) )
         [sheet setAllowedFileTypes:[NSArray arrayWithObjects:@"png", nil]];
      else if( (thuTapTin == kTAP_TIN__EXR_HALF) || (thuTapTin == kTAP_TIN__EXR_FLOAT) )
         [sheet setAllowedFileTypes:[NSArray arrayWithObjects:@"exr", nil]];

      [sheet beginSheetModalForWindow:[[NSApplication sharedApplication] mainWindow] completionHandler:^(NSInteger ketQua) {
         if (ketQua == NSFileHandlingPanelOKButton) {
            
            // ---- xem đuôi
            URL_tapTinAnh = [sheet URL];
            NSString *duoi = [URL_tapTinAnh lastPathComponent];
            
            if( (thuTapTin == kTAP_TIN__PNG_8) || (thuTapTin == kTAP_TIN__PNG_16) ) {
               if( ![duoi hasSuffix:@".png"] )
                  [URL_tapTinAnh URLByAppendingPathExtension:@".png"];
            }
            else if( (thuTapTin == kTAP_TIN__EXR_HALF) || (thuTapTin == kTAP_TIN__EXR_FLOAT) ) {
               if( ![duoi hasSuffix:@".exr"] )
                  [URL_tapTinAnh URLByAppendingPathExtension:@".exr"];
            }
                        
            [nutTinhAnh setTitle:NSLocalizedString(@"Nghỉ", @"Cho Nút nghỉ tính ảnh độ phần giải cao")];
            
            // ---- chép thông tin phần dạng chiếu
            [thongTinPhanDangXuat setBeRong:beRongAnhTinh];
            [thongTinPhanDangXuat setBeCao:beCaoAnhTinh];
            [ThongTinPhanDang chepThongTinChieu:thongTinPhanDangChieu vaoThongTinXuat:thongTinPhanDangXuat];

            [self chuanBiCacMangTinhBeRong:beRongAnhTinh beCao:beCaoAnhTinh];
            // ---- mảng số lặp lại phải lớn hơn 4 lần
            [thongTinPhanDangXuat datMangMau:mangAnhTinh mangSoLuongLapLai:mangSoLapLaiTinh vaSoLuongDiem:[thongTinPhanDangXuat beRong]*[thongTinPhanDangXuat beCao] << 2];
            // ----
            [self batDauTinhAnhXuat];
         }
         else
            tinhAnh = NO;
      }];
   }
   else {
      [nutTinhAnh setTitle:@"Xuất"];
      
      // ---- đừng tính nữa
      [queueTinhPhanDang cancelAllOperations];

   }

}


#pragma mark ---- Chọn Sắp Màu
- (IBAction)mauVuTruong:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datVuTruong];
   [self veLaiChoMauMoi];
}

- (IBAction)mauMuaDong:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datMuaDong];
   [self veLaiChoMauMoi];
}

- (IBAction)mauGiangSinh:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datGiangSinh];
   [self veLaiChoMauMoi];
}

- (IBAction)mauHoaHongVaXanh:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datHoaHongVaXanh];
   [self veLaiChoMauMoi];
}
   
- (IBAction)mauSaMac:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datSaMac];
   [self veLaiChoMauMoi];
}

- (IBAction)mauSaMac2:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datSaMac2];
   [self veLaiChoMauMoi];
}

- (IBAction)mauThaiDuong:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datThaiDuong];
   [self veLaiChoMauMoi];
}

- (IBAction)mauSoCoLa:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datSoCoLa];
   [self veLaiChoMauMoi];
}

- (IBAction)mauSoCoLaDeo:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datSoCoLaDeo];
   [self veLaiChoMauMoi];
}

- (IBAction)mauCauVong:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datCauVong];
   [self veLaiChoMauMoi];
}

- (IBAction)mauCauVong2:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datCauVong2];
   [self veLaiChoMauMoi];
}

- (IBAction)mauVatDen:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datVatDen];
   [self veLaiChoMauMoi];
}

- (IBAction)mauTuyet:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datTuyet];
   [self veLaiChoMauMoi];
}

- (void)mauPhimXua:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datPhimXua];
   [self veLaiChoMauMoi];
}

- (IBAction)mauKimLoai:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datKimLoai];
   [self veLaiChoMauMoi];
}

- (IBAction)mauRauCau:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datRauCau];
   [self veLaiChoMauMoi];
}

- (IBAction)mauNeon:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datNeon];
   [self veLaiChoMauMoi];
}

- (IBAction)mauKeoBong:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datKeoBong];
   [self veLaiChoMauMoi];
}

- (IBAction)mauHoangGia:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datHoangGia];
   [self veLaiChoMauMoi];
}

- (IBAction)mauSilic:(id)vatGoi; {
   [[thongTinPhanDangChieu toMau] datSilic];
   [self veLaiChoMauMoi];
}

- (void)veLaiChoMauMoi; {
   [ToMau toMauLai:[thongTinPhanDangChieu toMau] choThongTinPhanDang:thongTinPhanDangChieu];

   // ---- nâng cập màn chiếu phần dạng
   [chieuPhanDang chepAnh:mangAnhChieu];
   [chieuPhanDang setNeedsDisplay:YES];

   // ---- nâng cấp chuỗi màu
   [manThanhMau datMau:[thongTinPhanDangChieu toMau]];
   [manThanhMau setNeedsDisplay:YES];
}

#pragma mark ---- Văn Bản
- (IBAction)doiSoLapLai:(id)vatGoi; {

   if( vanBanSoLapLai ) {
      unsigned int _soLapLai = [vanBanSoLapLai intValue];
      unsigned int soLapLai = [thongTinPhanDangChieu soLapLaiToiDa];
      if( _soLapLai != soLapLai ) {
         if( _soLapLai != 0 )

         [thongTinPhanDangChieu setSoLapLaiToiDa:_soLapLai];
         [thongTinPhanDangChieu setTinhLaiSoLapLai:YES];
         [[thongTinPhanDangChieu toMau] setSoLapLaiToiDa:_soLapLai];
         // ---- nên chỉ tính điểm => giới hạn cũ hay bỏ điểm < giới hạn mới <---------------
         [self batDauTinhAnhChieu];
      }
   }
}

- (IBAction)doiGiaiThuat:(id)vatGoi; {

   // ---- số cỡ thước chọn trong danh bạ
   unsigned char soGiaiThuatMoi = (unsigned short)[nutGiaiThuat indexOfSelectedItem];
   
   if( soGiaiThuat != soGiaiThuatMoi ) {
      soGiaiThuat = soGiaiThuatMoi;
      [thongTinPhanDangChieu setGiaiThuat:soGiaiThuatMoi];

      if( soGiaiThuat >= GIAI_THUAT__MAN_MU_PHAN_SO ) {
         [vanBanPhanSo setEnabled:YES];
         [vanBanPhanSo setEditable:YES];
      }
      else
         [vanBanPhanSo setEnabled:NO];
      
      if( soGiaiThuat == GIAI_THUAT__MAN_MU_2 ) {
         giaiThuat = [[GiaiThuat_MJ_2 alloc] init];
         [vanBanPhanSo setStringValue:[NSString stringWithFormat:@"%5.3f", 2.0]];
         [thongTinPhanDangChieu setMu:2.0];
      }
      else if( soGiaiThuat == GIAI_THUAT__MAN_MU_3 ) {
         giaiThuat = [[GiaiThuat_MJ_3 alloc] init];
         [vanBanPhanSo setStringValue:[NSString stringWithFormat:@"%5.3f", 3.0]];
         [thongTinPhanDangChieu setMu:3.0];
      }
      else if( soGiaiThuat == GIAI_THUAT__MAN_MU_4 ) {
         giaiThuat = [[GiaiThuat_MJ_4 alloc] init];
         [vanBanPhanSo setStringValue:[NSString stringWithFormat:@"%5.3f", 4.0]];
         [thongTinPhanDangChieu setMu:4.0];
      }
      else if( soGiaiThuat == GIAI_THUAT__MAN_MU_5 ) {
         giaiThuat = [[GiaiThuat_MJ_5 alloc] init];
         [vanBanPhanSo setStringValue:[NSString stringWithFormat:@"%5.3f", 5.0]];
         [thongTinPhanDangChieu setMu:5.0];
      }
      else if( soGiaiThuat == GIAI_THUAT__MAN_MU_PHAN_SO ) {
         giaiThuat = [[GiaiThuat_MJ_PhanSo alloc] init];
         [thongTinPhanDangChieu setMu:[vanBanPhanSo floatValue]];
      }
      else if( soGiaiThuat == GIAI_THUAT__MAN_COSH ) {
         giaiThuat = [[GiaiThuat_MJ_Cosh alloc] init];
         [thongTinPhanDangChieu setMu:[vanBanPhanSo floatValue]];
      }
      else if( soGiaiThuat == GIAI_THUAT__MAN_EXP ) {
         giaiThuat = [[GiaiThuat_MJ_Exp alloc] init];
         [thongTinPhanDangChieu setMu:[vanBanPhanSo floatValue]];
      }

      // ---- chuẩn bị tính lại
      [thongTinPhanDangChieu datLaiSoLuongDiemDaTinh];
      [thongTinPhanDangChieu setTinhLaiSoLapLai:NO];
      [self batDauTinhAnhChieu];
   }
}

- (IBAction)doiMuGiaiThuat:(id)vatGoi; {

   if( vanBanMuGiaiThuat ) {
      float mu = [vanBanMuGiaiThuat floatValue];
      if( [thongTinPhanDangChieu mu] != mu ) {
         
         [thongTinPhanDangChieu setMu:(double)mu];

         [vanBanMuGiaiThuat setStringValue:[NSString stringWithFormat:@"%5.3f", mu]];
         // ----
         [thongTinPhanDangChieu datLaiSoLuongDiemDaTinh];
         [thongTinPhanDangChieu setTinhLaiSoLapLai:NO];
         [self batDauTinhAnhChieu];

      }
   }
}

- (IBAction)doiChuTrinhMau:(id)vatGoi; {
   
   if( vanBanChuTrinhMau ) {
      unsigned int chuTrinhMauMoi = [vanBanChuTrinhMau intValue];
      if( [[thongTinPhanDangChieu toMau] chuTrinhMau] != chuTrinhMauMoi ) {
         if( chuTrinhMauMoi == 0 ) {
            chuTrinhMauMoi = [[thongTinPhanDangChieu toMau] chuTrinhMau];
            [vanBanChuTrinhMau setStringValue:[NSString stringWithFormat:@"%d", chuTrinhMauMoi]];
         }
         else {
            [[thongTinPhanDangChieu toMau] setChuTrinhMau:chuTrinhMauMoi];
            
            [[thongTinPhanDangChieu toMau] veLaiVoiMangMau:mangAnhChieu vaMangSoLuongLapLai:mangSoLapLaiChieu
                       soLuongDiem:[thongTinPhanDangChieu soLuongDiem] vaGioiHanLapLai:[thongTinPhanDangChieu soLapLaiToiDa]];
            // ----
            [chieuPhanDang chepAnh:mangAnhChieu];
            [chieuPhanDang setNeedsDisplay:YES];
         }
      }
   }
}

- (IBAction)doiMuMau:(id)vatGoi; {
   
   if( vanBanMuMau ) {
      float mu = [vanBanMuMau floatValue];
      if( [[thongTinPhanDangChieu toMau] mu] != mu ) {

         if( mu > 5.0 ) {
            mu = 5.0;
            [vanBanMuMau setStringValue:[NSString stringWithFormat:@"%7.5f", mu]];
         }
         else if( mu < -5.0 ) {
            mu = -5.0;
            [vanBanMuMau setStringValue:[NSString stringWithFormat:@"%7.5f", mu]];
         }

         [[thongTinPhanDangChieu toMau] setMu:mu];

         [[thongTinPhanDangChieu toMau] veLaiVoiMangMau:mangAnhChieu vaMangSoLuongLapLai:mangSoLapLaiChieu
                    soLuongDiem:[thongTinPhanDangChieu soLuongDiem] vaGioiHanLapLai:[thongTinPhanDangChieu soLapLaiToiDa]];
         // ----
         [chieuPhanDang chepAnh:mangAnhChieu];
         [chieuPhanDang setNeedsDisplay:YES];
      }
   }
}

- (IBAction)doiDich:(id)vatGoi; {
   
   if( vanBanDich ) {
      unsigned int dich = [vanBanDich intValue];
      if( [[thongTinPhanDangChieu toMau] dich] != dich ) {
         
         [[thongTinPhanDangChieu toMau] setDich:dich];

         [[thongTinPhanDangChieu toMau] veLaiVoiMangMau:mangAnhChieu vaMangSoLuongLapLai:mangSoLapLaiChieu
                    soLuongDiem:[thongTinPhanDangChieu soLuongDiem]
                vaGioiHanLapLai:[thongTinPhanDangChieu soLapLaiToiDa]];
         
         // ----
         [chieuPhanDang chepAnh:mangAnhChieu];
         [chieuPhanDang setNeedsDisplay:YES];
      }
   }
}

- (IBAction)doiTrungTamX:(id)vatGoi; {

   if( vanBanX ) {
      double x = [vanBanX doubleValue];
      double trungTamX = [thongTinPhanDangChieu trungTamX];
      if( trungTamX != x) {
         trungTamX = x;
         [vanBanX setStringValue:[NSString stringWithFormat:@"%15.13f", x]];  // phải làm cái này nếu gõ bậy bà
         [thongTinPhanDangChieu doiTrungTamX:trungTamX y:[thongTinPhanDangChieu trungTamY]
                                   vaPhongTo:[thongTinPhanDangChieu phongTo]];
         [thongTinPhanDangChieu setTinhLaiSoLapLai:NO];
         [self batDauTinhAnhChieu];
      }
   }
}

- (IBAction)doiTrungTamY:(id)vatGoi; {
   
   if( vanBanY ) {
      double y = [vanBanY doubleValue];
      double trungTamY = [thongTinPhanDangChieu trungTamY];
      if( trungTamY != y) {
         trungTamY = y;
         [vanBanY setStringValue:[NSString stringWithFormat:@"%15.13f", y]];  // phải làm cái này nếu gõ bậy bà
         [thongTinPhanDangChieu doiTrungTamX:[thongTinPhanDangChieu trungTamX] y:trungTamY vaPhongTo:[thongTinPhanDangChieu phongTo]];
         [thongTinPhanDangChieu setTinhLaiSoLapLai:NO];
         [self batDauTinhAnhChieu];
      }
   }
}

- (IBAction)doiPhongTo:(id)vatGoi; {
   
   if( vanBanPhongTo ) {
   
      double _phongTo = [vanBanPhongTo doubleValue];
      double phongTo = [thongTinPhanDangChieu phongTo];

      if( _phongTo != phongTo ) {
         if(_phongTo == 0.0) {
            _phongTo = phongTo;
            [vanBanPhongTo setStringValue:[NSString stringWithFormat:@"%10.7E", _phongTo]];
         }
         else {
            [thongTinPhanDangChieu doiTrungTamX:[thongTinPhanDangChieu trungTamX] y:[thongTinPhanDangChieu trungTamY]
                                 vaPhongTo:_phongTo];
            [thongTinPhanDangChieu setTinhLaiSoLapLai:NO];
            // ---- đừng tính mấy cục cũ nữa
            [queueTinhPhanDang cancelAllOperations];
            // ---- bắt đầu tính lại
            [self batDauTinhAnhChieu];
         }
      }
   }
}

- (IBAction)doiCoThuoc:(id)doPhatHanh; {

   // ---- số cỡ thước chọn trong danh bạ
   soCoThuoc = (unsigned short)[doPhatHanh indexOfSelectedItem];

   // ---- luônๆ bằng bề cao ảnh chiếu
   BOOL tuyChon = [CacKho choAnhTinhBeRong:&beRongAnhTinh vaBeCao:&beCaoAnhTinh choSo:soCoThuoc];
   
   if( tuyChon ) {
      // ---- cho người dùng gõ cỡ thước
      [vanBanRong setEnabled:YES];
      [vanBanRong setEditable:YES];

      [vanBanCao setEnabled:YES];
      [vanBanCao setEditable:YES];
   }
   else {
      // ---- đang xài khổ đặt sẵn, không cho người dùng gõ cỡ thước
      [vanBanRong setEnabled:NO];
      [vanBanCao setEnabled:NO];
      
      // ---- xoá ảnh cũ
      [chieuPhanDang xoa];
      
      // ---- chỉnh cỡ thước theo màn chiếu phần dạng
      CGRect chuNhatChieu = [chieuPhanDang bounds];
      unsigned short beCaoChieu = (unsigned short)chuNhatChieu.size.height;
      unsigned short beRongChieu = ((float)beCaoChieu/(float)beCaoAnhTinh) * beRongAnhTinh;
   
      // ---- coi trừng bề rộng hơn màn chiếu (cửa sổ)
      if( beRongChieu > chuNhatChieu.size.width ) {
         beRongChieu = (unsigned short)chuNhatChieu.size.width;
         if( beRongChieu > 1024 )
             beRongChieu = 1024;
   
         beCaoChieu = ((float)beRongChieu/(float)beRongAnhTinh) * beCaoAnhTinh;
      }

      // ---- nâng cấp cỡ kích chiếu
      [thongTinPhanDangChieu doiBeRong:beRongChieu beCao:beCaoChieu];
      
      // ---- chuẩn bị vẽ lại, lặp mảng mới
      [self chuanBiCacMangChieuBeRong:beRongChieu beCao:beCaoChieu];
      [chieuPhanDang setBeRong:beRongChieu];
      [chieuPhanDang setBeCao:beCaoChieu];
      
      // ---- cho mảng mới
      [thongTinPhanDangChieu datMangMau:mangAnhChieu mangSoLuongLapLai:mangSoLapLaiChieu vaSoLuongDiem:beRongChieu*beCaoChieu];

      [vanBanRong setStringValue:[NSString stringWithFormat:@"%d", beRongAnhTinh]];
      [vanBanCao setStringValue:[NSString stringWithFormat:@"%d", beCaoAnhTinh]];
      // ---- chuẩn bị tính lại
      [thongTinPhanDangChieu setSoLuongDiemDaTinh:0];
      [self batDauTinhAnhChieu];
   }
}

- (IBAction)doiRong:(id)doPhatHanh; {

   if( vanBanRong ) {
      unsigned int _beRong = [vanBanRong intValue];
      
      if( _beRong < kDIEM_ANH_TOI_THIEU ) {
         _beRong = kDIEM_ANH_TOI_THIEU;
         [vanBanRong setStringValue:[NSString stringWithFormat:@"%d", _beRong]];
      }
      
      if( _beRong != [thongTinPhanDangXuat beRong] ) {
         if( _beRong > kDIEM_ANH_TOI_DA ) {
            _beRong = kDIEM_ANH_TOI_DA;
            [vanBanRong setStringValue:[NSString stringWithFormat:@"%d", _beRong]];
         }

         // ---- xóa ảnh cũ
         [chieuPhanDang xoa];

         // ---- giữ bề rộng mới
         beRongAnhTinh = _beRong;

         // ---- chỉnh cỡ thước theo màn chiếu phần dạng
         CGRect chuNahtChieu = [chieuPhanDang bounds];
         unsigned short beCaoChieu = (unsigned short)chuNahtChieu.size.height;
         unsigned short beRongChieu = ((float)beCaoChieu/(float)[thongTinPhanDangXuat beCao]) * _beRong;
         
         // ---- coi trừng bề rộng quá to
         if( beRongChieu > chuNahtChieu.size.width ) {
            beRongChieu = (unsigned short)chuNahtChieu.size.width;
            if( beRongChieu > 1024 )
               beRongChieu = 1024;
            
            beCaoChieu = ((float)beRongChieu/(float)[thongTinPhanDangXuat beRong]) * [thongTinPhanDangXuat beCao];
         }
         
//         NSLog( @"QLDC: doiRong %d %d  %d %d", beRongChieu, beCaoChieu, beRongAnhTinh, beCaoAnhTinh );
         [thongTinPhanDangChieu doiBeRong:beRongChieu beCao:beCaoChieu];

         // ---- xài
         [self chuanBiCacMangChieuBeRong:[thongTinPhanDangChieu beRong] beCao:[thongTinPhanDangChieu beCao]];
         [chieuPhanDang setBeRong:beRongChieu];
         [chieuPhanDang setBeCao:beCaoChieu];
         
         [thongTinPhanDangChieu setTinhLaiSoLapLai:NO];
         [thongTinPhanDangChieu datMangMau:mangAnhChieu mangSoLuongLapLai:mangSoLapLaiChieu vaSoLuongDiem:beRongChieu*beCaoChieu];
         // ---- tính lại ảh chiếu
         [self batDauTinhAnhChieu];

      }
   }
}

- (IBAction)doiCao:(id)doPhatHanh; {

   if( vanBanCao ) {
      unsigned int _beCao = [vanBanCao intValue];
      
      if( _beCao < kDIEM_ANH_TOI_THIEU ) {
         _beCao = kDIEM_ANH_TOI_THIEU;
         [vanBanCao setStringValue:[NSString stringWithFormat:@"%d", _beCao]];
      }

      if( _beCao != [thongTinPhanDangXuat beCao] ) {
         if( _beCao > kDIEM_ANH_TOI_DA ) {
            _beCao = kDIEM_ANH_TOI_DA;//beCaoAnhTinh;
            [vanBanCao setStringValue:[NSString stringWithFormat:@"%d", _beCao]];
         }
         
         // ---- xóa ảnh cũ
         [chieuPhanDang xoa];
         
         // ---- giữ bề cao mới
         beCaoAnhTinh = _beCao;
         
         // ---- chỉnh cỡ thước theo màn chiếu phần dạng
         CGRect chuNahtChieu = [chieuPhanDang bounds];
         unsigned short beCaoChieu = (unsigned short)chuNahtChieu.size.height;
         unsigned short beRongChieu = ((float)beCaoChieu/(float)_beCao) * [thongTinPhanDangXuat beRong];
         
         // ---- coi trừng bề rộng quá to
         if( beRongChieu > chuNahtChieu.size.width ) {
            beRongChieu = (unsigned short)chuNahtChieu.size.width;
            if( beRongChieu > 1024 )
               beRongChieu = 1024;
            
            beCaoChieu = ((float)beRongChieu/(float)[thongTinPhanDangXuat beRong]) * [thongTinPhanDangXuat beCao];
         }

         [thongTinPhanDangChieu doiBeRong:beRongChieu beCao:beCaoChieu];
         
         [self chuanBiCacMangChieuBeRong:beRongChieu beCao:beCaoChieu];
         [chieuPhanDang setBeRong:beRongChieu];
         [chieuPhanDang setBeCao:beCaoChieu];
         
         [thongTinPhanDangChieu setTinhLaiSoLapLai:NO];
         [thongTinPhanDangChieu datMangMau:mangAnhChieu mangSoLuongLapLai:mangSoLapLaiChieu vaSoLuongDiem:beRongChieu*beCaoChieu];

         // ---- bắt đầu tính ảnh chiếu lại
         [self batDauTinhAnhChieu];
      }
   }

}

#pragma mark ---- Julia
- (IBAction)doiTinhJulia:(id)sender; {
   
   if( [nutTinhJulia state] ) {
      [vanBanJuliaX setEnabled:YES];
      [vanBanJuliaY setEnabled:YES];
      [thongTinPhanDangChieu setTinhJulia:YES];
      [thongTinPhanDangChieu setHangSoThat:[thongTinPhanDangChieu trungTamX]];
      [thongTinPhanDangChieu setHangSoAo:[thongTinPhanDangChieu trungTamY]];

      // ---- bắt đầu tính tập Julia
      [self batDauTinhAnhChieu];
   }
   else {
      [vanBanJuliaX setEnabled:NO];
      [vanBanJuliaY setEnabled:NO];
      [thongTinPhanDangChieu setTinhJulia:NO];

      // ---- bắt đầu tính tấp Mandelbrot
      [self batDauTinhAnhChieu];
   }
}

- (IBAction)doiJuliaX:(id)sender; {
   if( vanBanJuliaX ) {
      double x = [vanBanJuliaX doubleValue];
      double juliaX = [thongTinPhanDangChieu hangSoThat];
      // ---- chỉ làm nếu đổi giá trị mới
      if( juliaX != x) {
         juliaX = x;
         [vanBanJuliaX setStringValue:[NSString stringWithFormat:@"%10.8f", x]];  // phải làm cái này nếu gõ bậy bà
         [thongTinPhanDangChieu setHangSoThat:x];
         [thongTinPhanDangChieu setTinhLaiSoLapLai:NO];

         // ---- bắt đầu tính ảnh chiếu lại
         [self batDauTinhAnhChieu];
      }
   }
}

- (IBAction)doiJuliaY:(id)sender; {
   if( vanBanJuliaY ) {
      double y = [vanBanJuliaY doubleValue];
      double juliaY = [thongTinPhanDangChieu hangSoAo];
      // ---- chỉ làm nếu đổi giá trị mới
      if( juliaY != y) {
         juliaY = y;
         [vanBanJuliaY setStringValue:[NSString stringWithFormat:@"%10.8f", y]];  // phải làm cái này nếu gõ bậy bà
         [thongTinPhanDangChieu setHangSoThat:y];
         [thongTinPhanDangChieu setTinhLaiSoLapLai:NO];

         // ---- bắt đầu tính ảnh chiếu lại
         [self batDauTinhAnhChieu];
      }
   }
}

#pragma mark ---- NSTextField Delegate
//- (BOOL)control:(NSControl *)control textShouldBeginEditing:(NSText *)fieldEditor; {
//   return YES;
//}

//- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor; {
//   return YES;
//}

- (void)controlTextDidEndEditing:(NSNotification *)loiBao; {
//   NSLog( @"QL: controlTextDidEndEditing");
   [[[NSApplication sharedApplication] mainWindow] makeFirstResponder:chieuPhanDang];

}

#pragma mark ---- Cho Nâng Cấp Tựa Cửa Sổ Khi Tíng/Xuất Ảnh
- (void)nangCapTua:(NSNotification *)loiBao; {

   if( tinhAnhXong ) {
      NSString *tuaCuaSo = [NSString stringWithFormat:@"マンジラ：終わりました！ (%@)", NSLocalizedString( @"Xong", @"Khi tính ảnh xong") ];
      [[[NSApplication sharedApplication] mainWindow] setTitle:tuaCuaSo];
      tinhAnhXong = NO;
   }
   else { // 
      if( tinhAnh ) {
         float tiSoTinhXong = ((float)[thongTinPhanDangXuat soLuongDiemDaTinh]/(float)[thongTinPhanDangXuat soLuongDiem])*100.0f;
         NSString *tuaCuaSo = [NSString stringWithFormat:@"マンジラ: %d/%d  (%5.3f%%)", [thongTinPhanDangXuat soLuongDiemDaTinh], [thongTinPhanDangXuat soLuongDiem], tiSoTinhXong];
         [[[NSApplication sharedApplication] mainWindow] setTitle:tuaCuaSo];
      }
      else {
         [[[NSApplication sharedApplication] mainWindow] setTitle:@"マンジラ"];
      }
   }

}

- (void)dangDauChuongTrinh:(NSNotification *)loiBao; {
   
   // ---- chỉ làm nếu đang tính ảnh
   if( tinhAnh )
      tinhAnhXong = YES;
   else
      tinhAnhXong = NO;
   
}

#pragma mark ---- Lưu PNG
- (void)luuPNG_8; {

   // ---- đổi dữ liệu ảnh float sang uchar
   if( mangAnhTinh ) {
      unsigned int diaChiCuoi = [thongTinPhanDangXuat beRong] * [thongTinPhanDangXuat beCao] << 2;
      unsigned char *anhPNG = malloc( diaChiCuoi );
      dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^{
         unsigned int diaChi = 0;
         while ( diaChi < diaChiCuoi ) {
            anhPNG[diaChi] = 255.0f*mangAnhTinh[diaChi];
            anhPNG[diaChi+1] = 255.0f*mangAnhTinh[diaChi+1];
            anhPNG[diaChi+2] = 255.0f*mangAnhTinh[diaChi+2];
            anhPNG[diaChi+3] = 255.0f*mangAnhTinh[diaChi+3];
            diaChi += 4;
         }
         // ---- lưu tập tin sau tính ảnh xong
         dispatch_async( dispatch_get_main_queue(), ^{
            
            [LuuHoaTietPNG luuBGRO_PNG_voiURL:URL_tapTinAnh duLieuAnh:anhPNG beRong:[thongTinPhanDangXuat beRong]
                                        beCao:[thongTinPhanDangXuat beCao] soLuongBit:32];
            free( anhPNG );

            // ---- trở lại tính hình chiếu
//            unsigned short beRong = [chieuPhanDang beRong];
//            unsigned short beCao = [chieuPhanDang beCao];
//            [thongTinPhanDangXuat doiBeRong:beRong beCao:&beCao];
            //         [self chuanBiCacMangTinhBeRong:beRongAnhTinh beCao:beCaoAnhTinh];
//            [thongTinPhanDangXuat datMangMau:mangAnhChieu mangSoLuongLapLai:mangSoLapLaiChieu vaSoLuongDiem:beRong*beCao];
            // ---- làm icon nhảy lên
            [[NSApplication sharedApplication] requestUserAttention:NSInformationalRequest];
         });
      });
   }

}


- (void)luuPNG_16; {
   
   // ---- đổi dữ liệu ảnh float sang ushort
   if( mangAnhTinh ) {
      unsigned int diaChiCuoi = [thongTinPhanDangXuat beRong] * [thongTinPhanDangXuat beCao] << 2;
      unsigned short *anhPNG = malloc( diaChiCuoi * sizeof( unsigned short) );
      dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^{
         unsigned int diaChi = 0;
         while ( diaChi < diaChiCuoi ) {
            unsigned short giaTri = 65535.0f*mangAnhTinh[diaChi];
            anhPNG[diaChi] = (giaTri & 0xff00) >> 8 | (giaTri & 0xff) << 8;
            giaTri = 65535.0f*mangAnhTinh[diaChi+1];
            anhPNG[diaChi+1] = (giaTri & 0xff00) >> 8 | (giaTri & 0xff) << 8;
            giaTri = 65535.0f*mangAnhTinh[diaChi+2];
            anhPNG[diaChi+2] = (giaTri & 0xff00) >> 8 | (giaTri & 0xff) << 8;
            giaTri = 65535.0f*mangAnhTinh[diaChi+3];
            anhPNG[diaChi+3] = (giaTri & 0xff00) >> 8 | (giaTri & 0xff) << 8;
            diaChi += 4;
         }
         // ---- lưu tập tin
         dispatch_async( dispatch_get_main_queue(), ^{
            
            [LuuHoaTietPNG luuBGRO_PNG_voiURL:URL_tapTinAnh duLieuAnh:(unsigned char *)anhPNG
                                       beRong:[thongTinPhanDangXuat beRong] beCao:[thongTinPhanDangXuat beCao]
                                        soLuongBit:64];
            
            free( anhPNG );
            
            // ---- trở lại tính hình chiếu
//            unsigned short beRong = [chieuPhanDang beRong];
//            unsigned short beCao = [chieuPhanDang beCao];
//            [thongTinPhanDangXuat doiBeRong:beRong beCao:beCao];
            //         [self chuanBiCacMangTinhBeRong:beRongAnhTinh beCao:beCaoAnhTinh];
//            [thongTinPhanDangXuat datMangMau:mangAnhChieu mangSoLuongLapLai:mangSoLapLaiChieu vaSoLuongDiem:beRong*beCao];
            // ---- làm icon nhảy lên
            [[NSApplication sharedApplication] requestUserAttention:NSInformationalRequest];
         });
      });
   }
   
}

#pragma mark ---- Lưu EXR
- (void)luuEXR_half; {
   
   // ---- đổi dữ liệu ảnh float thành half
   
   if( mangAnhTinh ) {
      unsigned int beDaiDuLieuKenh = [thongTinPhanDangXuat beRong] * [thongTinPhanDangXuat beCao] << 1;  // unsigned short (2 byte/điểm ảnh)
      unsigned int diaChiCuoi = beDaiDuLieuKenh << 1;   // bốn giá trị cho một điểm ảnh

      __block unsigned short *kenhDo = malloc( beDaiDuLieuKenh );
      __block unsigned short *kenhLuc = malloc( beDaiDuLieuKenh );
      __block unsigned short *kenhXanh = malloc( beDaiDuLieuKenh );
      __block unsigned short *kenhDuc = malloc( beDaiDuLieuKenh );
   
      if( kenhDo && kenhLuc && kenhXanh && kenhDuc ) {
      dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^{
         unsigned int diaChi = 0;
         unsigned int diaChiKenh = 0;
         while ( diaChi < diaChiCuoi ) {
            union uif so;
            so.f = mangAnhTinh[diaChi];
            kenhDo[diaChiKenh] = [Half convertToHalfThisFloat:so.i];
            so.f = mangAnhTinh[diaChi+1];
            kenhLuc[diaChiKenh] = [Half convertToHalfThisFloat:so.i];
            so.f = mangAnhTinh[diaChi+2];
            kenhXanh[diaChiKenh] = [Half convertToHalfThisFloat:so.i];
            so.f = mangAnhTinh[diaChi+3];
            kenhDuc[diaChiKenh] = [Half convertToHalfThisFloat:so.i];
            diaChi += 4;
            diaChiKenh++;
         }
         // ---- lưu tập tin
         dispatch_async( dispatch_get_main_queue(), ^{
            NSString *tua = [NSString stringWithFormat:@"マンジラ：終わりました！ (%@)", NSLocalizedString( @"Xong", @"Khi tính ảnh xong") ];
            [[[NSApplication sharedApplication] mainWindow] setTitle:tua];

            [LuuEXR luuEXRHalf_voiURL:URL_tapTinAnh beRong:[thongTinPhanDangXuat beRong] beCao:[thongTinPhanDangXuat beCao]
                             vaKenhDo:(unsigned char *)kenhDo kenhLuc:(unsigned char *)kenhLuc
                             kenhXanh:(unsigned char *)kenhXanh kenhDuc:(unsigned char *)kenhDuc];

            // ---- trở lại tính ảnh chiếu
 //           unsigned short beRong = [chieuPhanDang beRong];
 //           unsigned short beCao = [chieuPhanDang beCao];
 //           [thongTinPhanDangXuat doiBeRong:beRong beCao:beCao];
            //         [self chuanBiCacMangTinhBeRong:beRongAnhTinh beCao:beCaoAnhTinh];
 //           [thongTinPhanDangXuat datMangMau:mangAnhChieu mangSoLuongLapLai:mangSoLapLaiChieu vaSoLuongDiem:beRong*beCao];
            // ---- làm icon nhảy lên
            [[NSApplication sharedApplication] requestUserAttention:NSInformationalRequest];
         });
      });
      }
      else {
         NSLog( @"QuanLyDoChieu: vấn đề với làm kênh cho tập tin EXR" );
         // ---- trở lại tính ảnh chiếu
 //        unsigned short beRong = [chieuPhanDang beRong];
 //        unsigned short beCao = [chieuPhanDang beCao];
 //        [thongTinPhanDangXuat doiBeRong:beRong beCao:beCao];
         //         [self chuanBiCacMangTinhBeRong:beRongAnhTinh beCao:beCaoAnhTinh];
 //        [thongTinPhanDangXuat datMangMau:mangAnhChieu mangSoLuongLapLai:mangSoLapLaiChieu vaSoLuongDiem:beRong*beCao];
      }
   
      free( kenhDo );
      free( kenhLuc );
      free( kenhXanh );
      free( kenhDuc );
   }
   
}


- (void)luuEXR_float; {

   if( mangAnhTinh ) {
      unsigned int beDaiDuLieuKenh = [thongTinPhanDangXuat beRong] * [thongTinPhanDangXuat beCao] << 2;  // dữ liệu float (4 byte/điểm ảnh)
      unsigned int diaChiCuoi = beDaiDuLieuKenh;   // bốn giá trị cho một điểm ảnh
//      NSLog( @"QLDC: beRongAnhTinh %d  beCaoAnhTinh %d  beDaiDuLieuKenh %d  beDaiDuLieuKenh/4 %d", beRongAnhTinh, beCaoAnhTinh, beDaiDuLieuKenh, beDaiDuLieuKenh << 2 );
      __block float *kenhDo = malloc( beDaiDuLieuKenh );
      __block float *kenhLuc = malloc( beDaiDuLieuKenh );
      __block float *kenhXanh = malloc( beDaiDuLieuKenh );
      __block float *kenhDuc = malloc( beDaiDuLieuKenh );
      
      // ---- chẻ các kênh
      if( kenhDo && kenhLuc && kenhXanh && kenhDuc ) {
         dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^{
            unsigned int diaChi = 0;
            unsigned int diaChiKenh = 0;
            while ( diaChi < diaChiCuoi ) {
               kenhDo[diaChiKenh] = mangAnhTinh[diaChi];
               kenhLuc[diaChiKenh] = mangAnhTinh[diaChi+1];
               kenhXanh[diaChiKenh] = mangAnhTinh[diaChi+2];
               kenhDuc[diaChiKenh] = mangAnhTinh[diaChi+3];
               diaChi += 4;
               diaChiKenh++;
            }
            // ---- lưu tập tin
            dispatch_async( dispatch_get_main_queue(), ^{
               NSString *tua = [NSString stringWithFormat:@"マンジラ：終わりました！ (%@)", NSLocalizedString( @"Xong", @"Khi tính ảnh xong") ];
               [[[NSApplication sharedApplication] mainWindow] setTitle:tua];
               
               [LuuEXR luuEXRFloat_voiURL:URL_tapTinAnh beRong:[thongTinPhanDangXuat beRong] beCao:[thongTinPhanDangXuat beCao]
                                vaKenhDo:(unsigned char *)kenhDo kenhLuc:(unsigned char *)kenhLuc
                                kenhXanh:(unsigned char *)kenhXanh kenhDuc:(unsigned char *)kenhDuc];
               
               
               // ---- trở lại tính ảnh chiếu
 //              unsigned short beRong = [chieuPhanDang beRong];
 //              unsigned short beCao = [chieuPhanDang beCao];
 //              [thongTinPhanDangXuat doiBeRong:beRong beCao:beCao];
 //              [thongTinPhanDangXuat datMangMau:mangAnhChieu mangSoLuongLapLai:mangSoLapLaiChieu vaSoLuongDiem:beRong*beCao];
               // ---- làm icon nhảy lên
               [[NSApplication sharedApplication] requestUserAttention:NSInformationalRequest];
            });
         });
      }
      else {
         NSLog( @"QuanLyDoChieu: vấn đề với làm kênh cho tập tin EXR" );
         // ---- trở lại tính ảnh chiếu
//         unsigned short beRong = [chieuPhanDang beRong];
//         unsigned short beCao = [chieuPhanDang beCao];
//         [thongTinPhanDangXuat doiBeRong:&beRong beCao:&beCao];
         //         [self chuanBiCacMangTinhBeRong:beRongAnhTinh beCao:beCaoAnhTinh];
//         [thongTinPhanDangXuat datMangMau:mangAnhChieu mangSoLuongLapLai:mangSoLapLaiChieu vaSoLuongDiem:beRong*beCao];
      }
      
      free( kenhDo );
      free( kenhLuc );
      free( kenhXanh );
      free( kenhDuc );
   }
   
}


#pragma mark ---- Đặt Lại Mặc Định
- (IBAction)datLai:(id)vatGoi; {
   // ---- chiếu gía trị mặc định
   [thongTinPhanDangChieu doiTrungTamX:-0.7 y:0.0 vaPhongTo:2.0];

   [vanBanX setStringValue:[NSString stringWithFormat:@"%15.13f", -0.7] ];
   [vanBanY setStringValue:[NSString stringWithFormat:@"%15.13f", 0.0] ];
   [vanBanPhongTo setStringValue:[NSString stringWithFormat:@"%10.7E", 2.0] ];

   // ---- chuẩn bị tính lại
   [thongTinPhanDangChieu datLaiSoLuongDiemDaTinh];
   [thongTinPhanDangChieu setTinhLaiSoLapLai:NO];

   // ---- bắt đầu tính ảnh chiếu lại
   [self batDauTinhAnhChieu];
}

#pragma mark ---- Thả

- (void)dealloc; {

   if( mangAnhChieu )
      free( mangAnhChieu );
   if( mangSoLapLaiChieu )
      free( mangSoLapLaiChieu );
   if( mangAnhTinh )
      free( mangAnhTinh );
   if( mangSoLapLaiTinh )
      free( mangSoLapLaiTinh );
}


@end
