//
// ================================================
// | Grafica pe calculator                        |
// ================================================
// | Laboratorul IV - 04_02_indexare.cpp |
// ======================================
// 
//	Program ce deseneaza un patrat, folosindu-se tehnicile MODERN OpenGL;
//	ELEMENTE DE NOUTATE:
//	 - folosirea indexarii varfurilor: elemente asociate (matrice, buffer);
//	 - desenarea se face folosind functia glDrawElements();
//
//
// 
//	Biblioteci

#include <windows.h>        //	Utilizarea functiilor de sistem Windows (crearea de ferestre, manipularea fisierelor si directoarelor);
#include <stdlib.h>         //  Biblioteci necesare pentru citirea shaderelor;
#include <stdio.h>
#include <GL/glew.h>        //  Definește prototipurile functiilor OpenGL si constantele necesare pentru programarea OpenGL moderna; 
#include <GL/freeglut.h>    //	Include functii pentru: 
							//	- gestionarea ferestrelor si evenimentelor de tastatura si mouse, 
							//  - desenarea de primitive grafice precum dreptunghiuri, cercuri sau linii, 
							//  - crearea de meniuri si submeniuri;
#include "loadShaders.h"	//	Fisierul care face legatura intre program si shadere;
#include "glm/glm.hpp"		//	Bibloteci utilizate pentru transformari grafice;
#include "glm/gtc/matrix_transform.hpp"
#include "glm/gtx/transform.hpp"
#include "glm/gtc/type_ptr.hpp"

//  Identificatorii obiectelor de tip OpenGL;
GLuint
VaoId,
VboId,
EboId,
ProgramId,
myMatrixLocation;
//	Dimensiunile ferestrei de afisare;
GLfloat
winWidth = 800, winHeight = 600;
//	Variabile catre matricile de transformare;
glm::mat4
myMatrix, resizeMatrix;
//	Variabile pentru proiectia ortogonala;
float xMin = -80, xMax = 80.f, yMin = -60.f, yMax = 60.f;

//  Crearea si compilarea obiectelor de tip shader;
//	Trebuie sa fie in acelasi director cu proiectul actual;
//  Shaderul de varfuri / Vertex shader - afecteaza geometria scenei;
//  Shaderul de fragment / Fragment shader - afecteaza culoarea pixelilor;
void CreateShaders(void)
{
	ProgramId = LoadShaders("04_02_Shader.vert", "04_02_Shader.frag");
	glUseProgram(ProgramId);
}
//  Functia de desenarea a graficii pe ecran;
void RenderFunction(void)
{
	glClear(GL_COLOR_BUFFER_BIT);			//  Se curata ecranul OpenGL pentru a fi desenat noul continut;

	//	Transmiterea variabilei uniforme pentru MATRICEA DE TRANSFORMARE spre shadere;
	myMatrix = resizeMatrix;
	glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &myMatrix[0][0]);
	glLineWidth(2.5f); //am setat grosime pentru ca erau un pic prea subtiri liniile
	glDrawElements(GL_LINES, 42, GL_UNSIGNED_INT, (void*)(0));
	glFlush();								//  Asigura rularea tuturor comenzilor OpenGL apelate anterior;
}
//  Se initializeaza un Vertex Buffer Object (VBO) pentru tranferul datelor spre memoria placii grafice (spre shadere);
//  In acesta se stocheaza date despre varfuri (coordonate, culori, indici, texturare etc.);
void CreateVBO(void)
{
	//  Coordonatele varfurilor;
	static const GLfloat Vertices[] =
	{
		-45.0f, 0.0f, 0.0f, 1.0f, //extrema stanga sus
		-45.0f, -15.0f, 0.0f, 1.0f, //extrema stanga jos
		-30.0f, 0.0f, 0.0f, 1.0f, //urm punct sus
		-30.0f, -15.0f, 0.0f, 1.0f, //urm punct jos
		-15.0f, 0.0f, 0.0f, 1.0f, //a treia linie sus
		-15.0f, -15.0f, 0.0f, 1.0f, //a treia linie jos
		0.0f, 0.0f, 0.0f, 1.0f, //a patra linie sus
		0.0f, -15.0f, 0.0f, 1.0f, //a patra linie jos
		15.0f, 0.0f, 0.0f, 1.0f, //a 5 a linie sus
		15.0f, -15.0f, 0.0f, 1.0f, //a 5 a linie jos
		30.0f, 0.0f, 0.0f, 1.0f, //extrema dreapta sus
		30.0f, -15.0f, 0.0f, 1.0f, //extrema dreapta js

	};
	//	Indicii care determina ordinea de parcurgere a varfurilor;
	static const GLuint Indices[] =
	{
		0, 1, 0, 2, 1, 2, 2, 3, 1, 3, //primul patrat
		2, 4, 3, 4, 4, 5, 3, 5, //al doilea patrat (are mai putine vf ptc are o latura comuna
		//cu patratul anterior, si asa va fi si pt restul
		4, 6, 5, 6, 5, 7, 6, 7, //al treilea patrat
		6, 8, 7, 8, 8, 9, 7, 9, //al 4 lea patrat
		8, 10, 9, 10, 9, 11, 10, 11 // ultimul patrat
	};
	//	Culorile ca atribute ale varfurilor;
	static const GLfloat Colors[] =
	{
		1.0f, 0.0f, 0.0f, 1.0f,
		0.0f, 1.0f, 0.0f, 1.0f,
		0.0f, 0.0f, 1.0f, 1.0f,
		1.0f, 0.0f, 1.0f, 1.0f,
		1.0f, 0.0f, 0.0f, 1.0f,
		0.0f, 1.0f, 0.0f, 1.0f,
		0.0f, 0.0f, 1.0f, 1.0f,
		1.0f, 0.0f, 1.0f, 1.0f,
		1.0f, 0.0f, 0.0f, 1.0f,
		0.0f, 1.0f, 0.0f, 1.0f,
		0.0f, 0.0f, 1.0f, 1.0f,
		1.0f, 0.0f, 1.0f, 1.0f,
	};


	//  Transmiterea datelor prin buffere;

	//  Se creeaza / se leaga un VAO (Vertex Array Object) - util cand se utilizeaza mai multe VBO;
	glGenVertexArrays(1, &VaoId);                                                   //  Generarea VAO si indexarea acestuia catre variabila VaoId;
	glBindVertexArray(VaoId);

	//  Se creeaza un buffer comun pentru VARFURI - COORDONATE si CULORI;
	glGenBuffers(1, &VboId);																//  Generarea bufferului si indexarea acestuia catre variabila VboId;
	glBindBuffer(GL_ARRAY_BUFFER, VboId);													//  Setarea tipului de buffer - atributele varfurilor;
	glBufferData(GL_ARRAY_BUFFER, sizeof(Colors) + sizeof(Vertices), NULL, GL_STATIC_DRAW);	//	Definirea bufferului, dimensiunea lui = dimensiunea(COLORS + VERTICES)
	//	Spatiul bufferului este impartit intre zona de COORDONATE si cea de VARFURI:
	//	 - prima sectiune incepe de la 0, are dimensiunea VERTICES si continele datele despre COORDONATE;
	//	 - a doua sectiune incepe de la sizeof(Vertices) - deci la finalul primei sectiuni, are dimensiunea COLORS si contine datele despre CULOARE;
	glBufferSubData(GL_ARRAY_BUFFER, 0, sizeof(Vertices), Vertices);				//	COORDONATELE;
	glBufferSubData(GL_ARRAY_BUFFER, sizeof(Vertices), sizeof(Colors), Colors);		//	CULORILE;

	//	Se creeaza un buffer pentru INDICI;
	glGenBuffers(1, &EboId);														//  Generarea bufferului si indexarea acestuia catre variabila EboId;
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EboId);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);

	//	Se activeaza lucrul cu atribute;
	//  Se asociaza atributul (0 = coordonate) pentru shader;
	glEnableVertexAttribArray(0);
	glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, NULL);
	//  Se asociaza atributul (1 =  culoare) pentru shader;
	glEnableVertexAttribArray(1);
	glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, (const GLvoid*)sizeof(Vertices));
}

