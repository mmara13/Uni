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
#include<stack>
#include <vector>


//  Identificatorii obiectelor de tip OpenGL;
GLuint
VaoId,
VboId,
EboId,
ProgramId,
viewModelLocation,
projLocation,
codColLocation;

//	Valaorea lui pi;
float PI = 3.141592;

//	Dimensiunile ferestrei de afisare;
GLfloat
winWidth = 1400, winHeight = 600;

//	Variabila ce determina schimbarea culorii pixelilor in shader;
int codCol;

// Variabila pentru timpul scurs
float timeElapsed;

//	Elemente pentru matricea de vizualizare;
float obsX = 0.0, obsY = 0.0, obsZ = 300.f,
refX = 0.0f, refY = 0.0f, refZ = -100.f,
vX = 0.0;
//	Elemente pentru matricea de proiectie;
float xMin = -700.f, xMax = 700.f, yMin = -300.f, yMax = 300.f,
zNear = 100.f, zFar = 500.f;
//width = 1400.f, height = 600.f, fov = 90.f * PI / 180;

////	Vectori pentru matricea de vizualizare;
//glm::vec3
//obs, pctRef, vert;
//
////	Variabile catre matricile de transformare;
//glm::mat4
//view, projection,
//translateSystem,
//rotateSun,
//scalePlanet, rotatePlanetAxis, rotatePlanet, translatePlanet;
//
//// Stiva de matrice - inglobeaza matricea de modelare si cea de vizualizare
//std::stack<glm::mat4> mvStack;
// Matrices
glm::mat4 view, projection;
std::stack<glm::mat4> mvStack;

// Sphere generation parameters
const int SPHERE_SECTORS = 36;
const int SPHERE_STACKS = 18;
std::vector<GLfloat> sphereVertices;
std::vector<GLuint> sphereIndices;



// Procedural sphere generation
void generateSphere(float radius) {
	sphereVertices.clear();
	sphereIndices.clear();

	// Generate vertices
	for (int stack = 0; stack <= SPHERE_STACKS; ++stack) {
		float phi = PI * stack / SPHERE_STACKS;
		float sinPhi = sin(phi);
		float cosPhi = cos(phi);

		for (int sector = 0; sector <= SPHERE_SECTORS; ++sector) {
			float theta = 2.0f * PI * sector / SPHERE_SECTORS;
			float sinTheta = sin(theta);
			float cosTheta = cos(theta);

			// Position
			float x = radius * sinPhi * cosTheta;
			float y = radius * sinPhi * sinTheta;
			float z = radius * cosPhi;

			
			float r = (sinPhi + 1.0f) / 2.0f;
			float g = (cosTheta + 1.0f) / 2.0f;
			float b = (cosPhi + 1.0f) / 2.0f;

			// Add vertex data (position + color)
			sphereVertices.push_back(x);
			sphereVertices.push_back(y);
			sphereVertices.push_back(z);
			sphereVertices.push_back(1.0f);  // w coordinate
			sphereVertices.push_back(r);
			sphereVertices.push_back(g);
			sphereVertices.push_back(b);
		}
	}

	// Generate indices
	for (int stack = 0; stack < SPHERE_STACKS; ++stack) {
		for (int sector = 0; sector < SPHERE_SECTORS; ++sector) {
			int current = stack * (SPHERE_SECTORS + 1) + sector;
			int next = current + SPHERE_SECTORS + 1;

			// Triangle 1
			sphereIndices.push_back(current);
			sphereIndices.push_back(next);
			sphereIndices.push_back(current + 1);

			// Triangle 2
			sphereIndices.push_back(next);
			sphereIndices.push_back(next + 1);
			sphereIndices.push_back(current + 1);
		}
	}
}

void ProcessNormalKeys(unsigned char key, int x, int y)
{
	switch (key)
	{
	case 'l':			//	Apasarea tastelor `l` si `r` modifica pozitia verticalei in planul de vizualizare;
		vX += 0.1;
		break;
	case 'r':
		vX -= 0.1;
		break;
	case '+':			//	Apasarea tastelor `+` si `-` schimba pozitia observatorului (se departeaza / aproprie);
		obsZ += 10;
		break;
	case '-':
		obsZ -= 10;
		break;
	}
	if (key == 27)
		exit(0);
}

