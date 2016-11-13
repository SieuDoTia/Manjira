//
//  TinhPhanDang4x4.m
//  Manjira
//
//  Created by 小小 on 10/10/2557.
//

#import "TinhPhanDang4x4.h"
#import "ThongTinPhanDang.h"
#import "GiaiThuatPhanDang.h"

@implementation TinhPhanDang4x4

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
      if( _soHang + soLuongHang >= beCao ) {
         soLuongHang = beCao - _soHang;
      }

      soHang = _soHang;
      soLuongHang = _soLuongHang;
      
      buoc = [thongTinPhanDang buocTinh];
      buocTinhPhanTu = buoc*0.25;
      banKinhNghiTinhMu2 = [thongTinPhanDang banKinhNghiTinhMu2];
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
      
      mangSoLapLai = [thongTinPhanDang mangSoLapLai];
   }
   
   return self;
}


#pragma mark ---- Main
- (void)main {
   
   if( ![self isCancelled] ) {
      
      while( soDiem < soLuongDiem ) {
         // ---- tính
         unsigned int soLuongLapLai0 = 0;
         unsigned int soLuongLapLai1 = 0;
         unsigned int soLuongLapLai2 = 0;
         unsigned int soLuongLapLai3 = 0;

         if( tinhJulia ) {
            soLuongLapLai0 = [giaiThuat tinhDiemThat:x-buocTinhPhanTu ao:y-buocTinhPhanTu
                              hangSoThat:hangSoJuliaX ao:hangSoJuliaY banKinhThoatMu2:banKinhNghiTinhMu2 mu:mu
                                      gioiHanhLapLai:lapLaiToiDa];
            soLuongLapLai1 = [giaiThuat tinhDiemThat:x+buocTinhPhanTu ao:y-buocTinhPhanTu
                                          hangSoThat:hangSoJuliaX ao:hangSoJuliaY banKinhThoatMu2:banKinhNghiTinhMu2 mu:mu
                                      gioiHanhLapLai:lapLaiToiDa];
            soLuongLapLai2 = [giaiThuat tinhDiemThat:x-buocTinhPhanTu ao:y+buocTinhPhanTu
                                          hangSoThat:hangSoJuliaX ao:hangSoJuliaY banKinhThoatMu2:banKinhNghiTinhMu2 mu:mu
                                      gioiHanhLapLai:lapLaiToiDa];
            soLuongLapLai3 = [giaiThuat tinhDiemThat:x+buocTinhPhanTu ao:y+buocTinhPhanTu
                                          hangSoThat:hangSoJuliaX ao:hangSoJuliaY banKinhThoatMu2:banKinhNghiTinhMu2 mu:mu
                                      gioiHanhLapLai:lapLaiToiDa];
         }
         else {
            soLuongLapLai0 = [giaiThuat tinhDiemThat:x-buocTinhPhanTu ao:y-buocTinhPhanTu
                                     banKinhThoatMu2:banKinhNghiTinhMu2 mu:mu gioiHanhLapLai:lapLaiToiDa];
            soLuongLapLai1 = [giaiThuat tinhDiemThat:x+buocTinhPhanTu ao:y-buocTinhPhanTu
                                                  banKinhThoatMu2:banKinhNghiTinhMu2 mu:mu gioiHanhLapLai:lapLaiToiDa];
            soLuongLapLai2 = [giaiThuat tinhDiemThat:x-buocTinhPhanTu ao:y+buocTinhPhanTu
                                                  banKinhThoatMu2:banKinhNghiTinhMu2 mu:mu gioiHanhLapLai:lapLaiToiDa];
            soLuongLapLai3 = [giaiThuat tinhDiemThat:x+buocTinhPhanTu ao:y+buocTinhPhanTu
                                                  banKinhThoatMu2:banKinhNghiTinhMu2 mu:mu gioiHanhLapLai:lapLaiToiDa];
         }
         
         // ---- giữ số lặp vòng tính
         if( diaChi < diaChiCuoi ) {
            mangSoLapLai[diaChi] = soLuongLapLai0;
            mangSoLapLai[diaChi+1] = soLuongLapLai1;
            mangSoLapLai[diaChi+2] = soLuongLapLai2;
            mangSoLapLai[diaChi+3] = soLuongLapLai3;
         }
         
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
      [[NSNotificationCenter defaultCenter] postNotificationName:@"星凤NângCấpẢnhXuất" object:self];
   }
   
}


#pragma mark ---- Biến
@synthesize soHang;
@synthesize soLuongHang;

@synthesize giaiThuat;

@end
