using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sandbox;

namespace actionbox.Entities.Weapons
{
	partial class BasicSMG : ActionboxWeapon
	{
		public override int Bucket => 2;
		public override int BucketWeight => 100;
		public override string ViewModelPath => "weapons/rust_smg/v_rust_smg.vmdl";
		public override string WorldModelPath => "weapons/rust_smg/rust_smg.vmdl";
		public override float FireRate => 7f;
		public override int MagazineCapacity => 30;
		public override AmmoType AmmoType => AmmoType.SMG;
		public override bool FullAuto => true;


		public BasicSMG()
		{
			ProjectileData = new BasicSMGBullet();
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
