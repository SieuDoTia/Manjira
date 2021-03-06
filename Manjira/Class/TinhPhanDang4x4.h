//
//  TinhPhanDang4x4.h
//  Manjira
//
//  Created by 小小 on 10/10/2557.
//

#import <Foundation/Foundation.h>
#import "GiaiThuat.h"

@class ThongTinPhanDang;

@interface TinhPhanDang4x4 : NSOperation {
   double buoc;
   double buocTinhPhanTu;
   double gocX;
   double gocY;
   double banKinhNghiTinhMu2;
   unsigned short beRong;
   unsigned int diaChiCuoi; // cho bảo vệ đi huốt ngaòi mảng
   
   unsigned int soDiem;
   unsigned int soLuongDiem;
   unsigned int diaChi;
   unsigned short cot;
   unsigned short hang;
   double x;
   double y;
   double mu;
   
   // ---- cho Julia
   BOOL tinhJulia;
   double hangSoJuliaX;
   double hangSoJuliaY;

   // ---- lặp lại
   unsigned int lapLaiToiDa;
   unsigned int *mangSoLapLai;
   
   unsigned short soHang;
   unsigned short soLuongHang;
   
   id <GiaiThuat>  giaiThuat;
}

- (id)initVoiThongTinPhanDang:(ThongTinPhanDang *)thongTinPhanDang soLuongHang:(unsigned short)_soLuongHang;
@property (readonly) unsigned short soHang;
@property (readonly) unsigned short soLuongHang;

@property (readwrite) id <GiaiThuat> giaiThuat;


@end