void ProcessSpecialKeys(int key, int xx, int yy)
{
	switch (key)				//	Procesarea tastelor 'LEFT', 'RIGHT', 'UP', 'DOWN';
	{							//	duce la deplasarea observatorului pe axele Ox si Oy;
	case GLUT_KEY_LEFT:
		obsX -= 20;
		break;
	case GLUT_KEY_RIGHT:
		obsX += 20;
		break;
	case GLUT_KEY_UP:
		obsY += 20;
		break;
	case GLUT_KEY_DOWN:
		obsY -= 20;
		break;
	}
}

//  Crearea si compilarea obiectelor de tip shader;
void CreateShaders(void)
{
	ProgramId = LoadShaders("08_01_Shader.vert", "08_01_Shader.frag");
	glUseProgram(ProgramId);
}

//  Se initializeaza un vertex Buffer Object (VBO) pentru tranferul datelor spre memoria placii grafice (spre shadere);
//  In acesta se stocheaza date despre varfuri (coordonate, culori, indici, texturare etc.);
void CreateVBO() {
	// Generate sphere
	generateSphere(20.0f);

	// Create and bind VAO
	glGenVertexArrays(1, &VaoId);
	glBindVertexArray(VaoId);

	// Vertex Buffer
	glGenBuffers(1, &VboId);
	glBindBuffer(GL_ARRAY_BUFFER, VboId);
	glBufferData(GL_ARRAY_BUFFER,
		sphereVertices.size() * sizeof(GLfloat),
		sphereVertices.data(),
		GL_STATIC_DRAW);

	// Element Buffer
	glGenBuffers(1, &EboId);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EboId);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER,
		sphereIndices.size() * sizeof(GLuint),
		sphereIndices.data(),
		GL_STATIC_DRAW);

	// Position attribute
	glEnableVertexAttribArray(0);
	glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE,
		7 * sizeof(GLfloat), (GLvoid*)0);

	// Color attribute
	glEnableVertexAttribArray(1);
	glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE,
		7 * sizeof(GLfloat), (GLvoid*)(4 * sizeof(GLfloat)));
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

	//  Stergerea bufferelor pentru VARFURI (Coordonate, Culori), INDICI;
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	glDeleteBuffers(1, &VboId);
	glDeleteBuffers(1, &EboId);

	//  Eliberaea obiectelor de tip VAO;
	glBindVertexArray(0);
	glDeleteVertexArrays(1, &VaoId);
}

//  Functia de eliberare a resurselor alocate de program;
void Cleanup() {
	glDeleteProgram(ProgramId);
	glDeleteBuffers(1, &VboId);
	glDeleteBuffers(1, &EboId);
	glDeleteVertexArrays(1, &VaoId);
}

//  Setarea parametrilor necesari pentru fereastra de vizualizare;
void Initialize() {
	glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
	CreateVBO();
	CreateShaders();

	// Get uniform locations
	viewModelLocation = glGetUniformLocation(ProgramId, "viewModel");
	projLocation = glGetUniformLocation(ProgramId, "projection");
	codColLocation = glGetUniformLocation(ProgramId, "codCol");

	// Projection setup
	projection = glm::ortho(xMin, xMax, yMin, yMax, zNear, zFar);
	glUniformMatrix4fv(projLocation, 1, GL_FALSE, &projection[0][0]);
}

