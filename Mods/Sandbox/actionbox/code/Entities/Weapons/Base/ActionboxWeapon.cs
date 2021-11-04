using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sandbox;
using Sandbox.UI;

namespace actionbox.Entities.Weapons
{
	public partial class ActionboxWeapon : BaseCarriable//, IRespawnableEntity
	{
		public virtual int Bucket => 1;
		public virtual int BucketWeight => 100;
		public PickupTrigger PickupTrigger { get; protected set; }

		// Weapon Model
		public override string ViewModelPath => "weapons/rust_pistol/v_rust_pistol.vmdl";
		public virtual string WorldModelPath => "weapons/rust_pistol/rust_pistol.vmdl";

		// Weapon Stats
		public virtual float FireRate			=> 1.0f; // In Rounds Per SECOND
		public virtual float AltFireCooldown	=> 1.00f;
		public virtual float ReloadTime			=> 1.00f;
		public virtual int MagazineCapacity		=> 1;
		public virtual int AmmoPerShot			=> 1;
		public virtual AmmoType AmmoType		=> AmmoType.Pistol;
		public virtual bool FullAuto			=> false;
		private bool TriggerReleased			= true;

		// Projectile Stats
		public ProjectileData ProjectileData;

		// Timers and State management
		[Net, Predicted]
		public TimeSince TimeSincePrimaryFire { get; set; }
		[Net, Predicted]
		public TimeSince TimeSinceAltFire { get; set; }
		[Net, Predicted]
		public TimeSince TimeSinceReload { get; set; }
		[Net, Predicted]
		public TimeSince TimeSinceDeployed { get; set; }
		[Net, Predicted]
		public int CurrentMagazine { get; set; }
		[Net, Predicted]
		public bool IsReloading { get; set; }



		// Spawning the weapon and setting up triggers...
		public ActionboxWeapon() : base()
		{
			ProjectileData = new ProjectileData();
		}

		public override void Simulate(Client owner)
		{
			if ( TimeSinceDeployed < 0.6f )
			{
				return;
			}

			if ( !IsReloading )
			{
				if ( CanReload() )
				{
					Reload();
				}

				//
				// Reload could have changed our owner
				//
				if ( !Owner.IsValid() )
					return;

				if ( CanPrimaryAttack() )
				{
					TimeSincePrimaryFire = 0;
					PrimaryAttack();
				}

				//
				// AttackPrimary could have changed our owner
				//
				if ( !Owner.IsValid() )
					return;

				if ( CanSecondaryAttack() )
				{
					TimeSinceAltFire = 0;
					AttackSecondary();
				}
			}

			if ( IsReloading && TimeSinceReload > ReloadTime )
			{
				OnReloadFinish();
			}
		}

		public override void ActiveStart(Entity ent)
		{
			base.ActiveStart(ent);

			TimeSinceDeployed = 0;

			IsReloading = false;
		}

		public override void Spawn()
		{
			base.Spawn();

			CollisionGroup = CollisionGroup.Weapon;
			SetInteractsAs(CollisionLayer.Debris);

			PickupTrigger = new PickupTrigger();
			PickupTrigger.Parent = this;
			PickupTrigger.Position = Position;

			SetModel(WorldModelPath);
			CurrentMagazine = MagazineCapacity;
		}

		public override void CreateViewModel()
		{
			Host.AssertClient();

			if ( string.IsNullOrEmpty(ViewModelPath) )
			{
				return;
			}

			ViewModelEntity = new WeaponViewModel();
			ViewModelEntity.Position = Position;
			ViewModelEntity.Owner = Owner;
			ViewModelEntity.EnableViewmodelRendering = true;
			ViewModelEntity.SetModel(ViewModelPath);
		}

		public override void CreateHudElements()
		{
			if ( Local.Hud == null ) return;

			CrosshairPanel = new UI.Panels.Crosshair();
			CrosshairPanel.Parent = Local.Hud;
			CrosshairPanel.AddClass(ClassInfo.Name);
		}
		
		public override void OnCarryStart(Entity carrier)
		{
			base.OnCarryStart(carrier);

			if ( PickupTrigger.IsValid() )
			{
				PickupTrigger.EnableTouch = false;
			}
		}

		public override void OnCarryDrop(Entity dropper)
		{
			base.OnCarryDrop(dropper);

			if ( PickupTrigger.IsValid() )
			{
				PickupTrigger.EnableTouch = true;
			}
		}


