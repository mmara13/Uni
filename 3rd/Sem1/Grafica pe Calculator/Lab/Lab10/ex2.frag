#version 330 core

in vec3 FragPos;
in vec3 Normal;
in vec3 ex_Color;
in vec3 inLightPos;
in vec3 inViewPos;

uniform int codCol;
uniform vec3 lightColor;

out vec4 out_Color;


void main(void)
{
	if (codCol == 0)
	{
		float ambientStrength = 0.2f;
		vec3 ambient = ambientStrength * lightColor;

		//difuse
		vec3 normala = normalize(Normal);
		vec3 lightDir = normalize(inLightPos - FragPos);
		float diff = max(dot(normala, lightDir), 0.0);
		vec3 diffuse = diff * lightColor;

		//specular
		float specularStrength = 0.5f;
		vec3 viewDir = normalize(inViewPos - FragPos);
		vec3 reflectDir = reflect(-lightDir, normala);
		float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32);
		vec3 specular = specularStrength * spec * lightColor;

		vec3 result = (ambient + diffuse + specular) * ex_Color;
		out_Color = vec4(result, 1.0f);
	}
	else{
		out_Color = vec4(0.0, 0.0, 0.0, 0.5);
	}
}