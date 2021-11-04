using Sandbox;
using System.Collections.Generic;

namespace actionbox.Loadout.Perks
{
	[Library("perk_athletic", Title = "Athletic", Description = "Mr. Bolt", Group = "perks")]
	class Athletic : ILoadoutPerk
	{
		private static LoadoutItemData itemData;
		[Event("actionbox.RegisterLoadoutItems")]
		static void RegisterLoadoutItem()
		{
			itemData = new LoadoutItemData()
			{
				Cost = 4,
				Tags = new List<string>() { "perk_athletic" },
				BlockTags = new List<string>() { "perk_strong" },
				ImagePath = "ui/perks/placeholderPerk.png"

			};
			PerkDataStore.Register<Athletic>(itemData);
		}

		LoadoutItemData ILoadoutItem.ItemData { get => itemData; }

        void ILoadoutItem.ApplyPlayerEffects(ActionboxPlayer player)
		{
			//TODO: Make player movement more modular.
			Log.Info("Player has ATHLETIC.");
		}

		void ILoadoutItem.ApplyLoadoutEffects(PlayerLoadout loudout)
		{
		}
	}
}
