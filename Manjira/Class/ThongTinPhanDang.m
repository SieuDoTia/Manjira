//
//  ThongTinPhanDang.m
//  Manjira
//
//  Created by 小小 on 27/9/2557.
//

#import "ThongTinPhanDang.h"
#import "ToMau.h"
#import "HangSoManjira.h"

@implementation ThongTinPhanDang

- (id)initChoTrungTamX:(double)_trungTamX y:(double)_trungTamY phongTo:(double)_phongTo beRong:(unsigned short)_beRong beCao:(unsigned short)_beCao lapLaiToiDa:(unsigned int)_lapLaiToiDa
               mangMau:(float *)_mangMau mangSoLapLai:(unsigned int *)_mangSoLapLai; {
   
   self = [super init];
   
   if( self ) {
      float tiSoChieu = (double)_beCao/(double)_beRong;
      trungTamX = _trungTamX;
      trungTamY = _trungTamY;
      phongTo = _phongTo;

      // ---- tính biên giới vùng tính
      double x0 = trungTamX - phongTo;
      double y0 = trungTamY - phongTo*tiSoChieu;
      double x1 = trungTamX + phongTo;
      double y1 = trungTamY + phongTo*tiSoChieu;

      buocTinh = (x1 - x0)/(double)_beRong;
      buocTinhPhanTu = buocTinh*0.25;
      banKinhNghiTinhMu2 = 4.0f;
      
      // ---- chỉnh giá trị bề rộng và bề cao (theo tọa độ sẽ tính)
      _beRong = (x1 - x0)/buocTinh;
      _beCao = (y1 - y0)/buocTinh;
      
      beRong = _beRong;
      beCao = _beCao;
      
      // ---- góc bắt đầu tính
      gocX = x0;
      gocY = y0;
      tinhX = x0;
      tinhY = y0;
      
      // ---- chuẩn bị tính
      tinhCot = 0;
      tinhHang = 0;
      soLuongDiemDaTinh = 0;
      soLuongDiem = (_beRong)*(_beCao);
      giaiThuat = GIAI_THUAT__MAN_MU_2;
      
      mu = 2.0;
      
      soLapLaiToiDa = _lapLaiToiDa;
      
      // ---- tô màu
      toMau = [[ToMau alloc] init];
      
      // -----
      mangSoLapLai = _mangSoLapLai;
      mangMau = _mangMau;
   }
   
   return self;
}

- (void)datBeRong:(unsigned short)_beRong; {
   
   //   float tiSoChieu = (double)doGiaiY/(double)*beRong;
   // ---- tính biên giới vùng tính
   double x0 = trungTamX - phongTo;
   //   double y0 = trungTamY - phongTo*tiSoChieu;
   double x1 = trungTamX + phongTo;
   //   double y1 = trungTamY + phongTo*tiSoChieu;
   
   buocTinh = (x1 - x0)/(double)_beRong;
   
   // ---- chỉnh giá trị bề rộng và bề cao (theo tọa độ sẽ tính)
   _beRong = (x1 - x0)/buocTinh;
   
   beRong = _beRong;

   gocX = x0;
   tinhX = x0;
   
   // ---- chuẩn bị tính
   tinhCot = 0;
   soLuongDiemDaTinh = 0;
   soLuongDiem = (_beRong)*(beCao);
}

- (void)datBeCao:(unsigned short)_beCao; {
   
   float tiSoChieu = (double)_beCao/(double)beRong;
   // ---- tính biên giới vùng tính
   //   double x0 = trungTamX - phongTo;
   double y0 = trungTamY - phongTo*tiSoChieu;
   //   double x1 = trungTamX + phongTo;
   double y1 = trungTamY + phongTo*tiSoChieu;
   
   //   buocTinh = (x1 - x0)/(double)*beRong;
   // ---- chỉnh giá trị bề rộng và bề cao (theo tọa độ sẽ tính)
   _beCao = (y1 - y0)/buocTinh;
   
   beCao = _beCao;
   //   gocX = x0;
   gocY = y0;
   //   tinhX = x0;
   tinhY = y0;
   
   // ---- chuẩn bị tính
   tinhCot = 0;
   soLuongDiemDaTinh = 0;
   soLuongDiem = beRong*(_beCao);
}


