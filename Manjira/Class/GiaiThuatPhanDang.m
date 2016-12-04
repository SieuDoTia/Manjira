//
//  GiaiThuatPhanDang.m
//  Manjira
//
//  Created by 小小 on 29/12/2556.
//  Copyright (c) 2556 BE 星凤. All rights reserved.
//

#import "GiaiThuatPhanDang.h"

@implementation GiaiThuatPhanDang

#pragma mark ---- Các Giải Thuật Mandelbrot


//z_n+1 = (z_n + c)^2
+ (unsigned int)giaiThuat2_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
   
   unsigned int soLapLai = 0;  // số lặp lại
   
   double phanThat = that;
   double phanAo = ao;
   double ketQua_mu2 = that*that + ao*ao;
   
   while( (ketQua_mu2 < banKinhThoat_mu2) && (soLapLai < gioiHanLapLai) ) {
      
      // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
      double thatMoi = phanThat*phanThat - phanAo*phanAo + that;
      double aoMoi = 2.0*phanThat*phanAo + ao;
      phanThat = thatMoi;
      phanAo = aoMoi;
      ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
      soLapLai++;
   }
   
   return soLapLai;
}

 //z_n+1 = (z_n + c)^2  ?
 + (unsigned int)giaiThuat0_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
 
 unsigned int soLapLai = 0;  // số lặp lại
 
 double phanThat = that;
 double phanAo = ao;
 double ketQua_mu2 = that*that + ao*ao;
 
 while( (ketQua_mu2 < banKinhThoat_mu2) && (soLapLai < gioiHanLapLai) ) {
 
 // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
 phanThat = phanThat + that;
 phanAo = phanAo + ao;
 double thatMu2 = phanThat*phanThat - phanAo*phanAo;
 double aoMu2 = 2.0*phanThat*phanAo;
 phanThat = thatMu2;
 phanAo = aoMu2;
 ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
 soLapLai++;
 }
 
 return soLapLai;
 }
 
 // z_n+1 = (z_n)^2 + c
 /*
 + (unsigned int)giaiThuat1_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
 
 unsigned int soLapLai = 0;  // số lặp lại
 
 double phanThat = that;
 double phanAo = ao;
 double ketQua_mu2 = that*that + ao*ao;
 
 while( (ketQua_mu2 < banKinhThoat_mu2) && (soLapLai < gioiHanLapLai) ) {
 
 // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
 phanThat = phanThat*phanThat - phanAo*phanAo + that;
 phanAo = phanThat*phanAo*2.0 + ao;
 ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
 soLapLai++;
 }
 
 return soLapLai;
 }
 */

// (a + bi) * (a + bi) * (a + bi) = [(a^2 - b^2) + (2ab)i] * (a + bi)
//   = [(a^2 - b^2)*a - 2ab^2] + [(a^2 - b^2)*b + 2a^2 b]i
+ (unsigned int)giaiThuat3_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
   
   unsigned int soLapLai = 0;  // số lặp lại
   
   double phanThat = that;
   double phanAo = ao;
   double ketQua_mu2 = that*that + ao*ao;
   
   while( (ketQua_mu2 < banKinhThoat_mu2) && (soLapLai < gioiHanLapLai) ) {
      
      // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
      double t0 = phanThat*phanThat - phanAo*phanAo;
      double a0 = 2.0*phanThat*phanAo;
      double thatMoi = t0*phanThat - a0*phanAo + that;
      double aoMoi = t0*phanAo + a0*phanThat + ao;
      phanThat = thatMoi;
      phanAo = aoMoi;
      ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
      soLapLai++;
   }
   
   return soLapLai;
}

+ (unsigned int)giaiThuat4_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
   
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

