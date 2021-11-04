using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using actionbox.Loadout;
using actionbox.UI.Panels;
using Sandbox;
using Sandbox.UI;
using Sandbox.UI.Construct;

namespace actionbox.UI
{
	[Library]
	public partial class LoadoutScreen : Panel
	{
		public static LoadoutScreen Instance;
		private bool active;

		private WeaponDisplayPanel primary;
		private WeaponDisplayPanel secondary;

		private PlayerLoadout currentLoadout;

		private WeaponSelectionPanel weaponSelection;

		public LoadoutScreen()
		{
			Instance = this;
			active = false;
			StyleSheet.Load("/UI/LoadoutScreen.scss");
			this.SetTemplate("UI/LoadoutScreen.html");
			currentLoadout = new PlayerLoadout();

			weaponSelection = this.AddChild<WeaponSelectionPanel>("hidden");
			weaponSelection.UIWeaponEquipped += OnUIWeaponEquipped;

			primary = this.Descendants.Where(child => child.Class.Contains("primary")).First() as WeaponDisplayPanel;
			secondary = this.Descendants.Where(child => child.Class.Contains("secondary")).First() as WeaponDisplayPanel;

			primary.AddEventListener("onclick", () =>
			{
				weaponSelection.SetClass("hidden", false);
				weaponSelection.ShowPanel(currentLoadout, "weaponslot_primary");
				// TODO: Implement audio cues.
			});

			secondary.AddEventListener("onclick", () =>
			{
				weaponSelection.SetClass("hidden", false);
				weaponSelection.ShowPanel(currentLoadout, "weaponslot_secondary");
				// TODO: Implement audio cues.
			});
		}

		public override void Tick()
		{
			base.Tick();
            if (Input.Pressed(InputButton.Menu))
            {
				active = !active;

			}
			this.SetClass("visible", active);
			Parent.SetClass("hidehud", active);
		}

		public void LoadLoadout(PlayerLoadout loadout)
        {
			currentLoadout = loadout;
			primary.UpdateWeapon(currentLoadout.PrimaryWeapon);
			secondary.UpdateWeapon(currentLoadout.SecondaryWeapon);
		}

		private void OnUIWeaponEquipped(object source, UIWeaponEquippedArgs e)
		{
			weaponSelection.SetClass("hidden", true);
			if (e.Tag == "weaponslot_primary")
            {
				primary.UpdateWeapon(e.Weapon);
			}
            else if (e.Tag == "weaponslot_secondary")
			{
				secondary.UpdateWeapon(e.Weapon);
			}
		}
	}
}
