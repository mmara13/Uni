#include <GL/glew.h>
#include <GL/freeglut.h>
#include <stdio.h>
#include "loadShaders.h"
#include "glm/glm.hpp"
#include "glm/gtc/matrix_transform.hpp"
#include "glm/gtx/transform.hpp"
#include "glm/gtc/type_ptr.hpp"
#include "SOIL.h"
#include <random>
#include <iostream>
#include <ctime>
using namespace std;


GLuint VaoId, VboId, ProgramId, myMatrixLocation, texture;
glm::mat4 myMatrix, resizeMatrix, backgroundMatrix;

float xMin = -160.0f, xMax = 160.0f, yMin = -100.0f, yMax = 100.0f;

float rectangle1X = -1.0f;  // X pos of the first rectangle
float rectangle2X = -1.6f;   //  X pos of the second rectangle
float rectangle2Y = -0.13f;

float rectangle4X = 1.5f;    //partea dr a ecranului
float rectangle4Y = 0.15f;  //inaaltime diferita de 1 si 2
//float rectangle5X = 0.0f;    //partea stg a ecranului


float generatePosition(void) {
    
    static bool seeded = false;
    if (!seeded) {
        srand(static_cast<unsigned int>(time(0)));  //crt time
        seeded = true;
    }

    int randomPos = rand() % 5;  //intre 0 si 4
    float position;

    switch (randomPos) {
    case 0:
        position = -1.0f;
        break;
    case 1:
        position = -0.5f;
        break;                         
    case 2:
        position = 0.0f;
        break;
    case 3:
        position = 0.5f;
        break;
    case 4:
        position = 1.0f;
        break;
    default:
        position = -0.5f;
        break;
    }
    cout << "Position: " << position << endl;
    return position;
}
float rectangle5X = generatePosition();



float rectangle5Y = 0.15f; //masina crem

float speed = 0.045f;  // Speed of movement for 1
float speed2 = 0.056f;  // Speed of movement for 1
float speed4 = 0.035f; //viteza pt masina de pe sens opus
float speed5 = 0.15f;  //masina crem 
float angle = 0;					//	Unghiul de rotire al patratului;
float tx = 0; float ty = 0; float auxtx; float auxangle;
float rotation = 0.0f;
float rotation_new = 0.0f;
float rotation_new2 = 0.0f;


void LoadTexture(const char* photoPath)
{
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);
    //	Desfasurarea imaginii pe orizonatala/verticala in functie de parametrii de texturare;
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

    int width, height;
    unsigned char* image = SOIL_load_image(photoPath, &width, &height, 0, SOIL_LOAD_RGBA);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, image);
    glGenerateMipmap(GL_TEXTURE_2D);

    SOIL_free_image_data(image);
    glBindTexture(GL_TEXTURE_2D, 0);
}

void UpdatePositions() {
    rectangle1X += speed;
    rectangle2X += speed2;
    rectangle4X -= speed4;
    rectangle5X -= speed5;

    if (rectangle2X > -0.8f && rectangle2X < -0.5f) {
        rectangle2X += speed2;
        rectangle2Y += 0.077f;
        rotation = 9.0f;
    }


    if (rectangle2X > -0.5f && rectangle2X < 0.1f) {
        rectangle2X += speed2;
        rotation = 0.0f;
    }

    if (rectangle2X > 0.1f && rectangle2X < 0.3f) {
        rectangle2X += speed2;
        rectangle2Y -= 0.008f; 
        rotation = -10.0f;
    }

    if (rectangle2X > 0.3f) {
        rectangle2X += 0.008f;
        rectangle2Y = -0.13f;
        rotation = 0.0f;
    }

}



void CreateShaders() {
    ProgramId = LoadShaders("03_05_Shader.vert", "03_05_Shader.frag");
    glUseProgram(ProgramId);
}

