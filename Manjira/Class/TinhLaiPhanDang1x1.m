//
//  TinhLaiPhanDang1x1.m
//  Manjira
//
//  Created by 小小 on 10/10/2557.
//

#import "TinhLaiPhanDang1x1.h"
#import "ThongTinPhanDang.h"

@implementation TinhLaiPhanDang1x1

- (id)initVoiThongTinPhanDang:(ThongTinPhanDang *)thongTinPhanDang soLuongHang:(unsigned short)_soLuongHang; {
   
   // ---- coi trừng cho các hàng cuối
   unsigned short beCao = [thongTinPhanDang beCao];
   unsigned short _soHang = [thongTinPhanDang soHangDangTinh];

   // ---- xem nếu ra ngoài phạm vi ảnh, hơn bề cao ảnh
   if( _soHang >= beCao)
      return NULL;
   
   self = [super init];
   
   if( self ) {
      // ---- coi chừng đi ra ngoài phạm vi ảnh
      if( _soHang + soLuongHang >= beCao )
         soLuongHang = beCao - _soHang;
      
      
      soHang = _soHang;
      soLuongHang = _soLuongHang;
      
      buoc = [thongTinPhanDang buocTinh];
      gocX = [thongTinPhanDang gocX];
      gocY = soHang * buoc + [thongTinPhanDang gocY];
      beRong = [thongTinPhanDang beRong];
      
      tinhJulia = [thongTinPhanDang tinhJulia];
      hangSoJuliaX = [thongTinPhanDang hangSoThat];
      hangSoJuliaY = [thongTinPhanDang hangSoAo];

      soDiem = 0;
      soLuongDiem = [thongTinPhanDang beRong]*soLuongHang;
      diaChi = soHang * beRong << 2;
      diaChiCuoi = beCao*beRong << 2;
      
      cot = 0;
      hang = 0;
      x = gocX;
      y = gocY;
      mu = [thongTinPhanDang mu];
      lapLaiToiDa = [thongTinPhanDang soLapLaiToiDa];
      lapLaiToiDaCu = [thongTinPhanDang soLapLaiToiDaCu];
      mangSoLapLai = [thongTinPhanDang mangSoLapLai];
   }
   
   return self;
}


#pragma mark ---- Main
- (void)main {
   
   if( ![self isCancelled] ) {
      
      while( soDiem < soLuongDiem ) {
         // ---- tính nếu cần
         unsigned int soLuongLapLai = mangSoLapLai[diaChi >> 2];
         
         if( soLuongLapLai < lapLaiToiDa ) {
            if( diaChi < diaChiCuoi ) {
               // ---- tính
               unsigned int soLuongLapLai = 0;
               if( tinhJulia )
                  soLuongLapLai = [giaiThuat tinhDiemThat:x ao:y hangSoThat:hangSoJuliaX ao:hangSoJuliaY  banKinhThoatMu2:4.0f mu:mu
                           gioiHanhLapLai:lapLaiToiDa];
               else
                  soLuongLapLai = [giaiThuat tinhDiemThat:x ao:y banKinhThoatMu2:4.0f mu:mu
                                           gioiHanhLapLai:lapLaiToiDa];
            
               // ---- giữ số lặp vòng tính
               mangSoLapLai[diaChi >> 2] = soLuongLapLai;
            }
         }
         else if( soLuongLapLai > lapLaiToiDa ) // nếu hơn số lặp lại cũ đặt bằng lặp lại mới
            mangSoLapLai[diaChi >> 2] = lapLaiToiDa;
         
         // ---- xem tính hàng xong chưa
         cot++;
         if( cot < beRong )
            x += buoc;
         else {
            if( [self isCancelled] )
               return;
            cot = 0;
            hang++;
            
            y += buoc;
            x = gocX;
         }
         
         diaChi += 4;
         soDiem++;
      }
      
      // ---- kêu tính chùm tiếp
      [[NSNotificationCenter defaultCenter] postNotificationName:@"星凤NângCấpẢnhChiếu" object:self];
   }
   
}


#pragma mark ---- Biến
@synthesize soHang;
@synthesize soLuongHang;

@synthesize giaiThuat;

@end
