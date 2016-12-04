//
//  GiaiThuat_MJ_3.h
//  Manjira
//
//  Created by 小小 on 10/10/2557.
//  Copyright (c) 2557 BE 星凤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GiaiThuat.h"

@interface GiaiThuat_MJ_3 : NSObject <GiaiThuat>

// ---- Mandelbrot
- (unsigned int)tinhDiemThat:(double)that ao:(double)ao banKinhThoatMu2:(double)banKinhThoat_mu2 mu:(double)mu
              gioiHanhLapLai:(unsigned int)gioiHanLapLai;

// ---- Julia
- (unsigned int)tinhDiemThat:(double)that ao:(double)ao hangSoThat:(double)hangSoThat ao:(double)hangSoAo
             banKinhThoatMu2:(double)banKinhThoat_mu2 mu:(double)mu
              gioiHanhLapLai:(unsigned int)gioiHanLapLai;
@end
