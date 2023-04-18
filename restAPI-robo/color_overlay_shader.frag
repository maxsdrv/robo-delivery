#version 440

layout(location=0) in vec2 qt_TexCoord0;
layout(location=0) out vec4 fragColor;

layout(std140, binding=0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec4 alphaChannel;
} ubuf;

layout(binding=1) uniform sampler2D source;

void main()
{
    vec4 src = texture(source, qt_TexCoord0);
    vec4 blendedColor = mix(ubuf.alphaChannel, src, src.a);
//    fragColor = src * vec4(ubuf.alphaChannel.rgb, 1.0) * ubuf.qt_Opacity;
    fragColor = src * vec4(blendedColor.rgb, src.a) * ubuf.qt_Opacity;
}
