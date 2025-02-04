#version 330 core

layout(location=0) in vec3 in_Position;
layout(location=1) in vec3 objectColor;
layout(location=2) in vec3 in_Normal;

out vec4 FragColor;
out vec3 FragPos;
out vec3 Normal;
out vec3 inLightPos;
out vec3 inViewPos;
out vec3 ex_Color;
out vec4 lightSpacePosition;

out vec4 gl_Position;


uniform mat4 viewShader;
uniform mat4 projectionShader;
uniform int nrVertices;
uniform vec3 objectColor; 
uniform vec3 lightPos;
uniform vec3 viewPos;
uniform int codCol;
vec3 viewPos = vec3(3,2,1);
uniform mat4 myMatrix;
uniform mat4 projection;
uniform mat4 view;
uniform mat4 matrUmbra;

void main(void)
{

	mat4 modelView = view * myMatrix;
	gl_Position = projection * modelView * in_Position;

	Normal = mat3(modelView) * in_Normal;

	FragPos = vec3(modelView * in_Position);

	inLightPos = vec3(view * vec4(lightPos, 1.0));
	inViewPos = vec3(view * vec4(viewPos, 1.0));

	ex_Color = objectColor;

}