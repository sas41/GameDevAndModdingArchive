using System.Collections.Generic;
using actionbox.Loadout;
using Sandbox;

namespace actionbox.Entities.Weapons
{
	[Library("weapon_basicsmg", Title = "Basic SMG", Description = "Basic SMG for Testing", Group = "weapons_primary")]
	partial class BasicSMG : ILoadoutWeapon
	{
		private static LoadoutItemData itemData;

		[Event("actionbox.RegisterLoadoutItems")]
		static void RegisterLoadoutItem()
		{
			itemData = new LoadoutItemData()
			{
				Cost = 4,
				Tags = new List<string>() { "weaponslot_primary", "weapontype_smg", "weapon_basicsmg" },
				BlockTags = new List<string>() { },
				ImagePath = "ui/weapons/basicSMG.png"

		};
			WeaponDataStore.Register<BasicSMG>(itemData);
		}

		LoadoutItemData ILoadoutItem.ItemData { get => itemData; }

		void ILoadoutItem.ApplyPlayerEffects(ActionboxPlayer player)
		{
			player.Inventory.Add(this, true);
		}

		void ILoadoutItem.ApplyLoadoutEffects(PlayerLoadout loudout)
		{
		}
	}
}
