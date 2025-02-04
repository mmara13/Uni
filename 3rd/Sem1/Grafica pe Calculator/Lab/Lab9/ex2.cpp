#include <GL/glew.h>
#include <GL/glut.h>
#include <cmath>
#include <vector>
#include "glm/glm.hpp"
#include "glm/gtc/matrix_transform.hpp"
#include "glm/gtc/type_ptr.hpp"
#include "loadShaders.h"

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

// Window dimensions
const int winWidth = 800;
const int winHeight = 600;

// Cylinder parameters
const float radius = 0.5f;
const float height_cilindru = 1.0f;
const int nr_slices = 30;

// OpenGL objects
GLuint VaoId, VboId, ProgramId;
GLint modelLoc, viewLoc, projectionLoc;
GLint objectColorLoc, lightColorLoc, lightPosLoc, viewPosLoc;

// Transformation matrices
glm::mat4 model, view, projection;

// Light and view parameters
glm::vec3 lightPos(1.0f, 1.0f, 2.0f);
glm::vec3 viewPos(0.0f, 0.0f, 3.0f);
glm::vec3 objectColor(0.8f, 0.2f, 0.2f);
glm::vec3 lightColor(1.0f, 1.0f, 1.0f);

// Rotation and scale
float angleX = 0.0f;
float angleY = 0.0f;
float scaleX = 1.0f;
float scaleY = 1.0f;
float scaleZ = 1.0f;

// Buffers for vertices and normals
std::vector<GLfloat> vertices;




void generateCylinder() {
    vertices.clear();
    //varfuri pt margini
    for (int i = 0; i <= nr_slices; ++i) {
        float theta = i * 2.0f * M_PI / nr_slices;
        float x = radius * cos(theta);
        float y = radius * sin(theta);
        float nx = cos(theta);
        float ny = sin(theta);

        //pt partea de jos (Cercul
        vertices.insert(vertices.end(), { x, y, 0.0f, nx, ny, 0.0f });
        //cercul de sus
        vertices.insert(vertices.end(), { x, y, height_cilindru, nx, ny, 0.0f });
    }

    //partea de jos - cercul 
    vertices.insert(vertices.end(), { 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, -1.0f });
    for (int i = 0; i <= nr_slices; ++i) {
        float theta = i * 2.0f * M_PI / nr_slices;
        float x = radius * cos(theta);
        float y = radius * sin(theta);
        vertices.insert(vertices.end(), { x, y, 0.0f, 0.0f, 0.0f, -1.0f });
    }

    //partea de sus - cercul
    vertices.insert(vertices.end(), { 0.0f, 0.0f, height_cilindru, 0.0f, 0.0f, 1.0f });
    for (int i = nr_slices; i >= 0; --i) {
        float theta = i * 2.0f * M_PI / nr_slices;
        float x = radius * cos(theta);
        float y = radius * sin(theta);
        vertices.insert(vertices.end(), { x, y, height_cilindru, 0.0f, 0.0f, 1.0f });
    }
}

void CreateVBO() {
    generateCylinder();

    glGenVertexArrays(1, &VaoId);
    glBindVertexArray(VaoId);

    glGenBuffers(1, &VboId);
    glBindBuffer(GL_ARRAY_BUFFER, VboId);
    glBufferData(GL_ARRAY_BUFFER, vertices.size() * sizeof(float), vertices.data(), GL_STATIC_DRAW);

    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);

    //norm
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)(3 * sizeof(float)));
    glEnableVertexAttribArray(1);
}


void CreateShadersFragment() {
    ProgramId = LoadShaders("cilindru.vert", "cilindru.frag");
    glUseProgram(ProgramId);

    // Get uniform locations
    modelLoc = glGetUniformLocation(ProgramId, "model");
    viewLoc = glGetUniformLocation(ProgramId, "view");
    projectionLoc = glGetUniformLocation(ProgramId, "projection");

    objectColorLoc = glGetUniformLocation(ProgramId, "objectColor");
    lightColorLoc = glGetUniformLocation(ProgramId, "lightColor");
    lightPosLoc = glGetUniformLocation(ProgramId, "lightPos");
    viewPosLoc = glGetUniformLocation(ProgramId, "viewPos");
}

void keyboard(unsigned char key, int x, int y) {
    switch (key) {
    case 27: // ESC key
        exit(0);
        break;
    case 'a':
        angleY -= 5.0f;
        break;
    case 'd':
        angleY += 5.0f;
        break;
    case 'w':
        angleX -= 5.0f;
        break;
    case 's':
        angleX += 5.0f;
        break;
    case '+':
        scaleX *= 1.1f;
        scaleY *= 1.1f;
        scaleZ *= 1.1f;
        break;
    case '-':
        scaleX /= 1.1f;
        scaleY /= 1.1f;
        scaleZ /= 1.1f;
        break;
    }
    glutPostRedisplay();
}

void RenderScene() {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // Create transformation matrices
    model = glm::mat4(1.0f);
    model = glm::rotate(model, glm::radians(angleX), glm::vec3(1.0f, 0.0f, 0.0f));
    model = glm::rotate(model, glm::radians(angleY), glm::vec3(0.0f, 1.0f, 0.0f));
    model = glm::scale(model, glm::vec3(scaleX, scaleY, scaleZ));

    view = glm::lookAt(
        glm::vec3(0.0f, 0.0f, 3.0f),
        glm::vec3(0.0f, 0.0f, 0.0f),
        glm::vec3(0.0f, 1.0f, 0.0f)
    );

    projection = glm::perspective(glm::radians(45.0f), (float)winWidth / (float)winHeight, 0.1f, 100.0f);

    // Use shader program
    glUseProgram(ProgramId);

    // Pass transformation matrices to shader
    glUniformMatrix4fv(modelLoc, 1, GL_FALSE, glm::value_ptr(model));
    glUniformMatrix4fv(viewLoc, 1, GL_FALSE, glm::value_ptr(view));
    glUniformMatrix4fv(projectionLoc, 1, GL_FALSE, glm::value_ptr(projection));

    // Pass light and material properties to shaders
    glUniform3fv(objectColorLoc, 1, glm::value_ptr(objectColor));
    glUniform3fv(lightColorLoc, 1, glm::value_ptr(lightColor));
    glUniform3fv(lightPosLoc, 1, glm::value_ptr(lightPos));
    glUniform3fv(viewPosLoc, 1, glm::value_ptr(viewPos));

    // Draw cylinder
    glBindVertexArray(VaoId);

    // Draw side quads
    glDrawArrays(GL_QUAD_STRIP, 0, (nr_slices + 1) * 2);

    // Draw bottom cap
    glDrawArrays(GL_TRIANGLE_FAN, (nr_slices + 1) * 2, nr_slices + 2);

    // Draw top cap
    glDrawArrays(GL_TRIANGLE_FAN, (nr_slices + 1) * 2 + nr_slices + 2, nr_slices + 2);

    glutSwapBuffers();
}

void reshape(int w, int h) {
    glViewport(0, 0, w, h);
    projection = glm::perspective(glm::radians(45.0f), (float)w / (float)h, 0.1f, 100.0f);
}

int main(int argc, char** argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(winWidth, winHeight);
    glutCreateWindow("Phong Lighting - Cylinder");

    glewInit();

    CreateVBO();
    CreateShadersFragment();

    glEnable(GL_DEPTH_TEST);

    glutDisplayFunc(RenderScene);
    glutReshapeFunc(reshape);
    glutKeyboardFunc(keyboard);

    glutMainLoop();
    return 0;
}