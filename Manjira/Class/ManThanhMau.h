//
//  ManThanhMau.h    Màn Thanh Màu
//  Manjira
//
//  Created by 小小 on 20/11/2556.
//

#import <Cocoa/Cocoa.h>

@class ToMau;

@interface ManThanhMau : NSOpenGLView {
   
   unsigned int soChuongTrinhVe;    // số chương trình vẽ
   unsigned int uniform_MaTranChieu;
   
   float maTranChieu[16];
   
   // ---- mảng cho thanh màu
   float mangThanhMau_dinh[1024];     // 256 màu, 2 điểm, 2 tọa độ (x; y)
   float mangThanhMau_mau[2048];
   unsigned short mangDinhTamGiac[512];
   unsigned short soLuongMau;
   
   float mangTamGiac_dinh[(256+1)*6];  // cho 256 tam giác + tam giác dưới màu tập hợp
   float mangTamGiac_mau[(256+1)*6 << 2];
   
   float cacCotChonMau_dinh[32];     // cột chọn màu đỏ
   float cacCotChonMau_mau[64];      // cột chọn màu lục
   float cacTamGiacChonMau_dinh[18]; // các tam giác chọn màu đỏ
   float cacTamGiacChonMau_mau[36];  // các tam giác màu lục

   // ---- chữ nhật màu tập hợp
   float chuNhatMauTapHop_dinh[8];
   float chuNhatMauTapHop_mau[16];

   // ---- chữ nhật cho màu đang chỉnh sữa
   float chuNhatChieuMau_dinh[8];
   float chuNhatChieuMau_mau[16];

   CGPoint diemBamDau;   // điểm đã bấm nút chuột đầu (cần vị trí này cho biết đã kéo chuột bao xa)
   BOOL daKeoChuot;      // cho biết đã kếo chuột trước thả

   ToMau *toMau;         // tô màu
   unsigned char soMauDaChon;    // số màu đã chọn
   float mauChon[4];     // màu đã chọn
   
   unsigned char huong;  // hướng di chuyển
   BOOL phimShift;      // cho di chuyển lẹ hơn
}

- (void)datMau:(ToMau *)toMau;

@property (readonly) unsigned char soMauDaChon;
@property (readonly) unsigned short soLuongMau;

@property (readonly) float *mauChon;

@property (readonly) unsigned char huong;
@property (readonly) BOOL phimShift;

@end
