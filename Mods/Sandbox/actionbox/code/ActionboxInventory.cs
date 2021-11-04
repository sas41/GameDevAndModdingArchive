using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sandbox;

namespace actionbox
{
	public partial class ActionboxInventory : BaseInventory
	{
		public ActionboxInventory(Player player) : base(player)
		{

		}

		//public override bool Add(Entity ent, bool makeActive = false)
		//{
		//	var player = Owner as ActionboxPlayer;
		//	var weapon = ent as Entities.Weapons.ActionboxWeapon;
		//	//var notices = !player.SupressPickupNotices;
		//	//
		//	// We don't want to pick up the same weapon twice
		//	// But we'll take the ammo from it Winky Face
		//	//
		//	if ( weapon != null && IsCarryingType(ent.GetType()) )
		//	{
		//		var ammo = weapon.AmmoClip;
		//		var ammoType = weapon.AmmoType;

		//		if ( ammo > 0 )
		//		{
		//			player.GiveAmmo(ammoType, ammo);

		//			if ( notices )
		//			{
		//				Sound.FromWorld("dm.pickup_ammo", ent.Position);
		//				PickupFeed.OnPickup(To.Single(player), $"+{ammo} {ammoType}");
		//			}
		//		}

		//		ItemRespawn.Taken(ent);

		//		// Despawn it
		//		ent.Delete();
		//		return false;
		//	}

		//	if ( weapon != null && notices )
		//	{
		//		Sound.FromWorld("dm.pickup_weapon", ent.Position);
		//		PickupFeed.OnPickup(To.Single(player), $"{ent.ClassInfo.Title}");
		//	}


		//	ItemRespawn.Taken(ent);
		//	return base.Add(ent, makeActive);
		//}

		public bool IsCarryingType(Type t)
		{
			return List.Any(x => x.GetType() == t);
		}

	}
}
