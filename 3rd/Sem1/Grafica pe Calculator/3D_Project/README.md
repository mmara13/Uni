# Solar System in OpenGL

This project is a solar system simulation created in OpenGL, using C++ and various 3D graphics libraries.

## System Requirements

- Visual Studio 2022 (or newer)
- OpenGL 3.3 support or higher
- Windows 10/11

## Required Libraries

The project uses the following libraries:
- GLFW 3.x
- GLEW
- GLM
- SOIL

## Project Setup

1. **Download and Install Libraries**
   - GLFW: https://www.glfw.org/download.html
   - GLEW: http://glew.sourceforge.net/
   - GLM: https://github.com/g-truc/glm/releases
   - SOIL: https://github.com/paralin/soil

2. **Folder Structure**

Project_3D/

├── include/

│   ├── GL/

│   ├── GLFW/

│   ├── glm/

│   └── SOIL/

├── lib/

│   ├── x64/

│   │   ├── GL/

│   │   ├── GLFW/

│   │   └── SOIL/

│   └── x32/

└── src/

3. **Visual Studio Configuration**
- Open the .sln file
- In project properties, configure:
  - VC++ Directories -> Include Directories: Add path to `include` folder
  - VC++ Directories -> Library Directories: Add path to `lib` folder
  - Linker -> Input -> Additional Dependencies: Add:
    ```
    opengl32.lib
    glfw3.lib
    glew32.lib
    SOIL.lib
    ```

4. **Copy DLL Files**
- From the `lib/x64` folder (or `x32`), copy all .dll files to the executable folder (usually `/Debug` or `/Release`)

## Running the Project

1. Compile the project in Visual Studio (F7)
2. Run the project (F5)

## Controls

- W/S: Camera zoom in/out
- A/D: Rotate camera left/right
- +/-: Camera control
- ESC: Exit

## Troubleshooting

If you encounter "Missing DLL" errors:
1. Check if all DLLs are in the correct folder
2. Reinstall libraries in case files are corrupted
3. Make sure you're using the correct version (x32/x64) of the libraries


