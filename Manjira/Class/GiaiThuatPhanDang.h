//
//  GiaiThuatPhanDang.h
//  Manjira
//
//  Created by 小小 on 29/12/2556.
//  Copyright (c) 2556 BE 星凤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiaiThuatPhanDang : NSObject

// ---- Mandelbrot
+ (unsigned int)giaiThuat2_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai;

+ (unsigned int)giaiThuat3_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai;

+ (unsigned int)giaiThuat4_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai;

+ (unsigned int)giaiThuat5_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai;

+ (unsigned int)giaiThuatMu_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 mu:(double)mu gioiHanhLapLai:(unsigned int)gioiHanLapLai;

+ (unsigned int)exp_mu2_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai;

+ (unsigned int)exp_mu3_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai;

+ (unsigned int)coshz2_z_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai;

+ (unsigned int)coshz3_z_tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 gioiHanhLapLai:(unsigned int)gioiHanLapLai;

// ---- Julia
@end
