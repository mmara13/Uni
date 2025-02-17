#version 330 core

layout(location=0) in vec4 in_Position;
layout(location=1) in vec3 in_Color;
layout(location=2) in vec2 in_TexCoord;

out vec3 ex_Color;
out vec2 tex_Coord;

uniform mat4 myMatrix;

void main(void)
{
	gl_Position = myMatrix * in_Position;
	ex_Color = in_Color;
	tex_Coord = in_TexCoord;
}