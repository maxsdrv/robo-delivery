#version 310 es
uniform sampler2D qt_Texture0;
varying vec4 qt_TexCoord0;
uniform lowp float qt_Opacity;
uniform lowp vec4 color;

void main(void)
{
    lowp vec4 src = texture2D(qt_Texture0, qt_TexCoord0);
    gl_FragColor = vec4(src.rgb * color.rgb, src.a) * qt_Opacity;
}
