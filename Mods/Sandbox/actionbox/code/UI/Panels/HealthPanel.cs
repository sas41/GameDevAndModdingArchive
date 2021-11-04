using Sandbox;
using Sandbox.UI;
using Sandbox.UI.Construct;

namespace actionbox.UI.Panels
{
	public class HealthPanel : Panel
	{
		public Label Label;
		public HealthPanel()
		{
			Add.Label("⚕️", "icon");
			Label = Add.Label("100", "value");
		}

		public override void Tick()
		{
			var player = Local.Pawn;
			if ( player == null ) return;

			Label.Text = $"{player.Health}";
		}
	}
}
