//
//  QuanLyDoChieu.h
//  Manjira
//
//  Created by 小小 on 20/11/2556.
//

#import <Cocoa/Cocoa.h>
#import "GiaiThuat.h"

@class ChieuPhanDang;
@class ManThanhMau;

@class ToMau;
@class ThongTinPhanDang;


@interface QuanLyDoChieu : NSViewController <NSTextFieldDelegate> {
   
   IBOutlet ChieuPhanDang *chieuPhanDang;  // chiếu pần dạng
   IBOutlet ManThanhMau *manThanhMau;   // màn chiếu thanh màu, cột chỉnh sửa màu

   IBOutlet NSPopUpButton *nutChonDangAnh;  // nút chọn dạng ảnh
   IBOutlet NSButton *nutTinhAnh;  // nút bắt đầu tính/nghỉ ảnh
   
   IBOutlet NSTextField *vanBanSoLapLai;  // văn bản số lặp lại
   IBOutlet NSPopUpButton *nutGiaiThuat;    // giải thuật cho tính ảnh
   IBOutlet NSTextField *vanBanPhanSo;   // mũ cho giải thuật phần số
   IBOutlet NSTextField *vanBanMuGiaiThuat;  // văn bản mũ giải thuật

   IBOutlet NSTextField *vanBanChuTrinhMau;  // văn bản chu trình màu
   IBOutlet NSTextField *vanBanMuMau;     // văn bản mũ màu
   IBOutlet NSTextField *vanBanDich;   // văn bản dịch màu
   
   IBOutlet NSTextField *vanBanX;      // văn bản x (tung độ trung tâm)
   IBOutlet NSTextField *vanBanY;      // văn bản y (hoành độ trung tâm)
   IBOutlet NSTextField *vanBanPhongTo; // văn bản phóng to
   
   IBOutlet NSPopUpButton *nutChonCoThuoc;  // nút chọn cỡ thước
   IBOutlet NSTextField *vanBanRong;   // văn bản rộng
   IBOutlet NSTextField *vanBanCao;    // văn bản cao
   
   IBOutlet NSButton *nutTinhJulia;    // bật/tắt Julia
   IBOutlet NSTextField *vanBanJuliaX;    // văn bản cho tọa độ, hằng số tính Julia
   IBOutlet NSTextField *vanBanJuliaY;

   unsigned short soCoThuoc;   // số cỡ thước theo danh bạ cỡ thước

   NSURL *URL_tapTinAnh;   // URL cho tập tin ảnh
   BOOL tinhAnh;           // cho biết đang tính ảnh
   BOOL tinhAnhXong;       // cho biết đã tính ảnh xong
   BOOL canNangCapTuaCuaSo;   // cần nâng cấp tựa cửa sổ
   // ---- phải giữ hai giá trị này gì thôngTinPhầnDạngẢnhChiếu không giữ và
   //        thôngTinPhầnDạngẢnhTính có thể đang tính hình và không thể đổi
   unsigned short beRongAnhTinh;  // bề cao ảnh tính, không phải là ảnh chiếu trên màn
   unsigned short beCaoAnhTinh;   // bề rộng ảnh tính

//   ToMau *toMau;     // cho tô màu

   unsigned int soLuongLap;
   unsigned char soGiaiThuat;
   id <GiaiThuat> giaiThuat;
   
   float *mangAnhChieu;  // mảng màu cho chiếu
   float *mangAnhTinh;       // mảng ảnh tính
   unsigned int *mangSoLapLaiChieu;   // mảng số lặp lại chiếu
   unsigned int *mangSoLapLaiTinh;   // mảng số lặp lại tính
   
   unsigned char thuTapTin;     // thứ tập tin
   time_t thoiGianBatDauTinh;    // thời gian bắt đầu tính, dùng cho biết tốc độ tính các phần tập hợp Mandelbrot

   // ----
   ThongTinPhanDang *thongTinPhanDangChieu;  // thông tin phần dạng chiếu trên màn
   ThongTinPhanDang *thongTinPhanDangXuat;   // thông tin phần dạng xuất

 //  unsigned short soHang;     // số hàng đang tính, thật là hàng của chùn hàng đang tính

   // ---- NSOperation
   NSOperationQueue *queueTinhPhanDang;
}


- (IBAction)datLai:(id)vatGoi;

- (IBAction)doiDanhAnhXuat:(id)vatGoi;
- (IBAction)bamXuatAnh:(id)vatGoi;

- (IBAction)doiSoLapLai:(id)vatGoi;
- (IBAction)doiGiaiThuat:(id)vatGoi;
- (IBAction)doiMuGiaiThuat:(id)vatGoi;

- (IBAction)doiChuTrinhMau:(id)vatGoi;
- (IBAction)doiMuMau:(id)vatGoi;
- (IBAction)doiDich:(id)vatGoi;

- (IBAction)doiTrungTamX:(id)vatGoi;
- (IBAction)doiTrungTamY:(id)vatGoi;
- (IBAction)doiPhongTo:(id)vatGoi;

- (IBAction)doiCoThuoc:(id)vatGoi;
- (IBAction)doiRong:(id)vatGoi;
- (IBAction)doiCao:(id)vatGoi;

- (IBAction)doiTinhJulia:(id)vatGoi;
- (IBAction)doiJuliaX:(id)vatGoi;
- (IBAction)doiJuliaY:(id)vatGoi;

- (IBAction)mauVuTruong:(id)vatGoi;
- (IBAction)mauMuaDong:(id)vatGoi;
- (IBAction)mauGiangSinh:(id)vatGoi;
- (IBAction)mauHoaHongVaXanh:(id)vatGoi;
- (IBAction)mauSaMac:(id)vatGoi;
- (IBAction)mauThaiDuong:(id)vatGoi;
- (IBAction)mauSoCoLa:(id)vatGoi;
- (IBAction)mauSoCoLaDeo:(id)vatGoi;
- (IBAction)mauCauVong:(id)vatGoi;
- (IBAction)mauCauVong2:(id)vatGoi;
- (IBAction)mauVatDen:(id)vatGoi;
- (IBAction)mauTuyet:(id)vatGoi;
- (IBAction)mauPhimXua:(id)vatGoi;
- (IBAction)mauKimLoai:(id)vatGoi;
- (IBAction)mauRauCau:(id)vatGoi;
- (IBAction)mauNeon:(id)vatGoi;
- (IBAction)mauKeoBong:(id)vatGoi;
- (IBAction)mauHoangGia:(id)vatGoi;
- (IBAction)mauSilic:(id)vatGoi;


@end
