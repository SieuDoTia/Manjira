//
//  GiaiThuat_MJ_PhanSo.m
//  Manjira
//
//  Created by 小小 on 10/10/2557.
//  Copyright (c) 2557 BE 星凤. All rights reserved.
//

#import "GiaiThuat_MJ_PhanSo.h"

@implementation GiaiThuat_MJ_PhanSo

// ---- Mandelbrot
- (unsigned int)tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 mu:(double)mu gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
   
   unsigned int soLapLai = 0;  // số lặp lại
   
   double phanThat = that;
   double phanAo = ao;
   double ketQua_mu2 = that*that + ao*ao;
   
   while( (ketQua_mu2 < banKinhThoat_mu2) && (soLapLai < gioiHanLapLai) ) {
      
      // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
      // ---- tính kinh và mũ cho sế phức này
      double banKinh = pow( ketQua_mu2, mu*0.5 );
      double goc = atan( phanAo/phanThat);
      
      // ---- giữ -π ≤ góc ≤ π
      if( phanThat < 0.0 ) {
         if( phanAo < 0.0 )
            goc -= 3.14159265358979323846;
         else
            goc += 3.14159265358979323846;
      }
      
      double thatMoi = banKinh * cos( goc*mu ) + that;
      double aoMoi = banKinh * sin( goc*mu ) + ao;
      
      phanThat = thatMoi;
      phanAo = aoMoi;
      ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
      soLapLai++;
   }
   
   return soLapLai;
}


// ---- Julia
- (unsigned int)tinhDiemThat:(double)that ao:(double)ao hangSoThat:(double)hangSoThat ao:(double)hangSoAo
             banKinhThoatMu2:(double)banKinhThoat_mu2 mu:(double)mu
              gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
   
   unsigned int soLapLai = 0;  // số lặp lại
   
   double phanThat = that;
   double phanAo = ao;
   double ketQua_mu2 = that*that + ao*ao;
   
   while( (ketQua_mu2 < banKinhThoat_mu2) && (soLapLai < gioiHanLapLai) ) {
      
      // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
      // ---- tính kinh và mũ cho sế phức này
      double banKinh = pow( ketQua_mu2, mu*0.5 );
      double goc = atan( phanAo/phanThat);
      
      // ---- giữ -π ≤ góc ≤ π
      if( phanThat < 0.0 ) {
         if( phanAo < 0.0 )
            goc -= 3.14159265358979323846;
         else
            goc += 3.14159265358979323846;
      }
      
      double thatMoi = banKinh * cos( goc*mu ) + hangSoThat;
      double aoMoi = banKinh * sin( goc*mu ) + hangSoAo;
      
      phanThat = thatMoi;
      phanAo = aoMoi;
      ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
      soLapLai++;
   }
   
   return soLapLai;
}

@end