- (void)doiTrungTamX:(double)_trungTamX y:(double)_trungTamY vaPhongTo:(double)_phongTo; {
   
   phongTo = _phongTo;
   float tiSoChieu = (double)beCao/(double)beRong;
   trungTamX = _trungTamX;
   trungTamY = _trungTamY;
   
   // ---- tính biên giới vùng tính
   double x0 = trungTamX - phongTo;
   double y0 = trungTamY - phongTo*tiSoChieu;
   double x1 = trungTamX + phongTo;
   //   double y1 = trungTamY + phongTo*tiSoChieu;
   
   // ---- bước tính
   buocTinh = (x1 - x0)/(double)beRong;
   buocTinhPhanTu = buocTinh*0.25;
   
   // ---- góc bắt đầu tính
   gocX = x0;
   gocY = y0;
   tinhX = x0;
   tinhY = y0;
   
   // ---- chuẩn bị tính
   tinhCot = 0;
   tinhHang = 0;
   soLuongDiemDaTinh = 0;
   // soLuongDiem cũng như trước
}

- (void)doiTrungTamX:(double)_trungTamX y:(double)_trungTamY; {
   
   float tiSoChieu = (double)beCao/(double)beRong;
   trungTamX = _trungTamX;
   trungTamY = _trungTamY;
   
   // ---- tính biên giới vùng tính
   double x0 = trungTamX - phongTo;
   double y0 = trungTamY - phongTo*tiSoChieu;
   //   double x1 = trungTamX + phongTo;
   //   double y1 = trungTamY + phongTo*tiSoChieu;
   
   // ---- góc bắt đầu tính
   gocX = x0;
   gocY = y0;
   tinhX = x0;
   tinhY = y0;
   
   // ---- chuẩn bị tính
   tinhCot = 0;
   tinhHang = 0;
   soLuongDiemDaTinh = 0;
}

- (void)doiBeRong:(unsigned short)_beRong beCao:(unsigned short)_beCao; {
   
   if( (_beRong != 0) && (_beCao != 0) ) {
      float tiSoChieu = (double)_beCao/(double)_beRong;
      
      double x0 = trungTamX - phongTo;
      double y0 = trungTamY - phongTo*tiSoChieu;
      double x1 = trungTamX + phongTo;
      double y1 = trungTamY + phongTo*tiSoChieu;
      
      buocTinh = (x1 - x0)/(double)(_beRong);
      buocTinhPhanTu = buocTinh*0.25;
      banKinhNghiTinhMu2 = 4.0f;

      // ---- chỉnh giá trị bề rộng và bề cao (theo tọa độ sẽ tính)
      _beRong = (x1 - x0)/buocTinh;
      _beCao = (y1 - y0)/buocTinh;
      
      beRong = _beRong;
      beCao = _beCao;
      
      // ---- góc bắt đầu tính
      gocX = x0;
      gocY = y0;
      tinhX = x0;
      tinhY = y0;
      
      // ---- chuẩn bị tính
      tinhCot = 0;
      tinhHang = 0;
      soLuongDiemDaTinh = 0;
      soLuongDiem = (_beRong)*(_beCao);
   }
   else
      NSLog( @"TapHopMandelbrot: doiBeRongbeCao: bềRồng %d  bềCao %d không thể = 0", _beRong, _beCao );
}


- (void)tiSoPhongTo:(double)tiSoPhongTo quangDiemX:(double)diemX y:(double)diemY; {
   
   // ---- tính điểm cho trung tâm phóng to (không phải là trung tâm ảnh tính)
   double viTriTuongDoiX = trungTamX + beRong*diemX*buocTinh;
   double viTriTuongDoiY = trungTamY + beCao*diemY*buocTinh;
   
   phongTo *= tiSoPhongTo;
   buocTinh *= tiSoPhongTo;
   buocTinhPhanTu *= tiSoPhongTo;
   
   //   double tiSo = (double)doGiaiX/(double)doGiaiY;
   gocX = viTriTuongDoiX - (0.5 + diemX)*buocTinh*beRong;
   gocY = viTriTuongDoiY - (0.5 + diemY)*buocTinh*beCao;
   double x1 = viTriTuongDoiX + (0.5 - diemX)*buocTinh*beRong;
   double y1 = viTriTuongDoiY + (0.5 - diemY)*buocTinh*beCao;
   
   // ---- trung tâm mới
   trungTamX = (gocX + x1)*0.5;
   trungTamY = (gocY + y1)*0.5;
   
   tinhX = gocX;
   tinhY = gocY;
   
   // ---- chuẩn bị tính
   tinhCot = 0;
   tinhHang = 0;
   soLuongDiemDaTinh = 0;
}

