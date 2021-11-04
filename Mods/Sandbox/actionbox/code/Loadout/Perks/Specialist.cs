using Sandbox;
using System.Collections.Generic;

namespace actionbox.Loadout.Perks
{
	[Library("perk_specialist", Title = "Specialist", Description = "007", Group = "perks")]
	class Specialist : ILoadoutPerk
	{
		private static LoadoutItemData itemData;
		[Event("actionbox.RegisterLoadoutItems")]
		static void RegisterLoadoutItem()
		{
			itemData = new LoadoutItemData()
			{
				Cost = 4,
				Tags = new List<string>() { "perk_specialist" },
				BlockTags = new List<string>() { "weaponslot_primary" },
				ImagePath = "ui/perks/placeholderPerk.png"

			};
			PerkDataStore.Register<Specialist>(itemData);
		}

		LoadoutItemData ILoadoutItem.ItemData { get => itemData; }

		void ILoadoutItem.ApplyPlayerEffects(ActionboxPlayer player)
		{
			//TODO: Make player movement more modular.
			Log.Info("Player has SPECIALIST.");
		}

		void ILoadoutItem.ApplyLoadoutEffects(PlayerLoadout loudout)
		{
		}
	}
}