void CreateVBO(void)
{
    // Coordonatele varfurilor;
    static const GLfloat Vertices[] =
    {
        //	Cele 4 varfuri din colturi; 
        xMin, yMin, 0.0f, 1.0f,    	0.0f, 0.8f, 0.0f,  	0.0f, 0.0f,
        xMax, yMin, 0.0f, 1.0f,	    0.0f, 0.8f, 0.0f,	1.0f, 0.0f,
        xMax, yMax, 0.0f, 1.0f,	    0.0f, 0.4f, 0.0f,	1.0f, 1.0f,
        xMin, yMax, 0.0f, 1.0f,	    0.0f, 0.4f, 0.0f,	0.0f, 1.0f,

        //masina albastra
        -10.0f, -7.0f,  0.0f,  1.0f,	0.0f, 1.0f, 0.0f,	0.0f, 0.0f,
        20.0f, -7.0f,  0.0f,  1.0f,		1.0f, 0.0f, 0.0f,	1.0f, 0.0f,
        20.0f,  7.0f,  0.0f,  1.0f,		1.0f, 0.0f, 0.0f,	1.0f, 1.0f,
        -10.0f, 7.0f,  0.0f,  1.0f,		1.0f, 0.0f, 0.0f,	0.0f, 1.0f,

        //masina rosie
        -10.0f, -7.0f,  0.0f,  1.0f,	0.0f, 1.0f, 0.0f,	0.0f, 0.0f,
        20.0f, -7.0f,  0.0f,  1.0f,		1.0f, 0.0f, 0.0f,	1.0f, 0.0f,
        20.0f,  7.0f,  0.0f,  1.0f,		1.0f, 0.0f, 0.0f,	1.0f, 1.0f,
        -10.0f, 7.0f,  0.0f,  1.0f,		1.0f, 0.0f, 0.0f,	0.0f, 1.0f,


        // linia din mijloc-stanga a strazii
        xMin, 2.5f, 0.0f, 1.0f,	        1.0f, 1.0f, 1.0f,	0.0f, 0.0f,
        xMax, 2.5f, 0.0f, 1.0f,	        1.0f, 1.0f, 1.0f,	0.0f, 0.0f,

        // linia din mijloc-dreapta a strazii
        xMin, 0.5f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,
        xMax,  0.5f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,

        // linia din dreapta a strazii
        xMin, -27.0f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,
        xMax,  -27.0f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,

        // linia din stanga a strazii
        xMin, 30.0f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,
        xMax,  30.0f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,

        // sageti
        -10.0f, 16.25f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,
        10.0f,  16.25f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,

         -10.0f, -13.25f, 0.0f, 1.0f,	1.0f, 1.0f, 1.0f,	0.0f, 0.0f,
         10.0f,  -13.25f, 0.0f, 1.0f,    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,

         10.0f, -13.25f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,
         6.0f, -9.25f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,

         10.0f, -13.25f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,
         6.0f, -17.25f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,

         -10.0f, 16.25f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,
         -6.0f, 12.25f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,

         -10.0f, 16.25f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,
         -6.0f, 20.25f, 0.0f, 1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,



        //masina de pe sens opus - albastra
        -10.0f, -7.0f,  0.0f,  1.0f,	0.0f, 1.0f, 0.0f,	0.0f, 0.0f,
        20.0f, -7.0f,  0.0f,  1.0f,		1.0f, 0.0f, 0.0f,	1.0f, 0.0f,
        20.0f,  7.0f,  0.0f,  1.0f,		1.0f, 0.0f, 0.0f,	1.0f, 1.0f,
        -10.0f, 7.0f,  0.0f,  1.0f,		1.0f, 0.0f, 0.0f,	0.0f, 1.0f,

        //masina de pe sens opus - crem
        -15.0f, -12.0f,  0.0f,  1.0f,	0.0f, 1.0f, 0.0f,	0.0f, 0.0f,
        25.0f, -12.0f,  0.0f,  1.0f,		1.0f, 0.0f, 0.0f,	1.0f, 0.0f,
        25.0f,  12.0f,  0.0f,  1.0f,		1.0f, 0.0f, 0.0f,	1.0f, 1.0f,
        -15.0f, 12.0f,  0.0f,  1.0f,		1.0f, 0.0f, 0.0f,	0.0f, 1.0f,

        //dimensiunile paralelogramelor pentru copaci
        60.0f , -35.0f,  0.0f,  1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,
        45.0f, -35.0f,  0.0f,  1.0f,		1.0f, 1.0f, 1.0f,	1.0f, 0.0f,
        45.0f, -50.0f,  0.0f,  1.0f,		1.0f, 1.0f, 1.0f,	1.0f, 1.0f,
        60.0f, -50.0f,  0.0f,  1.0f,		1.0f, 1.0f, 1.0f,	0.0f, 1.0f,

        60.0f , -35.0f,  0.0f,  1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,
        82.0f, -35.0f,  0.0f,  1.0f,		1.0f, 1.0f, 1.0f,	1.0f, 0.0f,
        82.0f,  -50.0f,  0.0f,  1.0f,	    1.0f, 1.0f, 1.0f,	1.0f, 1.0f,
        60.0f, -50.0f,  0.0f,  1.0f,		1.0f, 1.0f, 1.0f,	0.0f, 1.0f,

        82.0f, -35.0f,  0.0f,  1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,
        97.0f, -35.0f,  0.0f,  1.0f,		1.0f, 1.0f, 1.0f,	1.0f, 0.0f,
        97.0f, -50.0f, 0.0f, 1.0f,          1.0f, 1.0f, 1.0f,   1.0f, 1.0f,
        82.0f, -50.0f, 0.0f, 1.0f,          1.0f, 1.0f, 1.0f,   0.0f, 1.0f,

        -20.0f, -35.0f,  0.0f,  1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,
        -35.0f, -35.0f,  0.0f,  1.0f,		1.0f, 1.0f, 1.0f,	1.0f, 0.0f,
        -35.0f, -50.0f, 0.0f, 1.0f,          1.0f, 1.0f, 1.0f, 1.0f, 1.0f,
        -20.0f, -50.0f, 0.0f, 1.0f,          1.0f, 1.0f, 1.0f, 0.0f, 1.0f,

        -52.0f, -35.0f,  0.0f,  1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 0.0f,
        -37.0f, -35.0f,  0.0f,  1.0f,		1.0f, 1.0f, 1.0f,	1.0f, 0.0f,
        -37.0f, -50.0f,  0.0f,  1.0f,		1.0f, 1.0f, 1.0f,	1.0f, 1.0f,
        -52.0f, -50.0f,  0.0f,  1.0f,	    1.0f, 1.0f, 1.0f,	0.0f, 1.0f,


        -118.0f, -35.0f, 0.0f, 1.0f,        1.0f, 1.0f, 1.0f,   0.0f, 0.0f,
        -97.0f, -35.0f, 0.0f, 1.0f,         1.0f, 1.0f, 1.0f,   1.0f, 0.0f,
        -97.0f, -50.0f, 0.0f, 1.0f,         1.0f, 1.0f, 1.0f,   1.0f, 1.0f,
        -118.0f, -50.0f, 0.0f, 1.0f,        1.0f, 1.0f, 1.0f,   0.0f, 1.0f,

        -132.0f, -35.0f, 0.0f, 1.0f,        1.0f, 1.0f, 1.0f,   0.0f, 0.0f,
        -120.0f, -35.0f, 0.0f, 1.0f,        1.0f, 1.0f, 1.0f,   1.0f, 0.0f,
        -120.0f, -50.0f, 0.0f, 1.0f,        1.0f, 1.0f, 1.0f,   1.0f, 1.0f,
        -132.0f, -50.0f, 0.0f, 1.0f,        1.0f, 1.0f, 1.0f,   0.0f, 1.0f,
    };



    // Transmiterea datelor prin buffere;

    glGenVertexArrays(1, &VaoId);
    glBindVertexArray(VaoId);

    glGenBuffers(1, &VboId);                                                        //  Generarea bufferului si indexarea acestuia catre variabila VboId;
    glBindBuffer(GL_ARRAY_BUFFER, VboId);                                           //  Setarea tipului de buffer - atributele varfurilor;
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);

    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 9 * sizeof(GLfloat), (GLvoid*)0);
    //  Se asociaza atributul (1 =  culoare) pentru shader;
    glEnableVertexAttribArray(1);
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 9 * sizeof(GLfloat), (GLvoid*)(4 * sizeof(GLfloat)));
    //  Se asociaza atributul (2 =  texturare) pentru shader;
    glEnableVertexAttribArray(2);
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 9 * sizeof(GLfloat), (GLvoid*)(7 * sizeof(GLfloat)));


}