#pragma mark ---- Di Chuyển
- (void)diChuyenSoBuoc:(unsigned short)soBuoc huong:(unsigned char)huong; {
   
   double cachDiChuyenX = 0.0;
   double cachDiChuyenY = 0.0;
   if( huong == 123 ) {  // trái
      cachDiChuyenX = -soBuoc*buocTinh;
      [self chepTrai:soBuoc beRong:beRong beCao:beCao];
   }
   else if( huong == 124 ) {  // phải
      cachDiChuyenX = soBuoc*buocTinh;
      [self chepPhai:soBuoc beRong:beRong beCao:beCao];
   }
   else if( huong == 125 ) {  // xuống
      cachDiChuyenY = -soBuoc*buocTinh;
      [self chepXuong:soBuoc beRong:beRong beCao:beCao];
   }
   else if( huong == 126 ) { // lên
      cachDiChuyenY = soBuoc*buocTinh;
      [self chepLen:soBuoc beRong:beRong beCao:beCao];
   }
   
   trungTamX += cachDiChuyenX;
   trungTamY += cachDiChuyenY;
   gocX += cachDiChuyenX;
   gocY += cachDiChuyenY;
   
   // ----
   tinhX = gocX;
   tinhY = gocY;
   
   // ---- chuẩn bị tính
   tinhCot = 0;
   tinhHang = 0;
   soLuongDiemDaTinh = 0;
}


#pragma mark ---- Chép
// trái:  chép --->
- (void)chepTrai:(unsigned short)cachChepQua beRong:(unsigned short)_beRong beCao:(unsigned short)_beCao; {
   
   unsigned short soHang = 0;
   
   unsigned short cachChepMau = cachChepQua << 2;
   //   unsigned short soCotCuoi = beRong - cachChepQua;
   
   while( soHang < _beCao ) {
      unsigned short soCot = _beRong - 1;
      unsigned int diaChi = soHang*_beRong + soCot;
      unsigned int diaChiMau = diaChi << 2;
      
      // ---- chép
      while ( soCot > cachChepQua ) {
         mangMau[diaChiMau+cachChepMau] = mangMau[diaChiMau];
         mangMau[diaChiMau+cachChepMau+1] = mangMau[diaChiMau+1];
         mangMau[diaChiMau+cachChepMau+2] = mangMau[diaChiMau+2];
         mangMau[diaChiMau+cachChepMau+3] = mangMau[diaChiMau+3];
         mangSoLapLai[diaChi+cachChepQua] = mangSoLapLai[diaChi];
         soCot--;
         diaChi--;
         diaChiMau -= 4;
      }
      
      // ---- xóa, tô màu trắng
      while ( soCot > 0 ) {
         mangMau[diaChiMau] = 1.0f;
         mangMau[diaChiMau+1] = 1.0f;
         mangMau[diaChiMau+2] = 1.0f;
         mangMau[diaChiMau+3] = 1.0f;
         mangSoLapLai[diaChi] = 0;
         soCot--;
         diaChi--;
         diaChiMau -= 4;
      }
      soHang++;
      
   }
}

