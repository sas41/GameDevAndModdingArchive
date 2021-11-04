#pragma once
#include <vector>
#include "Chunk.h"
#include "Common.h"

namespace vox {

	class World
	{
	private:
		std::vector<std::vector<Chunk>> WorldMatrix;

	public:
		World();
		~World();
		Chunk GetChunk(coord x, coord y, unsigned int size);
	};

}

