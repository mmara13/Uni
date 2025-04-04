//
// ================================================
// | Grafica pe calculator                        |
// ================================================
// | Laboratorul X - 10_01_Shader.vert |
// =====================================
// 
//  Shaderul de varfuri / Vertex shader - afecteaza geometria scenei; 
 
 #version 330 core


layout(location=0) in vec3 in_Position;
layout(location=1) in vec3 in_Normal;

//  Variabile de iesire;
out vec3 FragPos;
out vec3 Normal;
out vec3 inLightPos;
out vec3 inViewPos;
out vec4 ex_Color;
out vec4 FragColor;

//  Variabile uniforme;
uniform int nrVertices;
uniform mat4 myMatrix;
uniform mat4 view;
uniform mat4 projection;

uniform vec3 objectColor; //pentru culori diferite maimuta/om zapada
vec3 viewPos = vec3(3, 2, 1);



void main(void)
  {
    gl_Position = projection*view*myMatrix*vec4(in_Position, 1.0);
    FragColor = vec4(objectColor, 1.0);
    FragPos = vec3(gl_Position);
    Normal=vec3(projection*view*vec4(in_Normal,0.0));
    inLightPos= vec3(projection*view*myMatrix* vec4(2.0f, 4.0f, 0.0f, 1.0f));
    inViewPos=vec3(projection*view*vec4(viewPos, 1.0f));
	// ex_Color=vec4(1.2 * gl_VertexID/nrVertices, 0.95 * gl_VertexID/nrVertices, 1.5 * gl_VertexID/nrVertices, 1.0);
	 ex_Color=vec4(objectColor, 1.0);
   } 
 