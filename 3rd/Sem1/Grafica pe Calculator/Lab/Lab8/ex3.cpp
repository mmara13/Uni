#include <GL/glut.h>
#include <cmath>
#include <iostream>

const float PI = 3.14159265358979323846f;

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

//fct desenare cilindru pt far
void drawCylinder() {
    glBegin(GL_QUAD_STRIP);
    for (int i = 0; i <= nr_slices; ++i) {
        float u = (float)i / nr_slices * 2 * PI;

        //coord
        float x1 = radius * cos(u);
        float y1 = radius * sin(u);

        //culoare pt cilindru
        glColor3f(226.f / 255.f, 229.f / 255.f, 222.f / 255.f);

        //bottom vert
        glVertex3f(x1, y1, 0);

        //topvertex
        glVertex3f(x1, y1, height_cylinder);
    }
    glEnd();

    //cerc inferior cilindru
    glBegin(GL_TRIANGLE_FAN);
    glColor3f(0.0f, 0.0f, 0.0f); 
    glVertex3f(0, 0, 0);  //centru cercului de jos
    for (int i = 0; i <= nr_slices; ++i) {
        float u = (float)i / nr_slices * 2 * PI;
        float x = radius * cos(u);
        float y = radius * sin(u);
        glVertex3f(x, y, 0);
    }
    glEnd();

    //cerc sus cilindru
    glBegin(GL_TRIANGLE_FAN);
    glColor3f(0.0f, 0.0f, 0.0f); 
    glVertex3f(0, 0, height_cylinder);  //centru cercului desus
    for (int i = nr_slices; i >= 0; --i) {
        float u = (float)i / nr_slices * 2 * PI;
        float x = radius * cos(u);
        float y = radius * sin(u);
        glVertex3f(x, y, height_cylinder);
    }
    glEnd();
}

//fctie desenare con pt far
void drawCone() {
    glBegin(GL_TRIANGLE_FAN);
    glColor3f(139.f / 255.f, 0.f / 255.f, 0.f / 255.f); //red burgundy pt acoperis

    glVertex3f(0, 0, height_cylinder);  //centrul bazaei (in vf cilindrului)

    // Vertices of the cone base
    for (int i = 0; i <= nr_slices; ++i) {
        float u = (float)i / nr_slices * 2 * PI;
        float x = cone_radius * cos(u);
        float y = cone_radius * sin(u);
        glVertex3f(x, y, height_cylinder); //acelasi z ca top pt cilindru
    }
    glEnd();

    //fete laterele con
    glBegin(GL_TRIANGLES);
    for (int i = 0; i < nr_slices; ++i) {
        float u1 = (float)i / nr_slices * 2 * PI;
        float u2 = (float)(i + 1) / nr_slices * 2 * PI;

        float x1 = cone_radius * cos(u1);
        float y1 = cone_radius * sin(u1);

        float x2 = cone_radius * cos(u2);
        float y2 = cone_radius * sin(u2);

        glColor3f(139.f / 255.f, 0.f / 255.f, 0.f / 255.f);  

        //vf conului
        glVertex3f(0, 0, height_cylinder + cone_height);

        //vert de jos
        glVertex3f(x1, y1, height_cylinder);
        glVertex3f(x2, y2, height_cylinder);
    }
    glEnd();
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


//display scena
void display() {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glLoadIdentity();

    //poz camera aplicare rotatii si scalari
    glTranslatef(0.0f, 0.0f, -6.0f);  //miscare backwards ca sa vedem scena
    glScalef(scaleX, scaleY, scaleZ);  //scalare

    //rotatii axe
    glRotatef(angleX, 1.0f, 0.0f, 0.0f); 
    glRotatef(angleY, 0.0f, 1.0f, 0.0f);  
    glRotatef(angleZ, 0.0f, 0.0f, 1.0f);  

    //desenare far
    glPushMatrix();
    glTranslatef(-1.5f, -0.5f, 0.0f);  
    drawCylinder();
    drawCone();
    glPopMatrix();

    //desenare om zapada
    glPushMatrix();
    glTranslatef(2.0f, -1.0f, 0.0f);  
    
    drawSphere(sphere_radius_large);
    glTranslatef(0.0f, 0.0f, sphere_radius_large);  
    drawSphere(sphere_radius_medium);
    glTranslatef(0.0f, 0.0f, sphere_radius_medium); 
    drawSphere(sphere_radius_small);
    glPopMatrix();

    glutSwapBuffers();
}


void keyboard(unsigned char key, int x, int y) {
    switch (key) {
    case 27: //esc pt exit
        exit(0);
        break;
    case 'a': //left pe Y-axis
        angleY -= 5.0f;
        break;
    case 'd': // right pe Y-axis
        angleY += 5.0f;
        break;
    case 'w': // up pe X-axis
        angleX -= 5.0f;
        break;
    case 's': // down pe X-axis
        angleX += 5.0f;
        break;
    case 'q': //counter-clockwise
        angleZ -= 5.0f;
        break;
    case 'e'://clockwise
        angleZ += 5.0f;
        break;
    case '+': //scalare
        scaleX *= 1.1f;
        scaleY *= 1.1f;
        scaleZ *= 1.1f;
        break;
    case '-': 
        scaleX *= 0.9f;
        scaleY *= 0.9f;
        scaleZ *= 0.9f;
        break;
    }
    glutPostRedisplay();
}

int main(int argc, char** argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(winWidth, winHeight);
    glutCreateWindow("Farhouse and Snowman");

    init();
    glutDisplayFunc(display);
    glutKeyboardFunc(keyboard);
    glutMainLoop();
    return 0;
}
