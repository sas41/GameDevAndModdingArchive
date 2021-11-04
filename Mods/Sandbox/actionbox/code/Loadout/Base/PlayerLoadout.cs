using actionbox.Entities.Weapons;
using System;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sandbox;

namespace actionbox.Loadout
{
	public class PlayerLoadout
	{
		public int LoadoutPoints { get; private set; }
		public Type PrimaryWeapon { get; private set; }
		public Type SecondaryWeapon { get; private set; }
		public List<Type> Perks { get; private set; }
		public int Cost
		{
			get
			{
				int primaryCost = PrimaryWeapon != null ? WeaponDataStore.GetDataOf(PrimaryWeapon).Cost : 0;
				int secondaryCost = SecondaryWeapon != null ? WeaponDataStore.GetDataOf(SecondaryWeapon).Cost : 0;
				int perksCost = Perks.Sum(perk => PerkDataStore.GetDataOf(perk).Cost);
				return primaryCost + secondaryCost + perksCost;
			}
		}

		private List<string> tags;
		public IReadOnlyList<string> Tags
		{
			get
			{
				return tags.AsReadOnly();
			}
		}

		private List<string> blockTags;
		public IReadOnlyList<string> BlockTags
		{
			get
			{
				return blockTags.AsReadOnly();
			}
		}


		public PlayerLoadout(int lp = 20)
		{
			LoadoutPoints = lp;
			PrimaryWeapon = null;
			SecondaryWeapon = null;
			Perks = new List<Type>();
			tags = new List<string>();
			blockTags = new List<string>();
		}

		public void ApplyLoadout(ActionboxPlayer player)
		{
			if ( player == null )
			{
				return;
			}

			foreach ( var perk in Perks )
			{
				var instance = Library.Create<ILoadoutPerk>(perk);
				instance.ApplyPlayerEffects(player);
			}

			if ( PrimaryWeapon != null )
			{
				var instance = Library.Create<ILoadoutWeapon>(PrimaryWeapon);
				instance.ApplyPlayerEffects(player);
			}

			if ( SecondaryWeapon != null )
			{
				var instance = Library.Create<ILoadoutWeapon>(SecondaryWeapon);
				instance.ApplyPlayerEffects(player);
			}
		}

		public void UpdateTags()
		{
			tags = new List<string>();
			blockTags = new List<string>();

			foreach ( var perk in Perks )
			{
				var data = PerkDataStore.Data[ perk ];
				tags.AddRange(data.Tags);
				blockTags.AddRange(data.BlockTags);
				//perk.ApplyLoadoutEffects(this);
			}

			if ( PrimaryWeapon != null )
			{
				var data = WeaponDataStore.Data[ PrimaryWeapon ];
				tags.AddRange(data.Tags);
				blockTags.AddRange(data.BlockTags);
				//PrimaryWeapon.ApplyLoadoutEffects(this);
			}

			if ( SecondaryWeapon != null )
			{
				var data = WeaponDataStore.Data[ SecondaryWeapon ];
				tags.AddRange(data.Tags);
				blockTags.AddRange(data.BlockTags);
				//SecondaryWeapon.ApplyLoadoutEffects(this);
			}
		}
		
		public bool CanEquip(Type type)
		{
			LoadoutItemData data;
            if (WeaponDataStore.Data.ContainsKey(type))
			{
				data = WeaponDataStore.GetDataOf(type);

				if (data.Tags.Contains("weaponslot_primary"))
				{
					if (PrimaryWeapon != null && WeaponDataStore.GetDataOf(PrimaryWeapon).Cost >= data.Cost)
					{

						Log.Info("[CAN-EQUIP] Replace Primary.");
						return true;
					}
				}
				else if (data.Tags.Contains("weaponslot_secondary"))
				{
					if (SecondaryWeapon != null && WeaponDataStore.GetDataOf(SecondaryWeapon).Cost >= data.Cost)
					{
						Log.Info("[CAN-EQUIP] Replace Secondary.");
						return true;
					}
				}
				return HaveEnoughPoints(data.Cost);
			}
            else if (PerkDataStore.Data.ContainsKey(type))
			{
				data = PerkDataStore.GetDataOf(type);
				bool perkEquiped = Perks.Contains(type);
				if (perkEquiped)
				{
					Log.Info("[CAN-EQUIP] Perk already equipped.");
					return false;
				}
				return HaveEnoughPoints(data.Cost);
			}
			else
            {
				return false;
            }
		}

		public bool HaveEnoughPoints(int cost)
		{
			return Cost + cost <= LoadoutPoints;
		}

