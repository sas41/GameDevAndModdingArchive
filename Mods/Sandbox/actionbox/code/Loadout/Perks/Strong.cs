using Sandbox;
using System.Collections.Generic;

namespace actionbox.Loadout.Perks
{

	[Library("perk_strong", Title = "Strong", Description = "Big Muskles", Group = "perks")]
	class Strong : ILoadoutPerk
	{
		private static LoadoutItemData itemData;
		[Event("actionbox.RegisterLoadoutItems")]
		static void RegisterLoadoutItem()
		{
			itemData = new LoadoutItemData()
			{
				Cost = 4,
				Tags = new List<string>() { "perk_strong" },
				BlockTags = new List<string>() { "perk_athletic" },
				ImagePath = "ui/perks/placeholderPerk.png"

		};
			PerkDataStore.Register<Strong>(itemData);
		}

		LoadoutItemData ILoadoutItem.ItemData { get => itemData; }

		void ILoadoutItem.ApplyPlayerEffects(ActionboxPlayer player)
		{
			//TODO: Make player movement more modular.
			Log.Info("Player has STRONG.");
		}

		void ILoadoutItem.ApplyLoadoutEffects(PlayerLoadout loudout)
		{
		}
	}
}
