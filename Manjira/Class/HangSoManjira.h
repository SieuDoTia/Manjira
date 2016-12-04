//
//  HangSoManjira.h
//  Manjira
//
//  Created by 小小 on 28/9/2557.
//

#ifndef Manjira_HangSoManjira_h
#define Manjira_HangSoManjira_h

enum {
   // ---- MAN = mandelbrot
   GIAI_THUAT__MAN_MU_2,
   GIAI_THUAT__MAN_MU_3,
   GIAI_THUAT__MAN_MU_4,
   GIAI_THUAT__MAN_MU_5,
   GIAI_THUAT__MAN_MU_PHAN_SO,
   GIAI_THUAT__MAN_COSH,
   GIAI_THUAT__MAN_EXP,
   
   // ---- JULIA
   GIAI_THUAT__JULIA_MU_2,
   GIAI_THUAT__JULIA_MU_3,
};

// Nếu muốn lớn hơn 65536 phải kiếm phiên bản zlib hỗ trợ đệm dữ liệu dài hơn 64 bit
// Hình như chuẩn EXR chưa hỗ trợ đệm dữ liệu cho zlib
#define kDIEM_ANH_TOI_DA   61440   // cỡ thước ảnh to nhất
#define kDIEM_ANH_TOI_THIEU 1000   // cỡ thước ảnh nhỏ nhất

#endif
