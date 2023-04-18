#version 440

layout(location=0) in vec2 qt_TexCoord0;
layout(location=0) out vec4 fragColor;

layout(std140, binding=0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float redChannel;
} ubuf;

layout(binding=1) uniform sampler2D source;

void main()
{
//    vec4 src = texture(source, qt_TexCoord0) * ubuf.qt_Opacity;
//    fragColor = vec4(src.rgb * ubuf.color.rgb, src.a);
    vec4 src = texture(source, qt_TexCoord0);
    fragColor = src * vec4(ubuf.redChannel, 1.0, 1.0, 1.0) * ubuf.qt_Opacity;
}
