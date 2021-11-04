#pragma once
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <stdlib.h>
#include <iostream>
#include <vector>
#include "Shader.h"

#include "stb_image.h"

namespace vox {

class Voxel
{
private:

	const char FragmentShaderPath[63] = "shaders/FragmentShader.fs.glsl";
	const char VertexShaderPath[61] =	"shaders/VertexShader.vs.glsl";

	//bool isPlaced;

	int x, y, z; // World Coordinates if applicable.

	unsigned int texture1, texture2;

	unsigned int VBO, VAO, EBO;

	Shader * shaderSet; // This is the Shader Program


public:
	Voxel(Shader * shader);
	Voxel();
	~Voxel();
	void GenerateGeometry();
	void GenerateTexture(std::string path);
	void Render();
};

}
