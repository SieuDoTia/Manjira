//
//  Shader.fsh
//  ShouMaoBiOpenGL
//
//  Created by 小小 on 15/7/2553.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
uniform sampler2D uniformHoaTiet;

varying vec2 varyingHoaTiet;

void main() {

    gl_FragColor = texture2D( uniformHoaTiet, varyingHoaTiet );
}
