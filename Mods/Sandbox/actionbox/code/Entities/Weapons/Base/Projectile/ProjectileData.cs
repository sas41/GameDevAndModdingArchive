using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace actionbox.Entities.Weapons
{
	public class ProjectileData
	{
		public virtual string ModelPath => "weapons/shells/pistol_shell.vmdl";
		public virtual int MaxSurfacesPenetrated => 0;
		public virtual float EffectiveRange => 500;
		public virtual float MaxRange => 1000;
		public virtual float MuzzleVelocity => 400; //In meters per second
		public virtual float MaxDamage => 30;
		public virtual float HeadshotMultiplier => 1.50f;

		public virtual float Size => 1f;

		public virtual Dictionary<string, float> SurfaceEnergyLossTable => new Dictionary<string, float>()
		{
			{ "default", 0.1f },
			{ "concrete", 0.1f },

			{ "dirt", 1.0f },
			{ "mud", 1.0f },
			{ "sand", 1.0f },

			{ "metal", 0.05f },
			{ "metal.sheet", 0.05f },
			{ "metal.weapon", 0.05f },

			{ "wood", 0.025f },
			{ "wood.sheet", 0.025f },

			{ "plastic", 0.025f },
			{ "plastic.sheet", 0.025f },
			{ "plastic.sheet.watercontainer", 0.025f },

			{ "glass", 0.01f },
			{ "rubber", 0.01f },
			{ "water", 0.01f },

			{ "flesh", 0.01f },
			{ "watermelon", 0.01f },
		};
	}
}
