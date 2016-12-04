//
//  TinhLaiPhanDang1x1.h
//  Manjira
//
//  Created by 小小 on 10/10/2557.
//

#import <Foundation/Foundation.h>
#import "GiaiThuat.h"

@class ThongTinPhanDang;

@interface TinhLaiPhanDang1x1 : NSOperation {

   double buoc;
   double gocX;
   double gocY;
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
   unsigned int lapLaiToiDaCu;
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
