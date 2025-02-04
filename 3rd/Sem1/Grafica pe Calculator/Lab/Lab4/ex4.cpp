//In codul sursa initial (doar cu un patrat) introduceti matrice pentru scalare cu factori (2.0, 0.5) si o translatie de vector (100,100) - atentie si la modificari in shader!
//Desenati in plus in acelasi desen:
//1. cu un amestec de culori ceea ce se obtine aplicand intai scalarea, apoi translatia
//2. texturat ce se obtine aplicand intai translatia, apoi scalarea - pentru texturare folositi functiile relevante din codul 04_04_texturare.cpp

#include <windows.h>
#include <stdlib.h>
#include <stdio.h>
#include <GL/glew.h>
#include <GL/freeglut.h>
#include "loadShaders.h"
#include "glm/glm.hpp"
#include "glm/gtc/matrix_transform.hpp"
#include "glm/gtx/transform.hpp"
#include "glm/gtc/type_ptr.hpp"
#include "SOIL.h"

GLuint VaoId1, VaoId2, VboId1, ColorBufferId, EboId1, VboId2, EboId2, ProgramId, myMatrixLocation, texture;
GLfloat winWidth = 800, winHeight = 600;
glm::mat4 myMatrix, resizeMatrix;
float xMin = -400.0f, xMax = 400.0f, yMin = -300.0f, yMax = 300.0f;

void CreateShaders(void)
{
    ProgramId = LoadShaders("ex4.vert", "ex4.frag");
    if (ProgramId == 0) {
        fprintf(stderr, "Error loading shaders!\n");
        exit(1);
    }
    glUseProgram(ProgramId);
}

void CreateVBO(void)
{
    // First square vertices (with w component)
    GLfloat Vertices1[] = {
        -50.0f, -50.0f, 0.0f, 1.0f,
         50.0f, -50.0f, 0.0f, 1.0f,
         50.0f,  50.0f, 0.0f, 1.0f,
        -50.0f,  50.0f, 0.0f, 1.0f
    };

    GLfloat Colors[] = {
        1.0f, 0.0f, 0.0f, 1.0f,
        0.0f, 1.0f, 0.0f, 1.0f,
        0.0f, 0.0f, 1.0f, 1.0f,
        1.0f, 0.0f, 1.0f, 1.0f
    };

    // Second square vertices (with texture coordinates)
    GLfloat Vertices2[] = {
        // positions            // texture coords
        -50.0f, -50.0f, 0.0f,  0.0f, 0.0f,
         50.0f, -50.0f, 0.0f,  1.0f, 0.0f,
         50.0f,  50.0f, 0.0f,  1.0f, 1.0f,
        -50.0f,  50.0f, 0.0f,  0.0f, 1.0f
    };

    GLuint Indices[] = {
        0, 1, 2,
        0, 2, 3
    };

    // Setup first VAO (colored square)
    glGenVertexArrays(1, &VaoId1);
    glBindVertexArray(VaoId1);

    // Position buffer
    glGenBuffers(1, &VboId1);
    glBindBuffer(GL_ARRAY_BUFFER, VboId1);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices1), Vertices1, GL_STATIC_DRAW);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, 0);

    // Color buffer
    glGenBuffers(1, &ColorBufferId);
    glBindBuffer(GL_ARRAY_BUFFER, ColorBufferId);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Colors), Colors, GL_STATIC_DRAW);
    glEnableVertexAttribArray(1);
    glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, 0);

    // Element buffer
    glGenBuffers(1, &EboId1);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EboId1);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);

    // Setup second VAO (textured square)
    glGenVertexArrays(1, &VaoId2);
    glBindVertexArray(VaoId2);

    glGenBuffers(1, &VboId2);
    glBindBuffer(GL_ARRAY_BUFFER, VboId2);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices2), Vertices2, GL_STATIC_DRAW);

    // Position attribute
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(GLfloat), 0);

    // Texture coordinates
    glEnableVertexAttribArray(2);
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(GLfloat), (void*)(3 * sizeof(GLfloat)));

    glGenBuffers(1, &EboId2);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EboId2);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
}

void LoadTexture(void)
{
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

    // Create a simple checkerboard pattern if texture loading fails
    unsigned char checkerboard[64][64][3];
    for (int i = 0; i < 64; i++) {
        for (int j = 0; j < 64; j++) {
            unsigned char c = ((i & 8) == (j & 8)) ? 255 : 0;
            checkerboard[i][j][0] = c;
            checkerboard[i][j][1] = c;
            checkerboard[i][j][2] = c;
        }
    }

    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, 64, 64, 0, GL_RGB, GL_UNSIGNED_BYTE, checkerboard);
    glGenerateMipmap(GL_TEXTURE_2D);
}

void RenderFunction(void)
{
    glClear(GL_COLOR_BUFFER_BIT);

    // Bind shader program
    glUseProgram(ProgramId);

    // Update uniform
    myMatrixLocation = glGetUniformLocation(ProgramId, "myMatrix");

    // First square - Scale then translate
    glBindVertexArray(VaoId1);
    glm::mat4 scaleMatrix = glm::scale(glm::mat4(1.0f), glm::vec3(2.0f, 0.5f, 1.0f));
    glm::mat4 translateMatrix = glm::translate(glm::mat4(1.0f), glm::vec3(100.0f, 100.0f, 0.0f));
    myMatrix = resizeMatrix * translateMatrix * scaleMatrix;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, glm::value_ptr(myMatrix));
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);

    // Second square - Translate then scale
    glBindVertexArray(VaoId2);
    myMatrix = resizeMatrix * scaleMatrix * translateMatrix;
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, glm::value_ptr(myMatrix));

    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture);
    glUniform1i(glGetUniformLocation(ProgramId, "textureSampler"), 0);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);

    glutSwapBuffers();
}

void Initialize(void)
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);

    CreateVBO();
    CreateShaders();
    LoadTexture();

    // Initialize transformation matrix
    resizeMatrix = glm::ortho(xMin, xMax, yMin, yMax);

    // Enable depth test
    glEnable(GL_DEPTH_TEST);
}

int main(int argc, char* argv[])
{
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
    glutInitWindowPosition(100, 100);
    glutInitWindowSize(winWidth, winHeight);
    glutCreateWindow("Transformed Squares");

    GLenum err = glewInit();
    if (GLEW_OK != err) {
        fprintf(stderr, "GLEW Error: %s\n", glewGetErrorString(err));
        return 1;
    }

    Initialize();
    glutDisplayFunc(RenderFunction);
    glutMainLoop();
    return 0;
}