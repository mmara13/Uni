#version 330 core

in vec3 ex_Color;
in vec2 tex_Coord;
out vec4 out_Color;

uniform sampler2D textureSampler;

void main(void)
{
	if(ex_Color.a > 0.0)
		out_Color = ex_Color;
	else
		out_Color = texture(textureSampler, tex_Coord);
}