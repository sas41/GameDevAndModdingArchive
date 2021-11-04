#include "ChunkLoader.h"

using vox::Chunk;
using vox::ChunkLoader;
using vox::coord;

ChunkLoader::ChunkLoader(const std::string& filename)
	: input{ filename, std::ifstream::in }
{
}

std::shared_ptr<Chunk> ChunkLoader::LoadChunk(coord x, coord y, coord z)
{
	return vox::Chunk::GenerateFlat();
}

ChunkLoader::~ChunkLoader()
{
}
