#include "Chunk.h"

using vox::Chunk;

std::shared_ptr<Chunk> Chunk::GenerateFlat()
{
	auto chunk = std::make_shared<Chunk>();

	for (size_t z = 0; z < chunk->data.size(); z++)
	{
		auto& plain = chunk->data[z];

		for (size_t y = 0; y < plain.size(); y++)
		{
			auto& row = plain[y];

			for (size_t x = 0; x < row.size(); x++)
			{
				auto& voxel = row[x];
				
				if (z < SIZE_Z / 2)
				{
					voxel = std::make_unique<Voxel>();
				}
				else
				{
					voxel = std::unique_ptr<Voxel>(nullptr);
				}
			}
		}
	}

	return chunk;
}

Chunk::Chunk(coord x, coord y)
{
	worldX = x;
	worldX = y;
}

Chunk::~Chunk()
{
}
