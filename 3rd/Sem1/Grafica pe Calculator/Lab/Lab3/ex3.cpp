#include <windows.h>
#include <GL/glew.h>
#include <GL/freeglut.h>
#include "loadShaders.h"
#include "glm/glm.hpp"
#include "glm/gtc/matrix_transform.hpp"
#include "glm/gtx/transform.hpp"
#include "glm/gtc/type_ptr.hpp"

//  Identificatorii obiectelor de tip OpenGL;
GLuint
VaoId,
VboId,
ColorBufferId,
ProgramId,
myMatrixLocation,
matrRotlLocation,
codColLocation;

//	Dimensiunile ferestrei de afisare;
GLfloat
winWidth = 900, winHeight = 600;
//	Variabile catre matricile de transformare;
glm::mat4
myMatrix, resizeMatrix, matrTransl, matrScale, matrTrans, matrRot, matrFinal, matrTransBack;

//dimensiunile dreptunghiului in care incadram
const float a = 300.0f; //width
const float b = 200.0f; //height

void CreateShaders(void)
{
	ProgramId = LoadShaders("shader_1.vert", "shader_1.frag");
	glUseProgram(ProgramId);
}

void CreateVBO(void) {
	//coord vf

	GLfloat Vertices[] = {
		//pentru exercitiul 2
		//definim un dreptunghi de dimensiunea viewportului pt schimbarea culorii in gradient
		0.0f, 0.0f, 0.0f, 1.0f, //stg jos
		a, 0.0f, 0.0f, 1.0f, //dreapta jos
		0.0f, b, 0.0f, 1.0f, //stg sus
		a, b, 0.0f, 1.0f, //dreapta sus

		//poligon convex (un pentagon)
		150.0f, 180.0f, 0.0f, 1.0f,
		250.0f, 100.0f, 0.0f, 1.0f,
		220.0f, 20.0f, 0.0f, 1.0f,
		80.0f, 20.0f, 0.0f, 1.0f,
		50.0f, 100.0f, 0.0f, 1.0f, //5

		//romb - duplicam punctele 2 si 3 pentru triangulare
		150.0f, 165.0f, 0.0f, 1.0f, //1
		200.0f, 110.0f, 0.0f, 1.0f, //2
		95.0f, 110.0f, 0.0f, 1.0f, //3
		200.0f, 110.0f, 0.0f, 1.0f, //2
		95.0f, 110.0f, 0.0f, 1.0f, //3
		150.0f, 35.0f, 0.0f, 1.0f, //4
	};

	//culorile vf
	GLfloat Colors[] = {
		//culori pt gradient background
		0.992f, 0.7f, 0.823f, 1.0f,
		0.62f, 0.827f, 0.914f, 1.0f,
		0.992f, 0.957f, 0.6f, 1.0f,
		0.635f, 0.894f, 0.682f, 1.0f,


		//culori pt pentagon
		0.0f, 0.8f, 0.0f, 1.0f,
		0.0f, 0.8f, 0.0f, 1.0f,
		0.0f, 0.8f, 0.0f, 1.0f,
		0.0f, 0.8f, 0.0f, 1.0f,
		0.0f, 0.8f, 0.0f, 1.0f,

		//pt romb interior 
		1.0f, 0.0f, 0.0f, 1.0f,
		1.0f, 0.0f, 0.0f, 1.0f,
		1.0f, 0.0f, 0.0f, 1.0f,
		1.0f, 0.0f, 0.0f, 1.0f,
		1.0f, 0.0f, 0.0f, 1.0f,
		1.0f, 0.0f, 0.0f, 1.0f,
	};

	//  Transmiterea datelor prin buffere;

	//  Se creeaza / se leaga un VAO (Vertex Array Object) - util cand se utilizeaza mai multe VBO;
	glGenVertexArrays(1, &VaoId);                                                   //  Generarea VAO si indexarea acestuia catre variabila VaoId;
	glBindVertexArray(VaoId);

	//  Se creeaza un buffer pentru VARFURI;
	glGenBuffers(1, &VboId);                                                        //  Generarea bufferului si indexarea acestuia catre variabila VboId;
	glBindBuffer(GL_ARRAY_BUFFER, VboId);                                           //  Setarea tipului de buffer - atributele varfurilor;
	glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);      //  Punctele sunt "copiate" in bufferul curent;
	//  Se asociaza atributul (0 = coordonate) pentru shader;
	glEnableVertexAttribArray(0);
	glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, 0);

	//  Se creeaza un buffer pentru CULOARE;
	glGenBuffers(1, &ColorBufferId);
	glBindBuffer(GL_ARRAY_BUFFER, ColorBufferId);
	glBufferData(GL_ARRAY_BUFFER, sizeof(Colors), Colors, GL_STATIC_DRAW);
	//  Se asociaza atributul (1 =  culoare) pentru shader;
	glEnableVertexAttribArray(1);
	glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, 0);
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

	//  Stergerea bufferelor pentru varfuri, culori;
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	glDeleteBuffers(1, &ColorBufferId);
	glDeleteBuffers(1, &VboId);

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
	codColLocation = glGetUniformLocation(ProgramId, "codCol");
	myMatrixLocation = glGetUniformLocation(ProgramId, "myMatrix");

	// Pentru decupare avem de translatat si de scalat;
	// Este decupat dreptunghiul delimitat de xMin, xMax, yMin, yMax

	// Varianta 1 (recomandat) - Se aplica functia glm::ortho;
	resizeMatrix = glm::ortho(0.0f, a, 0.0f, b);

}
float angle = 50.0f; //unghiul de rotatie pt cerinta 3
void RenderFunction(void)
{
	glClear(GL_COLOR_BUFFER_BIT);			//  Se curata ecranul OpenGL pentru a fi desenat noul continut;
	//	Matrice pentru elemente "fixe" - puncte, axe;
	//	Transmiterea variabilei uniforme pentru MATRICEA DE TRANSFORMARE spre shadere;
	myMatrix = resizeMatrix;

	//resetam matricea pt dreptunghiul care e fundalul
	glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &resizeMatrix[0][0]);

	//desenam background
	glUniform1i(codColLocation, 0);
	glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);


	//Fac varianta A, le voi translata cu centrul intre pentagon si romb
	//si voi inmulti matricele mai jos, adica in programul principal, nu in shader
	//calculam matricea de transf
	glm::vec3 center(150.0f, 100.0f, 0.0f); //centrul pentagonului si rombului
	matrTransl = glm::translate(-center); //transl la origine
	matrRot = glm::rotate(glm::radians(angle), glm::vec3(0.0f, 0.0f, 1.0f)); //rot pe axa z
	matrTransBack = glm::translate(center); //transl inapoi
	glm::mat4 rotationMatrix = matrTransBack * matrRot * matrTransl; //combinam transf

	//combinam matr 
	glm::mat4 finalMatrix = resizeMatrix * rotationMatrix;

	//trimitem transf
	glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &finalMatrix[0][0]);

	//desenare pentagon
	glUniform1i(codColLocation, 0);
	glLineWidth(2.0);
	glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	glDrawArrays(GL_POLYGON, 4, 5);

	//desenare romb cu triangulare
	glUniform1i(codColLocation, 1);
	glLineWidth(2.0);
	glDrawArrays(GL_TRIANGLES, 9, 6);


	glFlush();
}

int main(int argc, char* argv[])
{
	//  Se initializeaza GLUT si contextul OpenGL si se configureaza fereastra si modul de afisare;

	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);					//	Modul de afisare al ferestrei, se foloseste un singur buffer de afisare si culori RGB;
	glutInitWindowSize(winWidth, winHeight);						//  Dimensiunea ferestrei;
	glutInitWindowPosition(100, 100);								//  Pozitia initiala a ferestrei;
	glutCreateWindow("Poligon convex si concav si rotatie");		//	Creeaza fereastra de vizualizare, indicand numele acesteia;

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