// phải:  chép <---
- (void)chepPhai:(unsigned short)cachChepQua beRong:(unsigned short)_beRong beCao:(unsigned short)_beCao; {
   
   unsigned short soHang = 0;
   unsigned int diaChi = 0;
   unsigned int diaChiMau = 0;
   unsigned short cachChepMau = cachChepQua << 2;
   unsigned short soCotCuoi = _beRong - cachChepQua;
   
   while( soHang < _beCao ) {
      unsigned short soCot = 0;
      
      // ---- chép
      while ( soCot < soCotCuoi ) {
         mangMau[diaChiMau] = mangMau[diaChiMau+cachChepMau];
         mangMau[diaChiMau+1] = mangMau[diaChiMau+cachChepMau+1];
         mangMau[diaChiMau+2] = mangMau[diaChiMau+cachChepMau+2];
         mangMau[diaChiMau+3] = mangMau[diaChiMau+cachChepMau+3];
         mangSoLapLai[diaChi] = mangSoLapLai[diaChi+cachChepQua];
         soCot++;
         diaChi++;
         diaChiMau += 4;
      }
      
      // ---- xóa, tô màu trắng
      while ( soCot < _beRong ) {
         mangMau[diaChiMau] = 1.0f;
         mangMau[diaChiMau+1] = 1.0f;
         mangMau[diaChiMau+2] = 1.0f;
         mangMau[diaChiMau+3] = 1.0f;
         mangSoLapLai[diaChi] = 0;
         soCot++;
         diaChi++;
         diaChiMau += 4;
      }
      
      soHang++;
      
      //      NSLog( @"chepPhi: sohang %d dia" );
   }
}

// xuống:  chép ^
- (void)chepXuong:(unsigned short)cachChep beRong:(unsigned short)_beRong beCao:(unsigned short)_beCao; {
   
   unsigned short soHang = _beCao - 1 - cachChep;
   unsigned int diaChi = 0;
   unsigned int diaChiMau = 0;
   //   unsigned short soHangCuoi = beCao - cachChep;
   
   cachChep *= _beRong;
   unsigned short cachChepMau = cachChep << 2;
   diaChi = soHang*_beRong;
   diaChiMau = diaChi << 2;
   
   while( soHang > 0 ) {
      unsigned short soCot = 0;
      unsigned int diaChi = soHang*beRong + soCot;
      unsigned int diaChiMau = diaChi << 2;
      
      // ---- chép
      while ( soCot < beRong ) {
         mangMau[diaChiMau+cachChepMau] = mangMau[diaChiMau];
         mangMau[diaChiMau+cachChepMau+1] = mangMau[diaChiMau+1];
         mangMau[diaChiMau+cachChepMau+2] = mangMau[diaChiMau+2];
         mangMau[diaChiMau+cachChepMau+3] = mangMau[diaChiMau+3];
         mangSoLapLai[diaChi+cachChep] = mangSoLapLai[diaChi];
         soCot++;
         diaChi++;
         diaChiMau += 4;
      }
      
      soHang--;
      
      //      NSLog( @"chepPhi: sohang %d dia" );
   }
   
   soHang = beCao - 1 - cachChep;
   diaChi = soHang*beRong;
   diaChiMau = diaChi << 2;
   
   while ( soHang < beCao) {
      unsigned short soCot = 0;
      // ---- xóa
      while ( soCot < beRong ) {
         mangMau[diaChiMau] = 1.0f;
         mangMau[diaChiMau+1] = 1.0f;
         mangMau[diaChiMau+2] = 1.0f;
         mangMau[diaChiMau+3] = 1.0f;
         mangSoLapLai[diaChi] = 0;
         soCot++;
         diaChi++;
         diaChiMau += 4;
      }
      soHang++;
   }
}

// lên:  chép v
- (void)chepLen:(unsigned short)cachChepQua beRong:(unsigned short)_beRong beCao:(unsigned short)_beCao; {
   
   unsigned short soHang = 0;
   unsigned int diaChi = 0;
   unsigned int diaChiMau = 0;
   unsigned short soHangCuoi = _beCao - cachChepQua;
   
   cachChepQua *= _beRong;
   unsigned short cachChepMau = cachChepQua << 2;
   
   while( soHang < soHangCuoi ) {
      unsigned short soCot = 0;
      
      // ---- chép
      while ( soCot < _beRong ) {
         mangMau[diaChiMau] = mangMau[diaChiMau+cachChepMau];
         mangMau[diaChiMau+1] = mangMau[diaChiMau+cachChepMau+1];
         mangMau[diaChiMau+2] = mangMau[diaChiMau+cachChepMau+2];
         mangMau[diaChiMau+3] = mangMau[diaChiMau+cachChepMau+3];
         mangSoLapLai[diaChi] = mangSoLapLai[diaChi+cachChepQua];
         soCot++;
         diaChi++;
         diaChiMau += 4;
      }
      
      soHang++;
      
      //      NSLog( @"chepPhi: sohang %d dia" );
   }
   
   while ( soHang < beCao) {
      unsigned short soCot = 0;
      // ---- xóa
      while ( soCot < beRong ) {
         mangMau[diaChiMau] = 1.0f;
         mangMau[diaChiMau+1] = 1.0f;
         mangMau[diaChiMau+2] = 1.0f;
         mangMau[diaChiMau+3] = 1.0f;
         mangSoLapLai[diaChi] = 0;
         soCot++;
         diaChi++;
         diaChiMau += 4;
      }
      soHang++;
   }
}

