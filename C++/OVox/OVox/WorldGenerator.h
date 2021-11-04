#pragma once
#include <stdlib.h>
#include <string>
#include "Chunk.h"
#include "Common.h"

using namespace vox;

class WorldGenerator
{
public:

	std::string seed;

	WorldGenerator();
	~WorldGenerator();

	vox::Chunk GenerateChunk(coord x, coord y);

};

