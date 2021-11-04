using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sandbox;

namespace actionbox.Entities.Weapons
{
	class RealisticProjectile : ModelEntity
	{
		// TODO: find a fix for traces with size,
		// detecting inside faces of objects as surfaces.

		public ProjectileData ProjectileData;

		private const int MaxTraceIterations = 10;

		private int Penetrations = 0;

		private float KineticEnergy = 1.0f;

		private Vector3 SpawnLocation;

		private Queue<TraceResult> Entries;
		private Stack<TraceResult> Exits;
		private List<Entity> DamagedEntities;

		public override void Spawn()
		{
			base.Spawn();

			ProjectileData = new ProjectileData();
			this.Velocity = this.Velocity * ProjectileData.MuzzleVelocity * 39.37f; // 39.37 SU = ~1 m
			SpawnLocation = Position;


			this.SetModel(ProjectileData.ModelPath);
			this.SetupPhysicsFromSphere(PhysicsMotionType.Dynamic, this.Position, ProjectileData.Size);


			this.MoveType = MoveType.Physics;
			this.UsePhysicsCollision = true;
			this.PhysicsEnabled = true;
			this.PhysicsBody.GravityScale = 0.25f;
			//this.SetInteractsExclude(CollisionLayer.Player);
		}



		[Event.Tick.Server]
		public virtual void Tick()
		{

			//DebugOverlay.Sphere(this.Position, BulletData.Size, Color.Magenta, false, Time.Delta);
			//Log.Trace(this);
			//Log.Warning(this.Velocity.Length);
			float distanceTraveled = Vector3.DistanceBetween(Position, SpawnLocation);
			// Check if projectile has reached it's max range.
			if ( distanceTraveled > ProjectileData.MaxRange * 39.37 || KineticEnergy <= 0 )
			{
				DeleteProjectile();
			}
			if ( !IsServer )
			{
				return;
			}
		}

		protected override void OnPhysicsCollision(CollisionEventData eventData)
		{
			base.OnPhysicsCollision(eventData);	
			if ( IsServer )
			{
				float time = 10f;
				float size = 20f;
				Vector3 position = eventData.Pos;
				DebugOverlay.Sphere(position + eventData.Normal * size, size, Color.Magenta, true, time);
				DebugOverlay.Line(position, eventData.Pos - eventData.PreVelocity.Normal * size, Color.Red, time, true);
				DebugOverlay.Line(position, eventData.Pos - eventData.Normal * size, Color.Green, time, true);
				DebugOverlay.Line(position, eventData.Pos + eventData.PostVelocity.Normal * size, Color.Blue, time, true);

			}
		}

		public override void Touch(Entity other)
		{
			base.Touch(other);
			if ( other.IsValid() )
			{
				var damageInfo = DamageInfo.FromBullet(Owner.Position, Owner.Position * 200, ProjectileData.MaxDamage)
													.WithAttacker(Owner)
													.WithWeapon(this);
				other.TakeDamage(damageInfo);
			}
			DeleteProjectile();
		}

		private void TraceForExits()
		{
			int iteration;
			Vector3 start = this.Position;
			Vector3 end = this.Position + this.Velocity * Time.Delta;
			Vector3 forwardSkip = this.Velocity.Normal;

			iteration = 0;
			TraceResult backwardsTrace = DoRayTrace(end, start);
			while ( backwardsTrace.Hit && iteration < MaxTraceIterations )
			{

				// Process exits only if there are entries to resolve.
				if ( Entries.Count > Exits.Count )
				{
					Exits.Push(backwardsTrace);
				}
				iteration++;
				backwardsTrace = DoRayTrace(backwardsTrace.EndPos - forwardSkip, start);
			}
		}

		private TraceResult DoRayTrace(Vector3 startPosition, Vector3 endPosition)
		{
			var start = startPosition;
			var end = endPosition;
			DebugOverlay.Line(start, end, Color.Blue, 20, false);

			var tr = Trace.Sweep(new PhysicsBody(), new Transform(end))
				.UseHitboxes()
				.Ignore(Owner)
				.Ignore(this)
				.Run();

			return tr;


			//var traceResult = Trace.Ray(start, end)
			//	.UseHitboxes()
			//	.Ignore(Owner)
			//	.Ignore(this)
			//	.Run();

			//return traceResult;
		}

		private void DeleteProjectile()
		{
			MoveType = MoveType.None;
			Velocity = 0;
			UsePhysicsCollision = false;
			PhysicsEnabled = false;
			_ = DeleteAsync(0.0f);
		}



	}
}
