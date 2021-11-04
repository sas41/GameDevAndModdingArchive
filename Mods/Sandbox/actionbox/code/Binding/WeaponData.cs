using Sandbox;

namespace actionbox.Binding
{
	[Library("actionbox_weapon.asset")]
	class WeaponData
	{
		// Data from config/actionbox_weapon.asset
		public string Name { get; set; } = "Weapon Name";
		public string Description { get; set; } = "Default Actionbox Weapon.";
		public float Damage { get; set; } = 5.0f;
	}
}
