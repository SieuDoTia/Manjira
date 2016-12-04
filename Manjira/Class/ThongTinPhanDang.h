//
//  ThongTinPhanDang.h
//  Manjira
//
//  Created by 小小 on 27/9/2557.
//  Chỉ cho giữ thông tin tính, nó không tín gì cả

#import <Foundation/Foundation.h>

@class GiaiThuatPhanDang;
@class ToMau;

@interface ThongTinPhanDang : NSObject {

   double banKinhNghiTinhMu2;   // bán kính nghỉ (khi xa hơn, nghỉ tính)

   unsigned int beRong;  // độ giải cho hướng X
   unsigned int beCao;  // độ giải cho hướng Y
   unsigned int tinhCot;   // cột đang tính
   unsigned int tinhHang;  // hàng đang tính
   
   double trungTamX;
   double trungTamY;
   double phongTo;
   
   double gocX;       // góc X bắt đầu tính
   double gocY;       // góc Y bắt đầu tính
   double tinhX;      // tung độ đang tính
   double tinhY;      // hoành độ đanh tính
   double buocTinh;   // bước (cách) giữa điểm
   double buocTinhPhanTu;   // bước phần tư, cho tính ảnh đẹp hơn

   unsigned short soHangDangTinh;  // số hàng đang tính, thật là hàng của chùn hàng đang tính
   
   unsigned int soLapLaiToiDa;   // số lặp lại tối đa (mực nhgỉ tính và nhận điểm ở trong tậư hợp Mandelbrot)
   unsigned int soLapLaiToiDaCu;   // số lặp lại tối đa (mực nhgỉ tính và nhận điểm ở trong tậư hợp Mandelbrot)

   double mu;   // chỉ xài cho mũ phần số
   unsigned char giaiThuat;   // giải thuật cho tính phân dạng
   
   // ---- tô màu
   ToMau *toMau;
   
   // ---- 
   unsigned int soLuongDiemDaTinh; // số lượng đã tính rồi
   unsigned int soLuongDiem;       // số lượng cho hết điểm
   
   BOOL tinhLaiSoLapLai;
   
   // ---- Julia
   BOOL tinhJulia;
   double hangSoThat;   // hằng số thật cho tính Julia
   double hangSoAo;     // hằng số ảo cho tính Julia
   
   // ---- các mảng
   unsigned int *mangSoLapLai;   // mảng số lặp lại
   float *mangMau;               // mảng ảnh giải thấp (cho dự khán)

//   unsigned int *mangSoLapLaiAnhTinh;   // mảng số lặp lại cho ảnh tính
//   float *mangMauAnhTinh;               // mảng ảnh giải thấp cho ảnh tính (ví dụ xem trước)

}

- (id)initChoTrungTamX:(double)_trungTamX y:(double)_trungTamY phongTo:(double)_phongTo beRong:(unsigned short)_beRong
                 beCao:(unsigned short)_beCao lapLaiToiDa:(unsigned int)lapLaiToiDa mangMau:(float *)mangMau mangSoLapLai:(unsigned int *)mangSoLapLai;

- (void)doiTrungTamX:(double)_trungTamX y:(double)_trungTamY vaPhongTo:(double)_phongTo;

- (void)doiBeRong:(unsigned short)beRong beCao:(unsigned short)beCao;


- (void)tiSoPhongTo:(double)tiSoPhongTo quangDiemX:(double)diemX y:(double)diemY;

- (void)diChuyenSoBuoc:(unsigned short)soBuoc huong:(unsigned char)huong;

+ (void)chepThongTinChieu:(ThongTinPhanDang *)thongTinPhanDangChieu
          vaoThongTinXuat:(ThongTinPhanDang *)thongTinPhanDangXuat;

- (void)datMangMau:(float *)_mangMau mangSoLuongLapLai:(unsigned int *)_mangSoLuongLapLai
     vaSoLuongDiem:(unsigned int)_soLuongDiem;


- (void)datLaiSoLuongDiemDaTinh;

@property (readwrite) double gocX;
@property (readwrite) double gocY;
@property (readonly) double trungTamX;
@property (readonly) double trungTamY;
@property (readonly) double phongTo;

@property (readwrite) unsigned int beRong;
@property (readwrite) unsigned int beCao;

@property (readonly) double buocTinh;
@property (readwrite) double banKinhNghiTinhMu2;

@property (readwrite) unsigned short soHangDangTinh;
- (void)congThemVpoiSoHangDangTinh:(unsigned short)soLuongHangThem;

@property (readwrite) BOOL tinhJulia;
@property (readwrite) double hangSoThat;
@property (readwrite) double hangSoAo;


- (unsigned int)soLapLaiToiDa;
- (void)setSoLapLaiToiDa:(unsigned int)_soLapLaiToiDa;
@property (readonly) unsigned int soLapLaiToiDaCu;

@property (readwrite) double mu;
@property (readwrite) unsigned char giaiThuat;

@property (readwrite) unsigned int soLuongDiemDaTinh;
@property (readonly) unsigned int soLuongDiem;

@property (readwrite) BOOL tinhLaiSoLapLai;
@property (readonly) ToMau *toMau;

@property (readwrite) unsigned int *mangSoLapLai;
@property (readwrite) float *mangMau;


@end
