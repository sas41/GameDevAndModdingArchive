#pragma once
// OpenGL Libraries
#include <glad/glad.h>
#include <GLFW/glfw3.h>

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

#include <stdlib.h>
#include <iostream>
#include <vector>
#include <thread>

#include "Shader.h"
#include "Voxel.h"
#include "Camera.h"

using namespace std;

namespace vox {

class Renderer
{
private:

	const char FragmentShaderPath[63] = "shaders/FragmentShader.fs.glsl";
	const char VertexShaderPath[61] = "shaders/VertexShader.vs.glsl";

	int windowHeight, windowWidth;

	//Shader shaderSet; // This is the Shader Program
	GLFWwindow* window;

	Shader voxelShaders;

	// Timing
	float deltaTime = 0.0f;	// time between current frame and last frame
	float lastFrame = 0.0f;

	Camera camera;

	float lastX;
	float lastY;
	bool firstMouse = true;

	Voxel vox;

	void InitilizeRenderer();

	void processInput(GLFWwindow *window);

	void framebuffer_size_callback(GLFWwindow* window, int width, int height);
	void mouse_callback(GLFWwindow* window, double xpos, double ypos);
	void RenderLoop();

	void SpawnRenderingThread();

public:
	Renderer(int w, int h);
	~Renderer();
};

}