//
//  GiaiThuat_MJ_4.m
//  Manjira
//
//  Created by 小小 on 10/10/2557.
//  Copyright (c) 2557 BE 星凤. All rights reserved.
//

#import "GiaiThuat_MJ_4.h"

@implementation GiaiThuat_MJ_4

// ---- Mandelbrot
- (unsigned int)tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 mu:(double)mu
              gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
   
   unsigned int soLapLai = 0;  // số lặp lại
   
   double phanThat = that;
   double phanAo = ao;
   double ketQua_mu2 = that*that + ao*ao;
   
   while( (ketQua_mu2 < banKinhThoat_mu2) && (soLapLai < gioiHanLapLai) ) {
      
      // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
      double t0 = phanThat*phanThat - phanAo*phanAo;
      double a0 = 2.0*phanThat*phanAo;
      double t1 = t0*phanThat - a0*phanAo;  // + that  <----
      double a1 = t0*phanAo + a0*phanThat;  // + ao
      double thatMoi = t1*phanThat - a1*phanAo + that;
      double aoMoi = t1*phanAo + a1*phanThat + ao;
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
      double t0 = phanThat*phanThat - phanAo*phanAo;
      double a0 = 2.0*phanThat*phanAo;
      double t1 = t0*phanThat - a0*phanAo;  // + that  <----
      double a1 = t0*phanAo + a0*phanThat;  // + ao
      double thatMoi = t1*phanThat - a1*phanAo + hangSoThat;
      double aoMoi = t1*phanAo + a1*phanThat + hangSoAo;
      phanThat = thatMoi;
      phanAo = aoMoi;
      ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
      soLapLai++;
   }
   
   return soLapLai;
}

@end