		//------------------------------------//
		// Weapon's Operation and Function... //
		//------------------------------------//
		public int GetAmmoReserve()
		{
			if ( Owner is ActionboxPlayer )
			{
				return (Owner as ActionboxPlayer).Ammo.GetAmmoCount(this.AmmoType);
			}
			else
			{
				return 0;
			}
		}

		public virtual bool CanReload()
		{
			return Owner.IsValid() && Input.Down(InputButton.Reload);
		}

		public virtual void Reload()
		{
			if (IsReloading)
			{
				return;
			}

			if (CurrentMagazine >= MagazineCapacity )
			{
				return;
			}

			if (GetAmmoReserve() <= 0)
			{
				return;
			}

			IsReloading = true;
			TimeSinceReload = 0;

			(Owner as AnimEntity).SetAnimBool("b_reload", true);

			StartReloadEffects();
		}

		[ClientRpc]
		public virtual void StartReloadEffects()
		{
			ViewModelEntity?.SetAnimBool("reload", true);
		}

		public virtual void OnReloadFinish()
		{
			if ( Owner is ActionboxPlayer player )
			{
				int missingBullets = MagazineCapacity - CurrentMagazine;
				int availableBullets = player.Ammo.RequestAmmo(AmmoType, missingBullets);
				CurrentMagazine += availableBullets;
			}
			IsReloading = false;
		}

		public virtual bool CanPrimaryAttack()
		{
			if ( Owner.IsValid() == false )
			{
				return false;
			}
			else if ( Input.Down(InputButton.Attack1) == false )
			{
				TriggerReleased = true;
				return false;
			}
			else if ( FullAuto == false && TriggerReleased == false )
			{
				return false;
			}
			else if (FireRate == 0 || TimeSincePrimaryFire > (1 / FireRate) )
			{
				TriggerReleased = false;
				return true;
			}
			else
			{
				return false;
			}

		}

		public virtual void PrimaryAttack()
		{
			TimeSincePrimaryFire = 0;
			TimeSinceAltFire = 0;

			if ( !ConsumeAmmo(AmmoPerShot) )
			{
				DryFire();
				return;
			}

			ShootEffects();

			if ( IsServer )
			{
				using ( Prediction.Off() )
				{
					var projectile = new RealisticProjectile();
					projectile.Owner = Owner;
					projectile.Position = Owner.EyePos + (Owner.EyeRot.Forward * 25f);
					projectile.Rotation = Owner.EyeRot;
					projectile.ProjectileData = ProjectileData;
					projectile.SetModel(ProjectileData.ModelPath);
					projectile.Velocity = Owner.EyeRot.Forward * ProjectileData.MuzzleVelocity * 39.37f; // 39.37 SU = ~1 m;
				}
			}
		}

		public virtual bool CanSecondaryAttack()
		{
			if ( !Owner.IsValid() || !Input.Down(InputButton.Attack2) )
			{
				return false;
			}

			if ( AltFireCooldown <= 0 )
			{
				return true;
			}

			return TimeSinceAltFire > (1 / AltFireCooldown);
		}

		public virtual void AttackSecondary()
		{

		}

		[ClientRpc]
		protected virtual void ShootEffects()
		{
			Host.AssertClient();

			Particles.Create("particles/pistol_muzzleflash.vpcf", EffectEntity, "muzzle");

			if ( IsLocalPawn )
			{
				new Sandbox.ScreenShake.Perlin();
			}

			ViewModelEntity?.SetAnimBool("fire", true);
			CrosshairPanel?.CreateEvent("fire");
		}

		public bool ConsumeAmmo(int amount)
		{
			if ( CurrentMagazine < amount )
			{
				return false;
			}

			CurrentMagazine -= amount;
			return true;
		}

		[ClientRpc]
		public virtual void DryFire()
		{
			// CLICK
		}

		public bool IsUsable()
		{
			if ( CurrentMagazine > 0 )
			{
				return true;
			}
			return GetAmmoReserve() > 0;
		}

		public virtual IEnumerable<TraceResult> TraceBullet(Vector3 start, Vector3 end, float radius = 2.0f)
		{
			bool InWater = Physics.TestPointContents(start, CollisionLayer.Water);

			var tr = Trace.Ray(start, end)
					.UseHitboxes()
					.HitLayer(CollisionLayer.Water, !InWater)
					.Ignore(Owner)
					.Ignore(this)
					.Size(radius)
					.Run();

			yield return tr;

			//
			// Another trace, bullet going through thin material, penetrating water surface?
			//
		}
	}
}
