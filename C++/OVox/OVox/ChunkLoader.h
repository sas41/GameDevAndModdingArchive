#pragma once

#include <string>
#include <iostream>
#include <fstream>
#include <memory>

#include "Common.h"
#include "Chunk.h"

namespace vox {

class ChunkLoader
{
private:
	std::ifstream input;

public:
	ChunkLoader(const std::string& filename);

	std::shared_ptr<Chunk> LoadChunk(coord x, coord y, coord z);

	virtual ~ChunkLoader();
};

}
