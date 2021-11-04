using Sandbox;
using Sandbox.UI;
using Sandbox.UI.Construct;

namespace actionbox.UI.Panels
{
	public class AmmoPanel : Panel
	{
		public Label Label;
		public AmmoPanel()
		{
			Add.Label("🔫", "icon");
			Label = Add.Label("∞", "value");
		}

		public override void Tick()
		{
			Entity player = Local.Pawn;
			if (player != null && player is ActionboxPlayer abPlayer && abPlayer.ActiveChild != null)
			{
				Entity active = player.ActiveChild;
				if (active is Entities.Weapons.ActionboxWeapon)
				{
					Entities.Weapons.ActionboxWeapon weapon = (active as Entities.Weapons.ActionboxWeapon);
					int mag = weapon.CurrentMagazine;
					int reserve = (player as ActionboxPlayer).Ammo.GetAmmoCount(weapon.AmmoType);
					Label.Text = $"{mag} / {reserve}";
					return;
				}
			}
			Label.Text = $"∞";
		}
	}
}
