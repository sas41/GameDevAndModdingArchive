#include "Renderer.h"

using vox::Renderer;

Renderer::Renderer(int w, int h) : voxelShaders(), vox(&voxelShaders), camera(glm::vec3(0.0f, 0.0f, 3.0f))
{
	windowWidth = w;
	windowHeight = h;
	InitilizeRenderer();		// Do stuff.
	vox.GenerateGeometry();
	vox.GenerateTexture("textures/container.jpg");
	SpawnRenderingThread();		// This will be the source of many woes.
}

Renderer::~Renderer()
{
	glfwDestroyWindow(window);
	glfwTerminate();
}


void Renderer::InitilizeRenderer()
{
	glfwInit();
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
	
	window = glfwCreateWindow(windowWidth, windowHeight, "LearnOpenGL", NULL, NULL);
	if (window == NULL)
	{
		std::cout << "Failed to create GLFW window" << std::endl;
		glfwTerminate();
		return;
	}
	
	glfwMakeContextCurrent(window);
	//glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);
	
	
	if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
	{
		std::cout << "Failed to initialize GLAD" << std::endl;
		return;
	}

	glEnable(GL_DEPTH_TEST);

	// Define Rendering area and a callback, in case the window is resized.
	//glfwSetFramebufferSizeCallback(window, this->framebuffer_size_callback);

	//glfwSetCursorPosCallback(window, this->mouse_callback);
	glViewport(0, 0, windowWidth, windowHeight);

	lastX = windowWidth / 2.0f;
	lastY = windowHeight / 2.0f;
}

void Renderer::SpawnRenderingThread()
{
	// TODO Make a new thread.
	RenderLoop();
}

void Renderer::RenderLoop()
{
	while (!glfwWindowShouldClose(window))
	{

		float currentFrame = glfwGetTime();
		deltaTime = currentFrame - lastFrame;
		lastFrame = currentFrame;

		// Process inputs before anything, this should, at some point, be moved to it's own thread.
		processInput(window);

		// Clear the current image in the buffer, this prevents artifacting with overlays and stuff.
		glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT);
		glClear(GL_DEPTH_BUFFER_BIT);
		glClear(GL_STENCIL_BUFFER_BIT);

		voxelShaders.ReloadShaders(VertexShaderPath, FragmentShaderPath);
		voxelShaders.use();

		// camera/view transformation
		glm::mat4 projection = glm::perspective(glm::radians(camera.Zoom), (float)windowWidth / (float)windowHeight, 0.1f, 100.0f);
		voxelShaders.setMat4("projection", projection);

		glm::mat4 view = camera.GetViewMatrix();
		voxelShaders.setMat4("view", view);

		///////////////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////////////

		vox.Render();

		//glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
		//glDrawArrays(GL_TRIANGLES, 0, 6);


		///////////////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////////////

		// Put the image we drew on to the window.
		glfwSwapBuffers(window);

		// Process events (I/O)
		glfwPollEvents();
	}
}

void Renderer::processInput(GLFWwindow *window)
{
	// Close
	if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
	{
		glfwSetWindowShouldClose(window, true);
	}

	// Debug
	if (glfwGetKey(window, GLFW_KEY_F3) == GLFW_PRESS)
	{
		glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	}
	if (glfwGetKey(window, GLFW_KEY_F4) == GLFW_PRESS)
	{
		glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	}

	// Camera
	if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS)
	{
		camera.ProcessKeyboard('f', deltaTime);
	}
	if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS)
	{
		camera.ProcessKeyboard('b', deltaTime);
	}
	if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS)
	{
		camera.ProcessKeyboard('l', deltaTime);
	}
	if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS)
	{
		camera.ProcessKeyboard('r', deltaTime);
	}
}

void Renderer::mouse_callback(GLFWwindow* window, double xpos, double ypos)
{
	// TODO: Fix mouse

	//if (firstMouse)
	//{
	//	lastX = xpos;
	//	lastY = ypos;
	//	firstMouse = false;
	//}

	//float xoffset = xpos - lastX;
	//float yoffset = lastY - ypos; // reversed since y-coordinates go from bottom to top

	//lastX = xpos;
	//lastY = ypos;

	//camera.ProcessMouseMovement(xpos, ypos);
}

void Renderer::framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
	glViewport(0, 0, width, height);
	windowWidth = width;
	windowHeight = height;
}
