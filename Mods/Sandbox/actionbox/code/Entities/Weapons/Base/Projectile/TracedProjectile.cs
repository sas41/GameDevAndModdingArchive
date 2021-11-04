using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sandbox;

namespace actionbox.Entities.Weapons
{
	class TracedProjectile : Prop
	{
		// TODO: find a fix for traces with size,
		// detecting inside faces of objects as surfaces.

		public ProjectileData CustomProjectileData;

		private const int MaxTraceIterations = 10;

		private int Penetrations = 0;

		private float KineticEnergy = 1.0f;

		private Vector3 SpawnLocation;

		private Queue<TraceResult> Entries;
		private Stack<TraceResult> Exits;
		private List<Entity> DamagedEntities;

		public TracedProjectile()
		{

		}

		public override void Spawn()
		{
			base.Spawn();

			SpawnLocation = Position;
			Entries = new Queue<TraceResult>();
			Exits = new Stack<TraceResult>();
			DamagedEntities = new List<Entity>();

			SetupPhysicsFromSphere(PhysicsMotionType.Dynamic, this.Position, 3f);

			MoveType = MoveType.Physics;
			UsePhysicsCollision = true;
			PhysicsEnabled = true;
			PhysicsBody.GravityScale = 0.25f;

			this.SetInteractsExclude(CollisionLayer.All);
		}

		[Event.Tick.Server]
		public virtual void Tick()
		{
			float distanceTraveled = Vector3.DistanceBetween(Position, SpawnLocation);

			// Check if projectile has reached it's max range.
			if ( distanceTraveled > CustomProjectileData.MaxRange * 39.37 || KineticEnergy <= 0 )
			{
				DeleteProjectile();
			}

			if (!IsServer)
			{
				return;
			}

			TraceForEntries();

			TraceForExits();

			ResolvePenetrations();
		}

		private void TraceForEntries()
		{
			int iteration;
			Vector3 start = this.Position;
			Vector3 end = this.Position + this.Velocity * Time.Delta;
			Vector3 forwardSkip = this.Velocity.Normal * CustomProjectileData.Size * 2.5f;

			iteration = 0;
			TraceResult forwardTrace = DoRayTrace(start, end);
			while ( forwardTrace.Hit && iteration < MaxTraceIterations )
			{
				Entries.Enqueue(forwardTrace);
				iteration++;
				forwardTrace = DoRayTrace(forwardTrace.EndPos + forwardSkip, end);
			}
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

		private void ResolvePenetrations()
		{
			if ( Exits.Count == 0 )
			{
				return;
			}

			TraceResult start = Entries.Dequeue();
			TraceResult end = Exits.Pop();
			float distance = Vector3.DistanceBetween(start.EndPos, end.EndPos);

			ApplyDamage(start);
			float loss = ApplyEnergyLoss(start.Surface.Name, distance);
			Penetrations++;

			DebugOverlay.Text(start.EndPos + (Vector3.Up * 3.5f), $"Entry: {Penetrations}", Color.Orange, 10, 2000);
			DebugOverlay.Sphere(start.EndPos, 3, Color.Orange, false, 10);
			DebugOverlay.Text(start.EndPos + (Vector3.Down * 3.5f), $"Material: {start.Surface.Name.ToLower()}, {start.Entity}", Color.Orange, 10, 2000);

			DebugOverlay.Text(end.EndPos + (Vector3.Up * 3.5f), $"Exit: {Penetrations}", Color.Cyan, 10, 2000);
			DebugOverlay.Sphere(end.EndPos, 3, Color.Cyan, false, 10);
			DebugOverlay.Text(end.EndPos + (Vector3.Down * 3.5f), $"Distance: {distance}, KF Loss: {loss}, KF: {KineticEnergy}", Color.Cyan, 10, 2000);
		}

		private float ApplyEnergyLoss(string surfaceMaterial, float distance)
		{
			surfaceMaterial = surfaceMaterial.ToLower();
			float forceLossPerUnit = 0.01f;
			if ( CustomProjectileData.SurfaceEnergyLossTable.ContainsKey(surfaceMaterial) )
			{
				forceLossPerUnit = CustomProjectileData.SurfaceEnergyLossTable[surfaceMaterial];
			}

			float kineticEnergyLoss = forceLossPerUnit * distance;
			KineticEnergy = Math.Max(KineticEnergy - kineticEnergyLoss, 0.0f);
			return kineticEnergyLoss;
		}

		private void ApplyDamage(TraceResult traceResult)
		{
			if ( traceResult.Entity.IsValid() && !DamagedEntities.Contains(traceResult.Entity) )
			{
				DamagedEntities.Add(traceResult.Entity);
				float effectiveDamage = CustomProjectileData.MaxDamage * KineticEnergy;
				var damageInfo = DamageInfo.FromBullet(traceResult.EndPos, traceResult.Direction * 200, effectiveDamage)
													.UsingTraceResult(traceResult)
													.WithAttacker(Owner)
													.WithWeapon(this);

				traceResult.Entity.TakeDamage(damageInfo);
			}
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
