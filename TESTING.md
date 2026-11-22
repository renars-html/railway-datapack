# Test cycle 13: graph-path service and automatic recovery

The player confirms physical outer/detour movement, coupling and reload persistence
passed. This larger batch integrates graph stations, shared automatic service,
path-specific braking caches and revalidated automatic reload recovery. It uses
existing compiled branch geometry: **no terrain/fixture rebuild is needed**.
Fleet profiling stays deferred.

Replace the datapack and `/reload`. Normal running trains may now automatically
resume after validation; stop yours before setting up the following tests. Use
20 carts and the existing inner detour path for this combined cycle.

## Register stations on a compiled path

1. Stop and wait until stationary, dismount and clear any previous service route:

   ```mcfunction
   /function railway:api/train/stop {train:TRAIN}
   /function railway:api/train/clear_route {train:TRAIN}
   ```

   Keep the desired compiled path assigned. If you used clear_path after the
   previous cycle, assign it again using `api/train/assign_path {train:TRAIN,path:PATH}`.
   Find the current ID using train inspection's geometry_path field. Path IDs and
   service-route IDs are separate counters.
2. Stand beside a suitable straight on the inner detour and register station 1:

   ```mcfunction
   /function railway:dev/path_station_here {path:PATH,station:1}
   ```

   Wait for the save message/particle. Register station 2 on another long straight
   of the **same path**, preferably the outer return section. Wait again. The
   markers designate the train's route midpoint, as before. The nearest-point
   scan follows that compiled path, not the default outer-loop samples.

The original `dev/station_here {station:S}` still registers default-loop stations
(geometry 0). Compiled-path and default-loop stations cannot be mixed in one
service definition. Nearest-point scans now also resume after reload.

## Compile and run automatic graph service

```mcfunction
/function railway:api/route/create_path {path:PATH,stops:[1,2],speed:7.5,accel:2.5,decel:2.5,dwell:100}
```

Note the new **service-route ID** and wait for ready (about 5 seconds unpaused).
Check `api/route/status {route:ROUTE}`: expect geometry PATH, two frozen stations,
correct forward distances, center braking points and a cache key containing that
geometry ID. Assign while stopped, then board and start:

```mcfunction
/function railway:api/train/assign_route {train:TRAIN,route:ROUTE}
/function railway:api/train/start {train:TRAIN}
```

Expect at least three complete **station 1 → 5-second dwell → station 2 → dwell**
cycles, following the inner branch and merge every time. Check exact train-center
alignment at both markers, no accumulating spacing errors, and unchanged cargo.
Repeat with a newly created profile at speed 20 and decel 5; assign only after
stopping. The approach may limit speed if station spacing is insufficient.

Create another route with the same PATH/speed/decel and different acceleration or
stop order. It should have the same braking cache key and `cache_reused:1b`.
Routes on another geometry must use another cache key, even if speeds match.
Trying to compile mixed-geometry station IDs must fail with a message and must
not affect your running service. While assigned, manual station/profile changes
remain locked. clear_route restores manual operation on the **same selected path**;
clear_path requires clearing the service route first.

## Automatic reload and quit/reopen recovery

This changes the previous manual-restart policy. Recovery first holds position
and velocity for at least two ticks, verifies member UUIDs/count, the controller,
geometry/profile/cache and any existing loading lease, then restores eligible
normal running intent. Speed ramps from zero. No player start command is needed.

1. **While moving/approaching:** `/reload` should cause only a short pause, then
   automatic service resumes toward the same stop. Repeat with quit/reopen while
   mounted; cargo, passengers, path, route, cursor and remaining distance persist.
2. **During dwell:** use a temporary route with dwell 200 (10 seconds) to make
   observation easier. Reload about halfway through. The remaining dwell must
   be frozen during recovery and then count down; departure is automatic after
   the remaining time, with no skipped/duplicated stop. Quit/reopen should preserve
   the same behavior; time out of the world is not simulated.
3. **Manual hold:** stop during an approach or dwell, reload/quit and reopen. It
   must stay held until start. Manual holds now freeze remaining dwell too.
4. **Signal hold:** blocked:1 with normal running intent must remain blocked over
   reload. Clear the signal: service resumes automatically. If you manually stop
   while waiting, reload and clear the signal: it must still require start.
5. **Emergency states:** emergency_stop must remain stopped over reload. An active
   emergency_start override must also be cancelled and remain stopped after reload;
   it must never restart at maximum speed by itself.
6. **Repeated reload:** two reloads during recovery must retain the original intent,
   not replace it with the temporary hold. An explicit stop while recovering must
   cancel automatic restart. Do not destroy inventory to test recovery failures.

Inspection now shows recovering, resume_pending and dwell_ticks. Typically healthy
recovery completes too quickly to observe without repeated commands. Missing
members or unavailable readiness data hold it pending for at most 200 ticking
checks (~10 seconds at 20 TPS), then it faults and discards automatic resume intent.
After repair, explicit normal start revalidates readiness. There is no automatic
cart/controller spawning or cargo reconstruction.

## Combined control regression

On the graph service, check start/stop, blocked signals, and emergency override
as in earlier cycles. Emergency start bypasses service/holds but keeps following
the selected geometry; normal start returns to the next service stop. Station
order advances exactly once on arrival. Loading-lease release deliberately holds
trains and cancels recovery intent; it does not turn ticket release into a restart.

Report graph-service station accuracy/order, cache reuse, automatic recovery during
approach/dwell, preserved manual/signal/emergency holds, cargo/riders, and errors.
No need to repeat unrelated topology/composition/performance tests.

## Scope

Switches are still static for one selected circuit and one bound prototype train.
This batch does not add simultaneous opposing traffic, runtime switch actions,
following-block occupancy/reservations, manual rail scanning or survival UI. The
next larger chunk addresses network traffic/conflict blocks and tail-clear locks.
Automatic recovery here covers graceful reload/quit through the existing fixture
lease. Dedicated-server startup/disconnect/crash consistency and general network
chunk reference counting remain explicit validation/implementation gates.