+ (unsigned int)giaiThuat5_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
   
   unsigned int soLapLai = 0;  // số lặp lại
   
   double phanThat = that;
   double phanAo = ao;
   double ketQua_mu2 = that*that + ao*ao;
   
   while( (ketQua_mu2 < banKinhThoat_mu2) && (soLapLai < gioiHanLapLai) ) {
      
      // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
      double t0 = phanThat*phanThat - phanAo*phanAo;
      double a0 = 2.0*phanThat*phanAo;
      double t1 = t0*phanThat - a0*phanAo;
      double a1 = t0*phanAo + a0*phanThat;
      double t2 = t1*phanThat - a1*phanAo;
      double a2 = t1*phanAo + a1*phanThat;
      double thatMoi = t2*phanThat - a2*phanAo + that;
      double aoMoi = t2*phanAo + a2*phanThat + ao;
      phanThat = thatMoi;
      phanAo = aoMoi;
      ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
      soLapLai++;
   }
   
   return soLapLai;
}

+ (unsigned int)giaiThuatMu_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 mu:(double)mu gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
   
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

#pragma mark ---- Exp
#pragma mark ---- Mandelbrot Exp z^2
+ (unsigned int)exp_mu2_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
   
   unsigned int soLapLai = 0;  // số lặp lại
   
   double phanThat = that;
   double phanAo = ao;
   double ketQua_mu2 = that*that + ao*ao;
   
   while( (ketQua_mu2 < banKinhThoat_mu2) && (soLapLai < gioiHanLapLai) ) {
      
      // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
      double t0 = phanThat*phanThat - phanAo*phanAo + that;
      double a0 = 2.0*phanThat*phanAo + ao;
      
      double thatMoi = exp(t0) * cos(a0) + that;
      double aoMoi = exp(t0) * sin(a0) + ao;
      
      phanThat = thatMoi;
      phanAo = aoMoi;
      ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
      soLapLai++;
   }
   
   return soLapLai;
}

+ (unsigned int)exp_mu3_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
   
   unsigned int soLapLai = 0;  // số lặp lại
   
   double phanThat = that;
   double phanAo = ao;
   double ketQua_mu2 = that*that + ao*ao;
   
   while( (ketQua_mu2 < banKinhThoat_mu2) && (soLapLai < gioiHanLapLai) ) {
      
      // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
      double t0 = phanThat*phanThat - phanAo*phanAo;
      double a0 = 2.0*phanThat*phanAo;
      double t1 = t0*phanThat - a0*phanAo + that;
      double a1 = t0*phanAo + a0*phanThat + ao;
      
      double thatMoi = exp(t1) * cos(a1) + that;
      double aoMoi = exp(t1) * sin(a1) + ao;
      phanThat = thatMoi;
      phanAo = aoMoi;
      ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
      soLapLai++;
   }
   
   return soLapLai;
}

#pragma mark ---- Cosh
+ (unsigned int)coshz2_z_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
   
   unsigned int soLapLai = 0;  // số lặp lại

   double phanThat = that;
   double phanAo = ao;
   double ketQua_mu2 = that*that + ao*ao;

   while( (ketQua_mu2 < banKinhThoat_mu2) && (soLapLai < gioiHanLapLai) ) {
      
      // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
      double t0 = phanThat*phanThat - phanAo*phanAo + that;
      double a0 = 2.0*phanThat*phanAo + ao;
      
      double thatMoi = sinh(t0) * cos(a0) + that;
      double aoMoi = cosh(t0) * sin(ao) + ao;

      phanThat = thatMoi;
      phanAo = aoMoi;
      ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
      soLapLai++;
   }
   
   return soLapLai;
}

+ (unsigned int)coshz3_z_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
   
   unsigned int soLapLai = 0;  // số lặp lại
   
   double phanThat = that;
   double phanAo = ao;
   double ketQua_mu2 = that*that + ao*ao;
   
   while( (ketQua_mu2 < banKinhThoat_mu2) && (soLapLai < gioiHanLapLai) ) {
      
      // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
      double t0 = phanThat*phanThat - phanAo*phanAo + that;
      double a0 = 2.0*phanThat*phanAo + ao;
      double t1 = t0*phanThat - a0*phanAo + that;
      double a1 = t0*phanAo + a0*phanThat + ao;
      
      double thatMoi = sinh(t1) * cos(a1) + that;
      double aoMoi = cosh(t1) * sin(a1) + ao;
      phanThat = thatMoi;
      phanAo = aoMoi;
      ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
      soLapLai++;
   }
   
   return soLapLai;
}