void DestroyShaders(void)
{
    glDeleteProgram(ProgramId);
}

void DestroyVBO(void)
{
    glDisableVertexAttribArray(1);
    glDisableVertexAttribArray(0);

    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glDeleteBuffers(1, &VboId);

    glBindVertexArray(0);
    glDeleteVertexArrays(1, &VaoId);
}

void Cleanup() {
    DestroyShaders();
    DestroyVBO();
}

void Initialize() {
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);		//  Culoarea de fond a ecranului;
    CreateVBO();								//  Trecerea datelor de randare spre bufferul folosit de shadere;
    CreateShaders();							//  Initilizarea shaderelor;
    //	Instantierea variabilelor uniforme pentru a "comunica" cu shaderele;
    myMatrixLocation = glGetUniformLocation(ProgramId, "myMatrix");
    glUniform1i(glGetUniformLocation(ProgramId, "ok"), 0);

    //	Dreptunghiul "decupat"; 
    resizeMatrix = glm::ortho(xMin, xMax, yMin, yMax);
    backgroundMatrix = glm::ortho(xMin, xMax, yMin, yMax); // Matrice pentru fundal și linia albă

    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
}

void RenderBackground() {
    myMatrix = backgroundMatrix;
    glUniform1i(glGetUniformLocation(ProgramId, "ok"), 0);

    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, glm::value_ptr(myMatrix));
    glPointSize(10.0);
    

    LoadTexture("beach_road.png");
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture);
    //Transmiterea variabilelor uniforme pentru MATRICEA DE TRANSFORMARE, PERSPECTIVA si PROIECTIE spre shadere;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &myMatrix[0][0]);
    //Transmiterea variabilei uniforme pentru TEXTURARE spre shaderul de fragmente;
    glUniform1i(glGetUniformLocation(ProgramId, "myTexture"), 0);
    glUniform1i(glGetUniformLocation(ProgramId, "ok"), 1);
    glDrawArrays(GL_POLYGON, 0, 4);

   
    glPushAttrib(GL_ENABLE_BIT);
    glLineWidth(2.0);
    glLineStipple(20, 0xAAAA);
    glEnable(GL_LINE_STIPPLE);
    glDrawArrays(GL_LINES, 12, 2);
    glLineWidth(2.0);
    glDrawArrays(GL_LINES, 14, 2);
    glPopAttrib();
    glLineWidth(2.0);
    glDrawArrays(GL_LINES, 16, 2);
    glLineWidth(2.0);
    glDrawArrays(GL_LINES, 18, 2);


    glLineWidth(3.0);
    glDrawArrays(GL_LINES, 20, 2);
    glLineWidth(3.0);
    glDrawArrays(GL_LINES, 22, 2);
    glLineWidth(3.0);
    glDrawArrays(GL_LINES, 24, 2);
    glLineWidth(3.0);
    glDrawArrays(GL_LINES, 26, 2);
    glLineWidth(3.0);
    glDrawArrays(GL_LINES, 28, 2);

    glLineWidth(3.0);
    glDrawArrays(GL_LINES, 30, 2);


    glDisable(GL_POINT_SMOOTH);

}

