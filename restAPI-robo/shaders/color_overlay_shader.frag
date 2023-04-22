#version 440

layout(location=0) in vec2 qt_TexCoord0;
layout(location=0) out vec4 fragColor;

layout(std140, binding=0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float alphaChannel; // image color
    float rotation; // image rotation
    float width; // image width
    float height; // image height
} ubuf;


layout(binding=1) uniform sampler2D source;

void main()
{
    float angle = radians(ubuf.rotation);
    float s = sin(angle);
    float c = cos(angle);
    mat2 rotationMatrix = mat2(c, -s, s, c);

    vec2 center = vec2(0.5, 0.5);
    vec2 rotatedTexCoord = (qt_TexCoord0 - center) * rotationMatrix + center;

    vec4 src = texture(source, qt_TexCoord0);
    //vec4 src = texture(source, rotatedTexCoord);
    fragColor = src * vec4(ubuf.alphaChannel, 1.0, 1.0, 1.0) * ubuf.qt_Opacity;
}
