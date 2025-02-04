#include <windows.h>  // biblioteci care urmeaza sa fie incluse
#include <stdio.h>
#include <stdlib.h> // necesare pentru citirea shader-elor
#include <cstdlib> 
#include <vector>
#include <math.h>
#include <iostream>
#include <GL/glew.h> // glew apare inainte de freeglut
#include <GL/freeglut.h> // nu trebuie uitat freeglut.h

#include "loadShaders.h"

#include "glm/glm.hpp"  
#include "glm/gtc/matrix_transform.hpp"
#include "glm/gtx/transform.hpp"
#include "glm/gtc/type_ptr.hpp"
#include "objloader.hpp"  


//  Identificatorii obiectelor de tip OpenGL;
GLuint
VaoId,
VboId,
ProgramId,
nrVertLocation,
myMatrixLocation,
viewLocation,
projLocation;

const float PI = 3.14159265358979323846f;

// Variabila pentru numarul de varfuri
int nrVertices;

// Vectori pentru varfuri, coordonate de texturare, normale
std::vector<glm::vec3> vertices;
std::vector<glm::vec2> uvs;
std::vector<glm::vec3> normals;

// Matrice utilizate
glm::mat4 myMatrix;
glm::mat4 view;
glm::mat4 projection;

//win dim
const int winWidth = 800, winHeight = 600;


//rot angls
float angleX = 0.0f, angleY = 0.0f, angleZ = 0.0f;


//scalare
float scaleX = 1.0f, scaleY = 1.0f, scaleZ = 1.0f;


//parametrii pt cilindru - far
const float radius = 0.5f, height_cylinder = 1.0f;
const int nr_slices = 30, stacks = 20;


//parametrii pt con -acoperis far
const float cone_radius = 0.5f, cone_height = 0.8f;

//arametrii sfera pt om de zapada
const float sphere_radius_large = 0.6f, sphere_radius_medium = 0.4f, sphere_radius_small = 0.3f;

//	Elemente pentru matricea de vizualizare;
float refX = 0.0f, refY = 0.0f, refZ = 0.0f,
obsX, obsY, obsZ,
vX = 0.0f, vY = 2.0f, vZ = 1.0f;
//	Elemente pentru deplasarea pe sfera;
float alpha = 0.0f, beta = 0.0f, dist = 6.0f,
incrAlpha1 = 0.01, incrAlpha2 = 0.01;
//	Elemente pentru matricea de proiectie;
float width = 800, height = 600, dNear = 4.f, fov = 60.f * PI / 180;

void processNormalKeys(unsigned char key, int x, int y)
{
    switch (key) {
    case '-':
        dist -= 0.25;	//	apasarea tastelor `+` si `-` schimba pozitia observatorului (se departeaza / aproprie);
        //recalculare poz camerei in functie de noua dist
        obsX = refX + dist * cos(alpha) * cos(beta);
        obsY = refY + dist * cos(alpha) * sin(beta);
        obsZ = refZ + dist * sin(alpha);

        //actualizare view matrix
        glm::vec3 obs = glm::vec3(obsX, obsY, obsZ);
        glm::vec3 pctRef = glm::vec3(refX, refY, refZ);
        view = glm::lookAt(obs, pctRef, glm::vec3(0.0f, 1.0f, 0.0f));
        glUniformMatrix4fv(viewLocation, 1, GL_FALSE, &view[0][0]);

        break;
    case '+':
        dist += 0.25;
        //recalculare poz camerei in functie de noua dist
        obsX = refX + dist * cos(alpha) * cos(beta);
        obsY = refY + dist * cos(alpha) * sin(beta);
        obsZ = refZ + dist * sin(alpha);

        // Update view matrix
        obs = glm::vec3(obsX, obsY, obsZ);
        pctRef = glm::vec3(refX, refY, refZ);
        view = glm::lookAt(obs, pctRef, glm::vec3(0.0f, 1.0f, 0.0f));
        glUniformMatrix4fv(viewLocation, 1, GL_FALSE, &view[0][0]);
        break;

    }
    if (key == 27)
        exit(0);
    
    // Trigger a redraw
    glutPostRedisplay();
}