void RenderFunction() {

    glClear(GL_COLOR_BUFFER_BIT);			//se curata ecranul OpenGL pentru a fi desenat noul continut;


    RenderBackground();  //Deseneaza fundalul

    UpdatePositions();


    //copaci
    LoadTexture("palm_tree.png");
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture);
    //	Transmiterea variabilelor uniforme pentru MATRICEA DE TRANSFORMARE, PERSPECTIVA si PROIECTIE spre shadere;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &myMatrix[0][0]);
    //	Transmiterea variabilei uniforme pentru TEXTURARE spre shaderul de fragmente;
    glUniform1i(glGetUniformLocation(ProgramId, "myTexture"), 0);
    glUniform1i(glGetUniformLocation(ProgramId, "ok"), 1);
    glDrawArrays(GL_POLYGON, 40, 4);

    LoadTexture("palm_tree.png");
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture);
    //	Transmiterea variabilelor uniforme pentru MATRICEA DE TRANSFORMARE, PERSPECTIVA si PROIECTIE spre shadere;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &myMatrix[0][0]);
    //	Transmiterea variabilei uniforme pentru TEXTURARE spre shaderul de fragmente;
    glUniform1i(glGetUniformLocation(ProgramId, "myTexture"), 0);
    glUniform1i(glGetUniformLocation(ProgramId, "ok"), 1);
    glDrawArrays(GL_POLYGON, 44, 4);

    LoadTexture("palm_tree.png");
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture);
    //	Transmiterea variabilelor uniforme pentru MATRICEA DE TRANSFORMARE, PERSPECTIVA si PROIECTIE spre shadere;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &myMatrix[0][0]);
    //	Transmiterea variabilei uniforme pentru TEXTURARE spre shaderul de fragmente;
    glUniform1i(glGetUniformLocation(ProgramId, "myTexture"), 0);
    glUniform1i(glGetUniformLocation(ProgramId, "ok"), 1);
    glDrawArrays(GL_POLYGON, 48, 4);

    LoadTexture("palm_tree.png");
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture);
    //	Transmiterea variabilelor uniforme pentru MATRICEA DE TRANSFORMARE, PERSPECTIVA si PROIECTIE spre shadere;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &myMatrix[0][0]);
    //	Transmiterea variabilei uniforme pentru TEXTURARE spre shaderul de fragmente;
    glUniform1i(glGetUniformLocation(ProgramId, "myTexture"), 0);
    glUniform1i(glGetUniformLocation(ProgramId, "ok"), 1);
    glDrawArrays(GL_POLYGON, 52, 4);

    LoadTexture("palm_tree.png");
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture);
    //	Transmiterea variabilelor uniforme pentru MATRICEA DE TRANSFORMARE, PERSPECTIVA si PROIECTIE spre shadere;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &myMatrix[0][0]);
    //	Transmiterea variabilei uniforme pentru TEXTURARE spre shaderul de fragmente;
    glUniform1i(glGetUniformLocation(ProgramId, "myTexture"), 0);
    glUniform1i(glGetUniformLocation(ProgramId, "ok"), 1);
    glDrawArrays(GL_POLYGON, 56, 4);

    LoadTexture("palm_tree.png");
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture);
    //	Transmiterea variabilelor uniforme pentru MATRICEA DE TRANSFORMARE, PERSPECTIVA si PROIECTIE spre shadere;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &myMatrix[0][0]);
    //	Transmiterea variabilei uniforme pentru TEXTURARE spre shaderul de fragmente;
    glUniform1i(glGetUniformLocation(ProgramId, "myTexture"), 0);
    glUniform1i(glGetUniformLocation(ProgramId, "ok"), 1);
    glDrawArrays(GL_POLYGON, 60, 4);

    LoadTexture("palm_tree.png");
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture);
    //	Transmiterea variabilelor uniforme pentru MATRICEA DE TRANSFORMARE, PERSPECTIVA si PROIECTIE spre shadere;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &myMatrix[0][0]);
    //	Transmiterea variabilei uniforme pentru TEXTURARE spre shaderul de fragmente;
    glUniform1i(glGetUniformLocation(ProgramId, "myTexture"), 0);
    glUniform1i(glGetUniformLocation(ProgramId, "ok"), 1);
    glDrawArrays(GL_POLYGON, 64, 4);

    myMatrix = resizeMatrix;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, glm::value_ptr(myMatrix));
    myMatrix = glm::translate(glm::mat4(1.0f), glm::vec3(rectangle1X, -0.13f, 0.0f)) * resizeMatrix;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, glm::value_ptr(myMatrix));
    LoadTexture("decapotabila.png");
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture);
    //Transmiterea variabilelor uniforme pentru MATRICEA DE TRANSFORMARE, PERSPECTIVA si PROIECTIE spre shadere;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &myMatrix[0][0]);
    //Transmiterea variabilei uniforme pentru TEXTURARE spre shaderul de fragmente;
    glUniform1i(glGetUniformLocation(ProgramId, "myTexture"), 0);
    glUniform1i(glGetUniformLocation(ProgramId, "ok"), 1);
    glDrawArrays(GL_POLYGON, 4, 4);



    myMatrix = resizeMatrix;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, glm::value_ptr(myMatrix));
    myMatrix = glm::translate(glm::mat4(1.0f), glm::vec3(rectangle2X, rectangle2Y, 0.0f)) * resizeMatrix;
    myMatrix = glm::rotate(myMatrix, glm::radians(rotation), glm::vec3(0.0f, 0.0f, 1.0f));
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, glm::value_ptr(myMatrix));
    LoadTexture("red_car.png");
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture);
    //	Transmiterea variabilelor uniforme pentru MATRICEA DE TRANSFORMARE, PERSPECTIVA si PROIECTIE spre shadere;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &myMatrix[0][0]);
    //	Transmiterea variabilei uniforme pentru TEXTURARE spre shaderul de fragmente;
    glUniform1i(glGetUniformLocation(ProgramId, "myTexture"), 0);
    glUniform1i(glGetUniformLocation(ProgramId, "ok"), 1);
    glDrawArrays(GL_POLYGON, 8, 4);


    
    //masina albastra sens opus
    myMatrix = resizeMatrix;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, glm::value_ptr(myMatrix));
    myMatrix = glm::translate(glm::mat4(1.0f), glm::vec3(rectangle4X, rectangle4Y, 0.0f)) * resizeMatrix;
    myMatrix = glm::rotate(myMatrix, glm::radians(rotation_new), glm::vec3(0.0f, 0.0f, 1.0f));
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, glm::value_ptr(myMatrix));
    LoadTexture("blue_car.png");
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture);

    // Transmiterea variabilelor uniforme pentru MATRICEA DE TRANSFORMARE, PERSPECTIVA si PROIECTIE spre shadere
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &myMatrix[0][0]);

    // Transmiterea variabilei uniforme pentru TEXTURARE spre shaderul de fragmente
    glUniform1i(glGetUniformLocation(ProgramId, "myTexture"), 0);
    glUniform1i(glGetUniformLocation(ProgramId, "ok"), 1);

    glDrawArrays(GL_POLYGON, 32, 4);


    //masina crem sens opus
    myMatrix = resizeMatrix;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, glm::value_ptr(myMatrix));
    myMatrix = glm::translate(glm::mat4(1.0f), glm::vec3(rectangle5X, rectangle5Y, 0.0f)) * resizeMatrix;
    myMatrix = glm::rotate(myMatrix, glm::radians(rotation_new2), glm::vec3(0.0f, 0.0f, 1.0f));
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, glm::value_ptr(myMatrix));
    LoadTexture("masina-crem.png");
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture);

    // Transmiterea variabilelor uniforme pentru MATRICEA DE TRANSFORMARE, PERSPECTIVA si PROIECTIE spre shadere
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &myMatrix[0][0]);

    // Transmiterea variabilei uniforme pentru TEXTURARE spre shaderul de fragmente
    glUniform1i(glGetUniformLocation(ProgramId, "myTexture"), 0);
    glUniform1i(glGetUniformLocation(ProgramId, "ok"), 1);

    glDrawArrays(GL_POLYGON, 36, 4);


    glutSwapBuffers();	//Inlocuieste imaginea deseneata in fereastra cu cea randata; 
    glFlush();
}

void Timer(int value) {
    glutPostRedisplay();
    glutTimerFunc(10, Timer, 0);
}

int main(int argc, char* argv[]) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
    glutInitWindowSize(800, 600);
    glutInitWindowPosition(100, 100);
    glutCreateWindow("Depasire");

    glewInit();

    Initialize();
    glutDisplayFunc(RenderFunction);
    glutCloseFunc(Cleanup);
    glutTimerFunc(0, Timer, 0);
    glutMainLoop();

    return 0;
}