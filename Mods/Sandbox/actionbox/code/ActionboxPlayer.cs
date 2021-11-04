using Sandbox;
using actionbox.Loadout;
using actionbox.Entities.Weapons;
using actionbox.Loadout.Perks;

namespace actionbox
{
	public class ActionboxPlayer : Player
	{
		public Ammo Ammo { get; private set; }
		public PlayerLoadout Loadout { get; private set; }

		public ActionboxPlayer() : base()
		{
			Ammo = new Ammo();
			Loadout = new PlayerLoadout();
		}

		public override void Respawn()
		{
			base.Respawn();

			Ammo.ResetAmmoCounts();

			SetModel("models/citizen/citizen.vmdl");

			this.Controller = new WalkController();
			this.Animator = new StandardPlayerAnimator();
			this.Camera = new FirstPersonCamera();

			this.EnableAllCollisions = true;
			this.EnableDrawing = true;
			this.EnableHideInFirstPerson = true;
			this.EnableShadowInFirstPerson = true;

			Inventory = new BaseInventory(this);

            if (Loadout == null)
			{
				Loadout = new PlayerLoadout();
			}
            Log.Info(Loadout.Equip(typeof(BasicPistol)));
            Log.Info(Loadout.Equip(typeof(BasicPistol)));
			Log.Info(Loadout.Equip(typeof(BasicSMG))); ;
			Log.Info(Loadout.Equip(typeof(BasicSMG)));
			Log.Info(Loadout.Equip(typeof(Specialist)));
            Log.Info(Loadout.Equip(typeof(Strong)));
			Log.Info(Loadout.Equip(typeof(Athletic)));
            Log.Info(Loadout.Equip(typeof(Strong)));

            //foreach (var entry in Library.GetAll<ILoadoutWeapon>())
            //{
            //    Loadout.Equip(Library.Create<ILoadoutWeapon>(entry));
            //}

            Loadout.ApplyLoadout(this);
		}

		public override void Simulate(Client cl)
		{
			base.Simulate(cl);

			if ( Input.ActiveChild != null )
			{
				ActiveChild = Input.ActiveChild;
			}

			if ( LifeState != LifeState.Alive )
			{
				return;
			}

			TickPlayerUse();

			if ( Input.Pressed(InputButton.Drop) )
			{
				var dropped = Inventory.DropActive();
				if ( dropped != null )
				{
					if ( dropped.PhysicsGroup != null )
					{
						dropped.PhysicsGroup.Velocity = Velocity + (EyeRot.Forward + EyeRot.Up) * 300;
					}

					//timeSinceDropped = 0;
					//SwitchToBestWeapon();
				}
			}

			SimulateActiveChild(cl, ActiveChild);

		}

		public override void OnKilled()
		{
			base.OnKilled();

			EnableDrawing = false;
		}

		public override void StartTouch(Entity other)
		{
			base.StartTouch(other);
			Log.Info(this.Velocity.Length);
		}


	}
}