+ (unsigned int)sinError_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
   
   unsigned int soLapLai = 0;  // số lặp lại
   
   double phanThat = that;
   double phanAo = ao;
   double ketQua_mu2 = that*that + ao*ao;
   
   while( (ketQua_mu2 < banKinhThoat_mu2) && (soLapLai < gioiHanLapLai) ) {
      
      // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
      double thatMoi = -sinh(phanAo) * cos(phanThat) + that;
      double aoMoi = cosh(phanAo) * sin(phanThat) + ao;
      phanThat = thatMoi;
      phanAo = aoMoi;
      ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
      soLapLai++;
   }
   
   return soLapLai;
}



#pragma mark ---- Các Giải Thuật Julia
+ (unsigned int)giaiThuat2_Julia_tinhDiemThat:(double)that ao:(double)ao hangSoThat:(double)hangSoThat hangSoAo:(double)hangSoAo banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
   
   unsigned int soLapLai = 0;  // số lặp lại
   
   double phanThat = that + hangSoThat;
   double phanAo = ao + hangSoAo;
   double ketQua_mu2 = that*that + ao*ao;
   
   while( (ketQua_mu2 < banKinhThoat_mu2) && (soLapLai < gioiHanLapLai) ) {
      
      // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
      double thatMoi = phanThat*phanThat - phanAo*phanAo + hangSoThat;
      double aoMoi = 2.0*phanThat*phanAo + hangSoAo;
      phanThat = thatMoi;
      phanAo = aoMoi;
      ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
      soLapLai++;
   }
   
   return soLapLai;
}

+ (unsigned int)giaiThuat3_Julia_tinhDiemThat:(double)that ao:(double)ao hangSoThat:(double)hangSoThat hangSoAo:(double)hangSoAo banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai; {
   
   unsigned int soLapLai = 0;  // số lặp lại
   
   double phanThat = that + hangSoThat;
   double phanAo = ao + hangSoAo;
   double ketQua_mu2 = that*that + ao*ao;
   
   while( (ketQua_mu2 < banKinhThoat_mu2) && (soLapLai < gioiHanLapLai) ) {
      
      // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
      double t0 = phanThat*phanThat - phanAo*phanAo;
      double a0 = 2.0*phanThat*phanAo;
      double thatMoi = t0*phanThat - a0*phanAo + hangSoThat;
      double aoMoi = t0*phanAo + a0*phanThat + hangSoAo;
      phanThat = thatMoi;
      phanAo = aoMoi;
      ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
      soLapLai++;
   }
   
   return soLapLai;
}

unsigned int (^giaiThuat2)(double, double, double, unsigned int) = ^(double that, double ao, double banKinhThoatMu2, unsigned int soLapLaiToiDa) {
   
   unsigned int soLapLai = 0;  // số lặp lại
   
   double phanThat = that;
   double phanAo = ao;
   double ketQua_mu2 = that*that + ao*ao;
   
   while( (ketQua_mu2 < banKinhThoatMu2) && (soLapLai < soLapLaiToiDa) ) {
      
      // (a + bi) * (a + bi) = (a^2 - b^2) + (2ab)i
      double thatMoi = phanThat*phanThat - phanAo*phanAo + that;
      double aoMoi = 2.0*phanThat*phanAo + ao;
      phanThat = thatMoi;
      phanAo = aoMoi;
      ketQua_mu2 = phanThat*phanThat + phanAo*phanAo;
      soLapLai++;
   }
   
   return soLapLai;
};

@end