void processSpecialKeys(int key, int xx, int yy)
{
    switch (key)				//	Procesarea tastelor 'LEFT', 'RIGHT', 'UP', 'DOWN';
    {							//	duce la deplasarea observatorului pe suprafata sferica in jurul cubului;
    case GLUT_KEY_LEFT:
        beta -= 0.01;
        break;
    case GLUT_KEY_RIGHT:
        beta += 0.01;
        break;
    case GLUT_KEY_UP:
        alpha += incrAlpha1;
        if (abs(alpha - PI / 2) < 0.05)
        {
            incrAlpha1 = 0.f;
        }
        else
        {
            incrAlpha1 = 0.01f;
        }
        break;
    case GLUT_KEY_DOWN:
        alpha -= incrAlpha2;
        if (abs(alpha + PI / 2) < 0.05)
        {
            incrAlpha2 = 0.f;
        }
        else
        {
            incrAlpha2 = 0.01f;
        }
        break;
    }
    ///recalculare poz camerei in functie de alpha si beta
    obsX = refX + dist * cos(alpha) * cos(beta);
    obsY = refY + dist * cos(alpha) * sin(beta);
    obsZ = refZ + dist * sin(alpha);
    glm::vec3 obs = glm::vec3(obsX, obsY, obsZ);

    //actualizare view matrix
    view = glm::lookAt(obs, glm::vec3(0.0f, 0.0f, 0.0f), glm::vec3(0.0f, 1.0f, 0.0f));
    glUniformMatrix4fv(viewLocation, 1, GL_FALSE, &view[0][0]);
}

// Se initializeaza un vertex Buffer Object(VBO) pentru transferul datelor spre memoria placii grafice(spre shadere);
// In acesta se stocheaza date despre varfuri;
void CreateVBO(void)
{

    // Generare VAO;
    glGenVertexArrays(1, &VaoId);
    glBindVertexArray(VaoId);

    // Generare VBO - varfurile si normalele sunt memorate in sub-buffere;
    glGenBuffers(1, &VboId);
    glBindBuffer(GL_ARRAY_BUFFER, VboId);
    glBufferData(GL_ARRAY_BUFFER, vertices.size() * sizeof(glm::vec3) + normals.size() * sizeof(glm::vec3), NULL, GL_STATIC_DRAW);
    glBufferSubData(GL_ARRAY_BUFFER, 0, vertices.size() * sizeof(glm::vec3), &vertices[0]);
    glBufferSubData(GL_ARRAY_BUFFER, vertices.size() * sizeof(glm::vec3), normals.size() * sizeof(glm::vec3), &normals[0]);

    // Atributele; 
    glEnableVertexAttribArray(0); // atributul 0 = pozitie
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, (GLvoid*)0);
    glEnableVertexAttribArray(1); // atributul 1 = normale
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), (GLvoid*)(vertices.size() * sizeof(glm::vec3)));

}

//functie initializare
void init() {
    glClearColor(71.f / 255.f, 185.f / 255.f, 198.f / 255.f, 1.0f); //albastru deschis turcoaz
    glEnable(GL_DEPTH_TEST);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(45.0, (GLfloat)winWidth / (GLfloat)winHeight, 0.1, 100.0);
    glMatrixMode(GL_MODELVIEW);

    glDisable(GL_LIGHTING);
}

//  Eliminarea obiectelor de tip VBO dupa rulare;
void DestroyVBO(void)
{
    glDisableVertexAttribArray(0);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);
    glDeleteVertexArrays(1, &VaoId);
}

//  Crearea si compilarea obiectelor de tip shader;
void CreateShaders(void)
{
    ProgramId = LoadShaders("10_01_Shader.vert", "10_01_Shader.frag");
    glUseProgram(ProgramId);
}

// Elimina obiectele de tip shader dupa rulare;
void DestroyShaders(void)
{
    glDeleteProgram(ProgramId);
}

