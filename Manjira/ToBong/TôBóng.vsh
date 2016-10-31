//
//  ToBong.vsh
//  ShouMaoBiOpenGL
//
//  Created by 小小 on 15/7/2553.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

attribute vec3 dinh;
attribute vec4 mau;


uniform mat4 maTranChieu;
//uniform mat4 maTranMoPhongMan;

varying vec4 varyingMau;

void main() {

   gl_Position = maTranChieu * vec4( dinh, 1.0 );

   varyingMau = mau;
}
