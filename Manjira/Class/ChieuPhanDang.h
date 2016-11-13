//
//  ChieuPhanDang.h
//  Manjira
//
//  Created by 小小 on 20/11/2556.
//

#import <Cocoa/Cocoa.h>

@interface ChieuPhanDang : NSOpenGLView {
   
//   float *anhViDu;   // ảnh ví dụ
   unsigned short beRong;   // bề rộng ảnh
   unsigned short beCao;    // bề cao ảnh
   
   unsigned int hoaTietPhanDang;  // họa tiết phần dạng
   unsigned int soChuongTrinhVe;  // số chương trình vẽ
   unsigned int uniform_MaTranChieu;  // biến uniform (đều) cho chương trình vẽ
   
   float maTranChieu[16];  // ma trận chiếu
   
   CGPoint viTriBamTuongDoi;   // vị trí bấm chuột tương đối ảnh phần dạng
   BOOL phimShift;     // có bấm phím shift
   unsigned char huong;  // hướng di chuyển
   
   BOOL keoHinh;   // kéo hình, xài cho phân biệt nên kéo màn hay phóng to màn
   CGPoint viTriBamDau;  // vị trí bấm đầu, để biết kéo màn bao xa khi buông chuột
   CGPoint cachKeoMan;  // cách kéo màn
}

//- (void)chuanBiChieuAnhRong:(unsigned short)beRongAnhChieu cao:(unsigned short)beCaoAnhChieu;
//- (void)datAnh:(float *)mangAnh vaBeRong:(unsigned short)rong beCao:(unsigned short)cao;
- (void)chepAnh:(float *)anh;
- (void)chepAnh:(float *)anh taiViTriX:(unsigned int)viTriX vaViTriY:(unsigned int)viTriY
           rong:(unsigned short)rong cao:(unsigned short)cao;
- (void)xoa;

//@property (readwrite) float *anhViDu;
@property (readwrite) unsigned short beRong;
@property (readwrite) unsigned short beCao;
@property (readonly) CGPoint viTriBamTuongDoi;
@property (readonly) BOOL phimShift;

@property (readonly) unsigned char huong;
@property (readonly) CGPoint cachKeoMan;

@end