void Cleanup(void)
{
    DestroyShaders();
    DestroyVBO();
};

//  Setarea parametrilor necesari pentru fereastra de vizualizare;
void Initialize(void)
{
    glClearColor(0.95f, 0.82f, 0.4f, 1.0f); // culoarea de fond a ecranului

    // Incarcarea modelului 3D in format OBJ, trebuie sa fie in acelasi director cu proiectul actual;
    bool model = loadOBJ("model_blender.obj", vertices, uvs, normals);
    nrVertices = vertices.size();

    // Crearea VBO / shadere-lor
    CreateVBO();
    CreateShaders();

    //pt snowman
    GLint lightPosLocation, viewPosLocation, lightColorLocation, objectColorLocation;
    lightPosLocation = glGetUniformLocation(ProgramId, "lightPos");
    viewPosLocation = glGetUniformLocation(ProgramId, "viewPos");
    lightColorLocation = glGetUniformLocation(ProgramId, "lightColor");
    objectColorLocation = glGetUniformLocation(ProgramId, "objectColor");

    // Locatii ptr shader
    nrVertLocation = glGetUniformLocation(ProgramId, "nrVertices");
    myMatrixLocation = glGetUniformLocation(ProgramId, "myMatrix");
    viewLocation = glGetUniformLocation(ProgramId, "view");
    projLocation = glGetUniformLocation(ProgramId, "projection");

    // Variabile ce pot fi transmise catre shader
    glUniform1i(ProgramId, nrVertices);
}



//desenare sfere pt om zapada
void drawSphere(float radius) {
    int slices = 30;
    int stacks = 30;

    for (int i = 0; i < stacks; ++i) {
        float lat1 = PI * ((float)i / stacks - 0.5f);
        float lat2 = PI * ((float)(i + 1) / stacks - 0.5f);

        glBegin(GL_QUAD_STRIP);
        for (int j = 0; j <= slices; ++j) {
            float lon = 2 * PI * (float)j / slices;

            //culoare gradient pt sfere nuante de albastru-verde
            float r = 0.f / 255.f + (float)i / stacks * 50.f / 255.f;
            float g = 128.f / 255.f + (float)i / stacks * 100.f / 255.f;
            float b = 128.f / 255.f - (float)i / stacks * 50.f / 255.f;
            glColor3f(r, g, b);

            //1 pct
            float x1 = radius * cos(lat1) * cos(lon);
            float y1 = radius * cos(lat1) * sin(lon);
            float z1 = radius * sin(lat1);
            glVertex3f(x1, y1, z1);

            //2pct
            float x2 = radius * cos(lat2) * cos(lon);
            float y2 = radius * cos(lat2) * sin(lon);
            float z2 = radius * sin(lat2);
            glVertex3f(x2, y2, z2);
        }
        glEnd();
    }
}




//fctie de generare varfuri si normale pt sfere
void generateSphereData(float radius, int slices, int stacks,
    std::vector<glm::vec3>& sphereVertices,
    std::vector<glm::vec3>& sphereNormals) {
    sphereVertices.clear();
    sphereNormals.clear();

    for (int i = 0; i < stacks; ++i) {
        float lat1 = PI * ((float)i / stacks - 0.5f);
        float lat2 = PI * ((float)(i + 1) / stacks - 0.5f);

        for (int j = 0; j <= slices; ++j) {
            float lon = 2 * PI * (float)j / slices;

            //varfuri pt primu triunghi
            glm::vec3 v1(
                radius * cos(lat1) * cos(lon),
                radius * cos(lat1) * sin(lon),
                radius * sin(lat1)
            );
            glm::vec3 n1 = glm::normalize(v1);

            glm::vec3 v2(
                radius * cos(lat2) * cos(lon),
                radius * cos(lat2) * sin(lon),
                radius * sin(lat2)
            );
            glm::vec3 n2 = glm::normalize(v2);

            glm::vec3 v3(
                radius * cos(lat2) * cos(lon + 2 * PI / slices),
                radius * cos(lat2) * sin(lon + 2 * PI / slices),
                radius * sin(lat2)
            );
            glm::vec3 n3 = glm::normalize(v3);

            //vf pt al doilea triunghi
            glm::vec3 v4(
                radius * cos(lat1) * cos(lon + 2 * PI / slices),
                radius * cos(lat1) * sin(lon + 2 * PI / slices),
                radius * sin(lat1)
            );
            glm::vec3 n4 = glm::normalize(v4);

            //adaugare vertices si normale
            sphereVertices.push_back(v1);
            sphereVertices.push_back(v2);
            sphereVertices.push_back(v3);
            sphereVertices.push_back(v1);
            sphereVertices.push_back(v3);
            sphereVertices.push_back(v4);

            sphereNormals.push_back(n1);
            sphereNormals.push_back(n2);
            sphereNormals.push_back(n3);
            sphereNormals.push_back(n1);
            sphereNormals.push_back(n3);
            sphereNormals.push_back(n4);
        }
    }
}

