using actionbox.UI;
using Sandbox;

namespace actionbox
{
	[Library("Actionbox", Title = "Actionbox!")]
	public partial class ActionboxGame : Sandbox.Game
	{
		static ActionboxGame()
		{
			Event.Run("actionbox.RegisterLoadoutItems");
		}

		public ActionboxGame()
		{
			if ( IsServer )
			{
				//Sandbox.Global.PhysicsSubSteps = 50;
				Log.Info("SERVERSIDE.");
				new ActionboxHUD();
			}

			if ( IsClient )
			{
				Log.Info("CLIENTSIDE.");
			}

		}

		public override void PostLevelLoaded()
		{
			base.PostLevelLoaded();
			//ItemRespawn.Init();
		}

		public override void ClientJoined(Client client)
		{
			base.ClientJoined(client);

			var player = new ActionboxPlayer();
			client.Pawn = player;
			player.Respawn();
		}
	}
}