//  Elimina obiectele de tip shader dupa rulare;
void DestroyShaders(void)
{
	glDeleteProgram(ProgramId);
}

//  Eliminarea obiectelor de tip VBO dupa rulare;
void DestroyVBO(void)
{
	//  Eliberarea atributelor din shadere (pozitie, culoare, texturare etc.);
	glDisableVertexAttribArray(1);
	glDisableVertexAttribArray(0);

	//  Stergerea bufferelor pentru VARFURI(Coordonate + Culori), INDICI;
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	glDeleteBuffers(1, &VboId);
	glDeleteBuffers(1, &EboId);

	//  Eliberaea obiectelor de tip VAO;
	glBindVertexArray(0);
	glDeleteVertexArrays(1, &VaoId);
}

//  Functia de eliberare a resurselor alocate de program;
void Cleanup(void)
{
	DestroyShaders();
	DestroyVBO();
}

//  Setarea parametrilor necesari pentru fereastra de vizualizare;
void Initialize(void)
{
	glClearColor(1.0f, 1.0f, 1.0f, 1.0f);		//  Culoarea de fond a ecranului;
	CreateVBO();								//  Trecerea datelor de randare spre bufferul folosit de shadere;
	CreateShaders();							//  Initilizarea shaderelor;
	//	Instantierea variabilelor uniforme pentru a "comunica" cu shaderele;
	myMatrixLocation = glGetUniformLocation(ProgramId, "myMatrix");
	//	Dreptunghiul "decupat"; 
	resizeMatrix = glm::ortho(xMin, xMax, yMin, yMax);
}

//	Punctul de intrare in program, se ruleaza rutina OpenGL;
int main(int argc, char* argv[])
{
	//  Se initializeaza GLUT si contextul OpenGL si se configureaza fereastra si modul de afisare;

	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);					//	Modul de afisare al ferestrei, se foloseste un singur buffer de afisare si culori RGB;
	glutInitWindowSize(winWidth, winHeight);						//  Dimensiunea ferestrei;
	glutInitWindowPosition(100, 100);								//  Pozitia initiala a ferestrei;
	glutCreateWindow("Indexarea varfurilor - OpenGL <<nou>>");		//	Creeaza fereastra de vizualizare, indicand numele acesteia;

	//	Se initializeaza GLEW si se verifica suportul de extensii OpenGL modern disponibile pe sistemul gazda;
	//  Trebuie initializat inainte de desenare;

	glewInit();

	Initialize();						//  Setarea parametrilor necesari pentru fereastra de vizualizare; 
	glutDisplayFunc(RenderFunction);	//  Desenarea scenei in fereastra;
	glutCloseFunc(Cleanup);				//  Eliberarea resurselor alocate de program;

	//  Bucla principala de procesare a evenimentelor GLUT (functiile care incep cu glut: glutInit etc.) este pornita;
	//  Prelucreaza evenimentele si deseneaza fereastra OpenGL pana cand utilizatorul o inchide;

	glutMainLoop();

	return 0;
}


