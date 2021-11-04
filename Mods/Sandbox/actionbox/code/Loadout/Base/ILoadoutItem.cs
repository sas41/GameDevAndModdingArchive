using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace actionbox.Loadout
{
	public record LoadoutItemData
	{
		public int Cost { get; init; }

		public List<string> Tags { get; init; }

		public List<string> BlockTags { get; init; }

		public string ImagePath { get; init; }
	}

	public interface ILoadoutItem
	{
        public LoadoutItemData ItemData { get; }
		void ApplyPlayerEffects(ActionboxPlayer player);
		void ApplyLoadoutEffects(PlayerLoadout loudout);
	}
}
