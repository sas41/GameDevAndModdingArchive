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
    class WeaponDisplayPanel : Panel
    {
        private Type weapon;
        readonly Image image;

        public WeaponDisplayPanel()
        {
            image = this.AddChild<Image>("image");
            image.SetTexture("ui/weapons/none.png");
        }

        public void UpdateWeapon(Type type)
        {
            weapon = type;
            if (weapon == null)
            {
                image.SetTexture("ui/weapons/none.png");
            }
            else if (WeaponDataStore.Data.ContainsKey(weapon))
            {
                image.SetTexture(WeaponDataStore.GetDataOf(weapon).ImagePath);
            }
            else
            {
                image.SetTexture("/ui/weapons/placeholderWeapon.png");
            }
        }
    }
}
