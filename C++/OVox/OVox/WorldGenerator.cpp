#include "WorldGenerator.h"



WorldGenerator::WorldGenerator()
{
}


WorldGenerator::~WorldGenerator()
{
}

vox::Chunk WorldGenerator::GenerateChunk(coord x, coord y)
{
	return Chunk(x, y);
}
