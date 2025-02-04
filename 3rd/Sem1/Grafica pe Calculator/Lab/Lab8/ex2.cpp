#include <GL/glut.h>
#include <cmath>

// Define PI if not already defined
#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

// Window dimensions
const int winWidth = 800;
const int winHeight = 600;

// Rotation angles
float angleX = 0.0f;
float angleY = 0.0f;

// Scaling factors
float scaleX = 1.0f;
float scaleY = 1.0f;
float scaleZ = 1.0f;

// Cylinder parameters
const float radius = 0.5f;
const float height_cilindru = 1.0f;
const int nr_slices = 30;

// Function for setting up lighting
void setupLighting() {
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    glEnable(GL_COLOR_MATERIAL);

    float lightPos[] = { 1.0f, 1.0f, 2.0f, 1.0f };
    float ambient[] = { 0.2f, 0.2f, 0.2f, 1.0f };
    float diffuse[] = { 0.8f, 0.8f, 0.8f, 1.0f };
    float specular[] = { 1.0f, 1.0f, 1.0f, 1.0f };

    glLightfv(GL_LIGHT0, GL_POSITION, lightPos);
    glLightfv(GL_LIGHT0, GL_AMBIENT, ambient);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuse);
    glLightfv(GL_LIGHT0, GL_SPECULAR, specular);
}

// Function to draw the cylinder with dynamic colors
void drawCylinder() {
    // Wall of the cylinder
    glBegin(GL_QUAD_STRIP);
    for (int i = 0; i <= nr_slices; ++i) {
        float u = (float)i / nr_slices * 2 * M_PI;

        float x1 = radius * cos(u);
        float y1 = radius * sin(u);

        // Color based on angle
        float intensity = (cos(u) + 1.0f) * 0.5f;
        glColor3f(intensity, 0.5f, 1.0f - intensity);

        glVertex3f(x1, y1, 0);
        glVertex3f(x1, y1, height_cilindru);
    }
    glEnd();

    // Bottom circle
    glBegin(GL_TRIANGLE_FAN);
    glColor3f(1.0f, 0.0f, 0.0f); // Red for bottom
    glVertex3f(0, 0, 0);
    for (int i = 0; i <= nr_slices; ++i) {
        float u = (float)i / nr_slices * 2 * M_PI;
        glVertex3f(radius * cos(u), radius * sin(u), 0);
    }
    glEnd();

    // Top circle
    glBegin(GL_TRIANGLE_FAN);
    glColor3f(0.0f, 1.0f, 0.0f); // Green for top
    glVertex3f(0, 0, height_cilindru);
    for (int i = nr_slices; i >= 0; --i) {
        float u = (float)i / nr_slices * 2 * M_PI;
        glVertex3f(radius * cos(u), radius * sin(u), height_cilindru);
    }
    glEnd();
}

// Keyboard controls
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

// Display function
void display() {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glLoadIdentity();

    gluLookAt(0.0, 0.0, 3.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);

    glRotatef(angleX, 1.0f, 0.0f, 0.0f);
    glRotatef(angleY, 0.0f, 1.0f, 0.0f);
    glScalef(scaleX, scaleY, scaleZ);

    drawCylinder();

    glutSwapBuffers();
}

// Reshape function
void reshape(int w, int h) {
    glViewport(0, 0, w, h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(45.0, (GLfloat)w / (GLfloat)h, 0.1, 100.0);
    glMatrixMode(GL_MODELVIEW);
}

// Main function
int main(int argc, char** argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(winWidth, winHeight);
    glutCreateWindow("Cylinder with Lighting and Controls");

    glEnable(GL_DEPTH_TEST);
    setupLighting();

    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    glutKeyboardFunc(keyboard);

    glutMainLoop();
    return 0;
}