		public bool Equip(Type type)
		{
			if ( !CanEquip(type) )
			{
				return false;
			}

			UnequipConflictingItems(type);

			if (PerkDataStore.Data.ContainsKey(type))
			{
				Perks.Add(type);
			}
			else if (WeaponDataStore.Data.ContainsKey(type))
			{
				LoadoutItemData data = WeaponDataStore.GetDataOf(type);
				bool primaryNull = PrimaryWeapon == null;
				bool secondaryNull = SecondaryWeapon == null;

				if (data.Tags.Contains("weaponslot_primary") )
				{
					if ( !primaryNull && secondaryNull && data.Tags.Contains("weaponslot_secondary") )
					{
						SecondaryWeapon = PrimaryWeapon;
						Log.Info("[EQUPPING] Primary Pushed Secondary to new Slot.");
					}
					PrimaryWeapon = type;
					Log.Info("[EQUPPING] Primary Equipped.");
				}
				else
				{
					if ( !secondaryNull && primaryNull && HaveEnoughPoints(data.Cost) )
					{
						PrimaryWeapon = type;
						Log.Info("[EQUPPING] Secondary was full, equipped to Primary Slot.");
					}
					else
					{
						SecondaryWeapon = type;
						Log.Info("[EQUPPING] Secondary Equipped.");
					}
				}
			}

			UpdateTags();
			return true;
		}

		public bool Unequip(Type type)
		{
			if ( Perks.Contains(type) )
			{
				Perks.Remove(type);
			}
			else if (PrimaryWeapon == type || SecondaryWeapon == type)
			{
				if ( PrimaryWeapon == type)
				{
					PrimaryWeapon = null;
				}
				else if (SecondaryWeapon == type)
				{
					SecondaryWeapon = null;
				}
			}
            else
            {
				return false;
            }

			UpdateTags();
			return true;
		}

		private void UnequipConflictingItems(Type type)
		{
			LoadoutItemData newItemData;
            if (WeaponDataStore.Data.ContainsKey(type))
            {
				newItemData = WeaponDataStore.GetDataOf(type);
			}
			else if (PerkDataStore.Data.ContainsKey(type))
			{
				newItemData = PerkDataStore.GetDataOf(type);
			}
            else
            {
				return;
            }

			List<Type> perksToRemove = new List<Type>();


			// Check if new item blocks old items
			foreach ( var perk in Perks )
			{
				LoadoutItemData perkdata = PerkDataStore.GetDataOf(perk);

				if (perkdata.Tags.Any(tag => newItemData.BlockTags.Contains(tag)) )
				{
					perksToRemove.Add(perk);
					Log.Info($"[NEW BLOCK RULE] Unequpping {perk}");
				}

				if (newItemData.Tags.Any(tag => perkdata.BlockTags.Contains(tag)))
				{
					perksToRemove.Add(perk);
					Log.Info($"[OLD BLOCK RULE] Unequpping {perk}");
				}
			}

			if (PrimaryWeapon != null)
			{
				LoadoutItemData primary = WeaponDataStore.GetDataOf(PrimaryWeapon);
				if (primary.Tags.Any(tag => newItemData.BlockTags.Contains(tag)))
				{
					PrimaryWeapon = null;
					Log.Info($"[NEW BLOCK RULE] Unequpping {PrimaryWeapon}");
				}

				if (newItemData.Tags.Any(tag => primary.BlockTags.Contains(tag)))
				{
					PrimaryWeapon = null;
					Log.Info($"[OLD BLOCK RULE] Unequpping {PrimaryWeapon}");
				}
			}

			if (SecondaryWeapon != null)
			{
				LoadoutItemData secondary = WeaponDataStore.GetDataOf(SecondaryWeapon);
				if (secondary.Tags.Any(tag => newItemData.BlockTags.Contains(tag)))
				{
					SecondaryWeapon = null;
					Log.Info($"[NEW BLOCK RULE] Unequpping {SecondaryWeapon}");
				}

				if (newItemData.Tags.Any(tag => secondary.BlockTags.Contains(tag)))
				{
					SecondaryWeapon = null;
					Log.Info($"[OLD BLOCK RULE] Unequpping {SecondaryWeapon}");
				}
			}

			Perks = Perks.Except(perksToRemove.Distinct()).Distinct().ToList();

			UpdateTags();
		}

		public void Clear()
        {
            //if (PrimaryWeapon is Entity pw)
            //{
            //    pw.Delete();
            //}

            //if (SecondaryWeapon is Entity sw)
            //{
            //    sw.Delete();
            //}

            //foreach (var perk in Perks)
            //{
            //    if (SecondaryWeapon is Entity p)
            //    {
            //        p.Delete();
            //    }
            //}

            SecondaryWeapon = null;
            PrimaryWeapon = null;
            Perks = new List<Type>();
        }

	}
}
