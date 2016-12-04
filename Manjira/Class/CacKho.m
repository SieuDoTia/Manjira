//
//  CacKho.m   Các Khổ Ảnh
//  Manjira
//
//  Created by 小小 on 27/11/2556.
//

// Theo thứ tự trong danh bạ phụn lên
enum {
   A0_NGANG,  // hình ngang
   A1_NGANG,
   A2_NGANG,
   A3_NGANG,
   A4_NGANG,
   ANH_10x15,
   DUONG_TACH_0,
   A0_DUNG,   // hình đứng
   A1_DUNG,
   A2_DUNG,
   A3_DUNG,
   A4_DUNG,
   ANH_15x10,
   DUONG_TACH_1,
   HAI_K_HDTV,   // 2K HDTV
   HAI_K_PHIM,   // 2K Phim
   BON_K_HDTV,   // 4K HDTV
   BON_K_PHIM,   // 4K Phim
   TAM_K_HDTV,   // 8K HDTV
   TAM_K_PHIM,   // 8K Phim
   DUONG_TACH_2,
   TUY_CHON   // tùy chọn
};

#import "CacKho.h"

@implementation CacKho

+ (BOOL)choAnhTinhBeRong:(unsigned short *)beRongAnhTinh vaBeCao:(unsigned short *)beCaoAnhTinh
                   choSo:(unsigned char)soCoThuoc; {
   
   BOOL tuyGo = NO;  // tuỳ gõ

   // ---- NGAN
   if( soCoThuoc == A0_NGANG ) {  // A0 - Ngang
      *beRongAnhTinh = 14043;
      *beCaoAnhTinh = 9933;
   }
   else if( soCoThuoc == A1_NGANG ) {  // A1 - Ngang
      *beRongAnhTinh = 9933;
      *beCaoAnhTinh = 7016;
   }
   else if( soCoThuoc == A2_NGANG ) {  // A2 - Ngang
      *beRongAnhTinh = 7016;
      *beCaoAnhTinh = 4961;
   }
   else if( soCoThuoc == A3_NGANG ) {  // A3 - Ngang
      *beRongAnhTinh = 4961;
      *beCaoAnhTinh = 3508;
   }
   else if( soCoThuoc == A4_NGANG ) {  // A4 - Ngang
      *beRongAnhTinh = 3508;
      *beCaoAnhTinh = 2480;
   }
   else if( soCoThuoc == ANH_10x15 ) {  // 10 x 15 cm
      *beRongAnhTinh = 1800;
      *beCaoAnhTinh = 1200;
   }
   
   // ---- CAO
   else if( soCoThuoc == A0_DUNG ) {  // A0 - Cao
      *beRongAnhTinh = 9933;
      *beCaoAnhTinh = 14043;
   }
   else if( soCoThuoc == A1_DUNG ) {  // A1 - Cao
      *beRongAnhTinh = 7016;
      *beCaoAnhTinh = 9933;
   }
   else if( soCoThuoc == A2_DUNG ) {  // A2 - Cao
      *beRongAnhTinh = 4961;
      *beCaoAnhTinh = 7016;
   }
   else if( soCoThuoc == A3_DUNG ) {  // A3 - Cao
      *beRongAnhTinh = 3508;
      *beCaoAnhTinh = 4961;
   }
   else if( soCoThuoc == A4_DUNG ) {  // A4 - Cao
      *beRongAnhTinh = 2480;
      *beCaoAnhTinh = 3508;
   }
   else if( soCoThuoc == ANH_15x10 ) {  // 15 x 10 cm
      *beRongAnhTinh = 1200;
      *beCaoAnhTinh = 1800;
   }
   
   // ---- 2K
   else if( soCoThuoc == HAI_K_HDTV ) {
      *beRongAnhTinh = 1920;
      *beCaoAnhTinh = 1080;
   }
   else if( soCoThuoc == HAI_K_PHIM ) {
      *beRongAnhTinh = 2048;
      *beCaoAnhTinh = 1080;
   }
   // ---- 4K
   else if( soCoThuoc == BON_K_HDTV ) {
      *beRongAnhTinh = 3840;
      *beCaoAnhTinh = 2160;
   }
   else if( soCoThuoc == BON_K_PHIM ) {
      *beRongAnhTinh = 4096;
      *beCaoAnhTinh = 2160;
   }
   // ---- 8K
   else if( soCoThuoc == TAM_K_HDTV ) {
      *beRongAnhTinh = 7680;
      *beCaoAnhTinh = 4320;
   }
   else if( soCoThuoc == TAM_K_PHIM ) {
      *beRongAnhTinh = 8196;
      *beCaoAnhTinh = 4320;
   }
   else if( soCoThuoc == TUY_CHON ) {
      // không đổi gì cả
      tuyGo = YES;
   }
   
   // ---- cho biết cho tuỳ gõ cỡ thước
   return tuyGo;
}

@end
