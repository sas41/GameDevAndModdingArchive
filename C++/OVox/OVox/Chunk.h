#pragma once

#include <array>
#include <memory>

#include "Voxel.h"
#include "Common.h"

namespace vox {

class Chunk
{
public:
	static const size_t SIZE_X = 64;
	static const size_t SIZE_Y = 64;
	static const size_t SIZE_Z = 1024;

	coord worldX, worldY;

	static std::shared_ptr<Chunk> GenerateFlat();

	Chunk(coord x, coord y);
	~Chunk();
private:
	std::array<std::array<std::array<std::unique_ptr<Voxel>, SIZE_X>, SIZE_Y>, SIZE_Z> data;
};

}

