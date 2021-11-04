using Sandbox;
using Sandbox.UI;

namespace actionbox.UI
{
	public partial class ActionboxHUD : HudEntity<RootPanel>
	{
		public ActionboxHUD()
		{
			if ( IsClient )
			{

				RootPanel.SetTemplate("UI/ActionboxHUD.html");
				//RootPanel.AddChild<LoadoutScreen>();
				//RootPanel.StyleSheet.Load( "/ui/ActionboxHUD.scss" );

				//RootPanel.AddChild<NameTags>();
				//RootPanel.AddChild<CrosshairCanvas>();
				//RootPanel.AddChild<ChatBox>();
				//RootPanel.AddChild<VoiceList>();
				//RootPanel.AddChild<KillFeed>();
				//RootPanel.AddChild<Scoreboard<ScoreboardEntry>>();

				//RootPanel.AddChild<InventoryBar>();
				//RootPanel.AddChild<CurrentTool>();
				//RootPanel.AddChild<SpawnMenu>();
				//RootPanel.AddChild<HealthPanel>();
			}
		}
	}
}
