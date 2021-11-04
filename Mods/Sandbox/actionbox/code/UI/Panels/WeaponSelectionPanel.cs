using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sandbox;
using Sandbox.UI;
using Sandbox.UI.Construct;
using actionbox.Loadout;

namespace actionbox.UI.Panels
{
	class UIWeaponEquippedArgs
	{
		public string Tag { get; set; }
		public Type Weapon { get; set; }
	}

	class WeaponSelectionPanel : Panel
    {
		public static WeaponSelectionPanel Instance;
		readonly Panel weapons;

		public WeaponSelectionPanel()
		{
			StyleSheet.Load("/UI/Panels/WeaponSelectionPanel.scss");
			this.SetTemplate("UI/Panels/WeaponSelectionPanel.html");
			Instance = this;
			weapons = this.AddChild<Panel>("weapons");
		}

		public void ShowPanel(PlayerLoadout loadout, string tag)
		{
			weapons.DeleteChildren(true);

            foreach (var kvp in WeaponDataStore.Data.Where(pair => pair.Value.Tags.Contains(tag)))
			{
				var image = weapons.AddChild<WeaponDisplayPanel>("image");
				image.UpdateWeapon(kvp.Key);
				bool canEquip = loadout.CanEquip(kvp.Key);

				if (canEquip)
				{
					image.AddEventListener("onclick", () =>
					{
						OnConfigUpdated(tag, kvp.Key);
					});
				}
                else
				{
					image.SetClass("disable", true);
				}
			}
		}


		public delegate void UIWeaponEquippedEventHandler(object sender, UIWeaponEquippedArgs e);
		public event UIWeaponEquippedEventHandler UIWeaponEquipped;
		protected virtual void OnConfigUpdated(string tag, Type weapon)
		{
			if (UIWeaponEquipped != null)
			{
				UIWeaponEquipped(this, new UIWeaponEquippedArgs() { Tag = tag, Weapon = weapon });
			}
		}
	}
}
