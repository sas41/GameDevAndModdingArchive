using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace actionbox.Entities.Weapons
{
	class BasicSMGBullet : ProjectileData
	{
		public override float MuzzleVelocity => 600; //In meters per second
		public override float MaxDamage => 25;
		public override float HeadshotMultiplier => 1.25f;
	}
}
