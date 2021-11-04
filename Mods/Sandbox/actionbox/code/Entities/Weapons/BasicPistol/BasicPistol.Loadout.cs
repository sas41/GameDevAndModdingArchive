using System.Collections.Generic;
using actionbox.Loadout;
using Sandbox;

namespace actionbox.Entities.Weapons
{
	[Library("weapon_basicpistol", Title = "Basic Pistol", Description = "Basic Pistol for Testing", Group = "weapons_secondary")]
	public partial class BasicPistol : ActionboxWeapon, ILoadoutWeapon
    {
        private static LoadoutItemData itemData;
        [Event("actionbox.RegisterLoadoutItems")]
        static void RegisterLoadoutItem()
        {
            itemData = new LoadoutItemData()
            {
                Cost = 2,
                Tags = new List<string>() { "weaponslot_secondary", "weapontype_pistol", "weapon_basicpistol" },
                BlockTags = new List<string>() { },
                ImagePath = "ui/weapons/basicPistol.png"

        };
            WeaponDataStore.Register<BasicPistol>(itemData);
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
