#include "World.h"

using vox::World;

World::World()
{
}


World::~World()
{
}

vox::Chunk vox::World::GetChunk(coord x, coord y, unsigned int size)
{
	return WorldMatrix[x][y];
}