#pragma mark ---- Chép Thông Tin 
+ (void)chepThongTinChieu:(ThongTinPhanDang *)thongTinPhanDangChieu
          vaoThongTinXuat:(ThongTinPhanDang *)thongTinPhanDangXuat; {
   
   // ----
   [thongTinPhanDangXuat doiTrungTamX:[thongTinPhanDangChieu trungTamX] y:[thongTinPhanDangChieu trungTamY]
                            vaPhongTo:[thongTinPhanDangChieu phongTo]];
   [thongTinPhanDangXuat setBanKinhNghiTinhMu2:[thongTinPhanDangChieu banKinhNghiTinhMu2]];
   [thongTinPhanDangXuat setGiaiThuat:[thongTinPhanDangChieu giaiThuat]];
   [thongTinPhanDangXuat setSoLapLaiToiDa:[thongTinPhanDangChieu soLapLaiToiDa]];
   
   // ---- chép tô màu
   [ToMau chepToMauNguon:[thongTinPhanDangChieu toMau] toMauDich:[thongTinPhanDangXuat toMau]];

   // ---- Julia
   [thongTinPhanDangXuat setTinhJulia:[thongTinPhanDangChieu tinhJulia]];
   [thongTinPhanDangXuat setHangSoThat:[thongTinPhanDangChieu hangSoThat]];
   [thongTinPhanDangXuat setHangSoAo:[thongTinPhanDangChieu hangSoAo]];
}


#pragma mark ---- Biến
- (void)datMangMau:(float *)_mangMau mangSoLuongLapLai:(unsigned int *)_mangSoLuongLapLai
     vaSoLuongDiem:(unsigned int)_soLuongDiem; {
   
   mangMau = _mangMau;
   mangSoLapLai = _mangSoLuongLapLai;
   
   soLuongDiem = _soLuongDiem;
   // ---- phải bắt đầu tính lại, đặt này bằng 0
   soLuongDiemDaTinh = 0;
}


- (void)datLaiSoLuongDiemDaTinh; {
   
   soLuongDiemDaTinh = 0;
}

@synthesize gocX;
@synthesize gocY;
@synthesize trungTamX;
@synthesize trungTamY;
@synthesize phongTo;
@synthesize buocTinh;
@synthesize banKinhNghiTinhMu2;

@synthesize beRong;
@synthesize beCao;

@synthesize soHangDangTinh;
- (void)congThemVpoiSoHangDangTinh:(unsigned short)soLuongHangThem; {
   
   soHangDangTinh += soLuongHangThem;
}

@synthesize tinhJulia;
@synthesize hangSoThat;
@synthesize hangSoAo;


- (unsigned int)soLapLaiToiDa; {
   return soLapLaiToiDa;
}

- (void)setSoLapLaiToiDa:(unsigned int)_soLapLaiToiDa; {
   soLapLaiToiDaCu = soLapLaiToiDa;
   soLapLaiToiDa = _soLapLaiToiDa;
}
@synthesize soLapLaiToiDaCu;

@synthesize mu;
@synthesize giaiThuat;

@synthesize toMau;

@synthesize soLuongDiemDaTinh;
@synthesize soLuongDiem;

@synthesize mangSoLapLai;
@synthesize mangMau;

- (BOOL)tinhLaiSoLapLai; {
   return tinhLaiSoLapLai;
}

- (void)setTinhLaiSoLapLai:(BOOL)tinhLai; {

   tinhLaiSoLapLai = tinhLai;
   tinhX = gocX;
   tinhY = gocY;
   
   // ---- chuẩn bị tính
   tinhCot = 0;
   tinhHang = 0;
   soLuongDiemDaTinh = 0;
}

@end
