using System;

namespace actionbox.Entities.Weapons
{
	public enum AmmoType
	{
		Pistol = 0,
		SMG = 1,
		Shotgun = 2,
		Rifle = 3,
		Sniper = 4,
		Explosive = 5,
	}

	public class Ammo
	{
		private int[] AmmoCounts { get; set; }
		private int[] AmmoCaps { get; set; }

		public Ammo()
		{
			int ammoTypes = Enum.GetNames(typeof(AmmoType)).Length;
			AmmoCounts = new int[ammoTypes];
			ResetAmmoCounts();

			AmmoCaps = new int[ammoTypes];

			AmmoCaps[(int)AmmoType.Pistol] = 60;
			AmmoCaps[(int)AmmoType.SMG] = 120;
			AmmoCaps[(int)AmmoType.Shotgun] = 30;
			AmmoCaps[(int)AmmoType.Rifle] = 90;
			AmmoCaps[(int)AmmoType.Sniper] = 30;
			AmmoCaps[(int)AmmoType.Explosive] = 3;
		}

		public void ResetAmmoCounts()
		{
			AmmoCounts[(int)AmmoType.Pistol] = 60;
			AmmoCounts[(int)AmmoType.SMG] = 120;
			AmmoCounts[(int)AmmoType.Shotgun] = 30;
			AmmoCounts[(int)AmmoType.Rifle] = 90;
			AmmoCounts[(int)AmmoType.Sniper] = 30;
			AmmoCounts[(int)AmmoType.Explosive] = 3;
		}

		public int GetAmmoCount(AmmoType type)
		{
			return AmmoCounts[(int)type];
		}

		public int RequestAmmo(AmmoType type, int requested)
		{
			int availalbe = GetAmmoCount(type);

			if ( availalbe < requested )
			{
				requested = availalbe;
			}

			AmmoCounts[(int)type] = availalbe - requested;
			return requested;
		}

		public int GiveAmmo(AmmoType type, int amount)
		{
			int availalbe = GetAmmoCount(type);
			int newCount = availalbe + amount;
			AmmoCounts[(int)type] = Math.Min(newCount, AmmoCaps[(int)type]);
			return GetAmmoCount(type);
		}
	}
}
