using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sandbox;

namespace actionbox.Entities.Weapons
{
	partial class BasicPistol : ActionboxWeapon
	{
		public override string ViewModelPath => "weapons/rust_pistol/v_rust_pistol.vmdl";
		public override string WorldModelPath => "weapons/rust_pistol/rust_pistol.vmdl";

		public override float FireRate => 5f;
		public override int MagazineCapacity => 18;

		public BasicPistol()
		{
			ProjectileData = new BasicPistolBullet();
		}

		[Net]
		public bool Zoomed { get; set; }


		public override void Simulate(Client cl)
		{
			base.Simulate(cl);

			Zoomed = Input.Down(InputButton.Attack2);
		}

		public override void PostCameraSetup(ref CameraSetup camSetup)
		{
			base.PostCameraSetup(ref camSetup);

			if ( Zoomed )
			{
				camSetup.FieldOfView = 20;
			}
		}

		public override void BuildInput(InputBuilder owner)
		{
			if ( Zoomed )
			{
				owner.ViewAngles = Angles.Lerp(owner.OriginalViewAngles, owner.ViewAngles, 0.2f);
			}
		}

		[ClientRpc]
		protected override void ShootEffects()
		{
			Host.AssertClient();

			if ( Owner == Local.Pawn )
			{
				new Sandbox.ScreenShake.Perlin(0.5f, 4.0f, 1.0f, 0.5f);
			}

			ViewModelEntity?.SetAnimBool("fire", true);
			CrosshairPanel?.CreateEvent("fire");
		}
	}
}