void RenderFunction(void)
{

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);

    //matr rotatie
    myMatrix = glm::rotate(glm::mat4(1.0f), PI / 2, glm::vec3(0.0, 1.0, 0.0))
        * glm::rotate(glm::mat4(1.0f), PI / 2, glm::vec3(0.0, 0.0, 1.0));
    glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &myMatrix[0][0]);

    //poz camerei 
    obsX = refX + dist * cos(alpha) * cos(beta);
    obsY = refY + dist * cos(alpha) * sin(beta);
    obsZ = refZ + dist * sin(alpha);

    glm::vec3 obs = glm::vec3(obsX, obsY, obsZ);
    glm::vec3 pctRef = glm::vec3(refX, refY, refZ);
    glm::vec3 vert = glm::vec3(vX, vY, vZ);

    //adjustment pt camera ca sa se vada din fata
    glm::vec3 cameraPos = glm::vec3(4.0f, 0.0f, 8.0f);
    glm::vec3 cameraTarget = glm::vec3(0.0f, 0.0f, 0.0f);
    glm::vec3 cameraUp = glm::vec3(0.0f, 1.0f, 0.0f);

    ////view matrix
    //view = glm::lookAt(cameraPos, cameraTarget, cameraUp);
    //glUniformMatrix4fv(viewLocation, 1, GL_FALSE, &view[0][0]);

    //view matrix dinamic in functie de ce am calculat mai sus
    view = glm::lookAt(obs, pctRef, cameraUp);
    glUniformMatrix4fv(viewLocation, 1, GL_FALSE, &view[0][0]);

    ////view matrix cu glm::lookAt
    //view = glm::lookAt(obs, pctRef, vert);
    //glUniformMatrix4fv(viewLocation, 1, GL_FALSE, &view[0][0]);

    // matrix de proiectie
    projection = glm::infinitePerspective(GLfloat(fov), GLfloat(width) / GLfloat(height), dNear);
    glUniformMatrix4fv(projLocation, 1, GL_FALSE, &projection[0][0]);

    //proprietati pt model de lumina
    glm::vec3 lightPos(5.0f, 5.0f, 5.0f);
    glm::vec3 lightColor(1.0f, 1.0f, 1.0f);

    //OBJ Model
    {
        glm::mat4 modelMatrix = glm::translate(glm::mat4(1.0f), glm::vec3(-2.0f, 0.0f, 0.0f)) *
            glm::rotate(glm::mat4(1.0f), glm::radians(45.0f), glm::vec3(0, 1, 0)) *
            glm::scale(glm::mat4(1.0f), glm::vec3(1.0f, 1.0f, 1.0f));

        glm::mat4 finalMatrix = modelMatrix;
        glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &finalMatrix[0][0]);

       
        glm::vec3 objColor(0.59f, 0.29f, 0.0f);  //brown pt maimuta
        glUniform3fv(glGetUniformLocation(ProgramId, "lightPos"), 1, &lightPos[0]);
        glUniform3fv(glGetUniformLocation(ProgramId, "viewPos"), 1, &obs[0]);
        glUniform3fv(glGetUniformLocation(ProgramId, "lightColor"), 1, &lightColor[0]);
        glUniform3fv(glGetUniformLocation(ProgramId, "objectColor"), 1, &objColor[0]);

        glBindVertexArray(VaoId);
        glDrawArrays(GL_TRIANGLES, 0, vertices.size());
    }

    //sfere pt om zapada
    {
        
        float radius_sfere[3] = { 0.3f, 0.5f, 0.7f };
        float verticalOffsets[3] = { 3.0f, 2.3f, 1.3f };
        
        glm::vec3 sphereColors[3] = {
            glm::vec3(0.678f, 0.847f, 0.902f),  //lbastru pt sfere
            glm::vec3(0.678f, 0.847f, 0.902f),
            glm::vec3(0.678f, 0.847f, 0.902f)
        };

       
        for (int i = 0; i < 3; ++i) {
            glm::mat4 sphereMatrix = glm::translate(glm::mat4(1.0f),
                glm::vec3(2.0f, verticalOffsets[i] - 2.0f, 0.0f)) *
                glm::scale(glm::mat4(1.0f), glm::vec3(radius_sfere[i]));
            glUniformMatrix4fv(myMatrixLocation, 1, GL_FALSE, &sphereMatrix[0][0]);

            glUniform3fv(glGetUniformLocation(ProgramId, "lightPos"), 1, &lightPos[0]);
            glUniform3fv(glGetUniformLocation(ProgramId, "viewPos"), 1, &obs[0]);
            glUniform3fv(glGetUniformLocation(ProgramId, "lightColor"), 1, &lightColor[0]);
            glUniform3fv(glGetUniformLocation(ProgramId, "objectColor"), 1, &sphereColors[i][0]);

            std::vector<glm::vec3> sphereVertices, sphereNormals;
            generateSphereData(1.0f, 30, 30, sphereVertices, sphereNormals);

            GLuint sphereVaoId, sphereVboId;
            glGenVertexArrays(1, &sphereVaoId);
            glBindVertexArray(sphereVaoId);

            glGenBuffers(1, &sphereVboId);
            glBindBuffer(GL_ARRAY_BUFFER, sphereVboId);
            glBufferData(GL_ARRAY_BUFFER,
                sphereVertices.size() * sizeof(glm::vec3) + sphereNormals.size() * sizeof(glm::vec3),
                NULL, GL_STATIC_DRAW);
            glBufferSubData(GL_ARRAY_BUFFER, 0, sphereVertices.size() * sizeof(glm::vec3), &sphereVertices[0]);
            glBufferSubData(GL_ARRAY_BUFFER, sphereVertices.size() * sizeof(glm::vec3),
                sphereNormals.size() * sizeof(glm::vec3), &sphereNormals[0]);

            glEnableVertexAttribArray(0);
            glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, (GLvoid*)0);
            glEnableVertexAttribArray(1);
            glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 0, (GLvoid*)(sphereVertices.size() * sizeof(glm::vec3)));

            glDrawArrays(GL_TRIANGLES, 0, sphereVertices.size());

            glDeleteVertexArrays(1, &sphereVaoId);
            glDeleteBuffers(1, &sphereVboId);
        }
    }

    glutSwapBuffers();
    glFlush();
}



int main(int argc, char** argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGBA | GLUT_DEPTH | GLUT_DOUBLE);
    glutInitWindowPosition(100, 100);
    glutInitWindowSize(1200, 900);
    glutCreateWindow("Blender object and spheres(om de zapada Tema 6)");
    glewInit();
    init();
    Initialize();
    glutIdleFunc(RenderFunction);
    glutDisplayFunc(RenderFunction);
    glutKeyboardFunc(processNormalKeys);
    glutSpecialFunc(processSpecialKeys);
    glutCloseFunc(Cleanup);
    glutMainLoop();
    return 0;
}