//	Functia de desenare a graficii pe ecran;
void RenderFunction() {
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glEnable(GL_DEPTH_TEST);

	// Time elapsed
	timeElapsed = glutGet(GLUT_ELAPSED_TIME);

	// View matrix setup
	glm::vec3 obs = glm::vec3(obsX, obsY, obsZ);
	glm::vec3 pctRef = glm::vec3(obsX, obsY, refZ);
	glm::vec3 vert = glm::vec3(vX, 1.0f, 0.0f);
	view = glm::lookAt(obs, pctRef, vert);

	// Matrix stack management
	mvStack = std::stack<glm::mat4>(); // Clear stack
	mvStack.push(view);

	// System-wide translation
	glm::mat4 translateSystem = glm::translate(glm::mat4(1.0f),
		glm::vec3(-600 + 0.01f * timeElapsed, 0.0f, 0.0f));
	mvStack.top() *= translateSystem;
	mvStack.push(mvStack.top());

	//soare corp central
	glm::mat4 rotateSun = glm::rotate(glm::mat4(1.0f),
		-(float)0.0001f * timeElapsed, glm::vec3(0.0f, 1.0f, 0.0f));
	mvStack.top() *= rotateSun;
	
	glm::mat4 scaleSun = glm::scale(glm::mat4(1.0f), glm::vec3(1.5f, 1.5f, 1.5f)); //marit marime soare
	mvStack.top() *= scaleSun;


	//render soare
	glUniformMatrix4fv(viewModelLocation, 1, GL_FALSE, glm::value_ptr(mvStack.top()));
	glUniform1i(codColLocation, 0);
	glDrawElements(GL_TRIANGLES, sphereIndices.size(), GL_UNSIGNED_INT, 0);
	mvStack.pop();

	//planeta
	glm::mat4 rotatePlanet = glm::rotate(glm::mat4(1.0f),
		(float)0.0005f * timeElapsed, glm::vec3(-0.1f, 1.0f, 0.0f));
	glm::mat4 translatePlanet = glm::translate(glm::mat4(1.0f),
		glm::vec3(150.0f, 0.0f, 0.0f));
	//scalare mai mare ptc era prea mica
	glm::mat4 scalePlanet = glm::scale(glm::mat4(1.0f),
		glm::vec3(0.8f, 0.8f, 0.8f));
	glm::mat4 rotatePlanetAxis = glm::rotate(glm::mat4(1.0f),
		(float)0.001f * timeElapsed, glm::vec3(0.0f, 1.0f, 0.0f));

	mvStack.top() *= rotatePlanet;
	mvStack.top() *= translatePlanet;
	mvStack.top() *= rotatePlanetAxis;
	mvStack.top() *= scalePlanet;

	//randare planeta
	glUniformMatrix4fv(viewModelLocation, 1, GL_FALSE, glm::value_ptr(mvStack.top()));
	glUniform1i(codColLocation, 1);
	glDrawElements(GL_TRIANGLES, sphereIndices.size(), GL_UNSIGNED_INT, 0);

	//satellite
	glm::mat4 rotateSatellite = glm::rotate(glm::mat4(1.0f),
		(float)0.002f * timeElapsed, glm::vec3(0.0f, 1.0f, 0.0f));
	glm::mat4 translateSatellite = glm::translate(glm::mat4(1.0f),
		glm::vec3(40.0f, 0.0f, 0.0f));
	glm::mat4 scaleSatellite = glm::scale(glm::mat4(1.0f),
		glm::vec3(0.3f, 0.3f, 0.3f));

	mvStack.top() *= rotateSatellite;
	mvStack.top() *= translateSatellite;
	mvStack.top() *= scaleSatellite;

	//render pt satellite
	glUniformMatrix4fv(viewModelLocation, 1, GL_FALSE, glm::value_ptr(mvStack.top()));
	glUniform1i(codColLocation, 2);
	glDrawElements(GL_TRIANGLES, sphereIndices.size(), GL_UNSIGNED_INT, 0);

	glutSwapBuffers();
	glFlush();
}

//	Punctul de intrare in program, se ruleaza rutina OpenGL;
int main(int argc, char* argv[]) {
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGB | GLUT_DEPTH | GLUT_DOUBLE);
	glutInitWindowSize(winWidth, winHeight);
	glutInitWindowPosition(100, 100);
	glutCreateWindow("Mini Solar System");

	glewInit();

	Initialize();
	glutDisplayFunc(RenderFunction);
	glutIdleFunc(RenderFunction);
	glutKeyboardFunc(ProcessNormalKeys);
	glutSpecialFunc(ProcessSpecialKeys);
	glutCloseFunc(Cleanup);

	glutMainLoop();
	return 0;
}
