# Test cycle 10: shared loop routes and automatic station service

The player reports the previous one-train tests worked at simulation distances
5 and 12, maintaining 20 TPS. Fleet-scale capacity remains unmeasured and testing
it is deferred. This cycle tests reusable route compilation and following only.

Update the pack and `/reload`. Keep the current 20-cart bound train, large loop
and loading lease. Do not rebuild the fixture. Use numeric train/route IDs below.

## Create a reusable route

1. Ensure saved stations **1 and 2** exist on different straights. If needed, stand
   beside a desired center stopping point and use:

   ```mcfunction
   /function railway:dev/station_here {station:2}
   ```

   Wait for the marker/save message. Avoid editing station marks during compilation.
2. Create the ordered service route:

   ```mcfunction
   /function railway:api/route/create {stops:[1,2],speed:7.5,accel:2.5,decel:2.5,dwell:100}
   ```

   Note the printed **route ID**. The job processes stops and builds a shared
   braking table in bounded batches. Keep the world unpaused while waiting:
   first compilation is about 5 seconds at 7.5 blocks/s, up to ~13 seconds at 20.

   ```mcfunction
   /function railway:api/route/status {route:ROUTE}
   ```

   Expect `state:"ready"`, two frozen station samples, forward leg distances,
   center braking points, and a cache key. A missing/invalid station must produce
   `state:"failed"` instead; failed/compiling routes cannot be assigned.
3. Stop the train and wait until stationary. Assign and start:

   ```mcfunction
   /function railway:api/train/assign_route {train:TRAIN,route:ROUTE}
   /function railway:api/train/start {train:TRAIN}
   ```

   Expect **station 1 → dwell 5 seconds → station 2 → dwell → repeat**, without
   manually requesting station_stop again. Run at least two complete cycles.
   Both train-center alignments, spacing, riders and cargo must remain unchanged.

## State and reuse checks

- Inspect the train: service route ID and next stop index should be shown. The
  index advances once on arrival and does not advance repeatedly during dwell.
- Stop/start during an approach and during dwell. Use the existing blocked signal
  API. Stops/signals should pause service without losing the target or advancing
  the station order. Clearing a signal must not override a manual stop.
- `/reload` and quit/reopen during approach/dwell: train immediately pauses and
  retains route, next stop, distance, wait time and inventory. Start resumes the
  appropriate next service step. A pending compilation also resumes after reload.
- Emergency start bypasses route service and cancels the pending station plan;
  normal start returns to automatic service, at the current next-stop index.
- Create another route with `stops:[2,1]`, `speed:7.5`, `accel:3.0`, `decel:2.5`,
  `dwell:100`. Its status should quickly become ready with **the same cache key**
  and `cache_reused:1b`. Acceleration can differ because the shared braking table
  depends on geometry, cruise speed and deceleration. No train assignment changes
  merely because a second route was created. Stop and assign it to test reversed
  station order (travel direction still stays forward around the loop).

## Manual control and immutable snapshots

While a service route is assigned, manual station_stop and configure_motion are
refused: route speed/rates and station snapshots remain fixed and shared. To go
back to manual operation, stop, wait until stationary, then:

```mcfunction
/function railway:api/train/clear_route {train:TRAIN}
```

The train remains held; manual station/configuration APIs work again. To change
service settings, create another route and assign it while stopped. Moving a saved
station marker does not move a stop in an already-published route; create a new
route to capture the new location. Geometry relocation invalidates old routes,
which must not start moving the train on mismatched geometry.

Report ordered service, exact center arrivals, dwell/cursor behavior, independent
holds, persistence, cache reuse and rejected invalid routes. No performance
profiling or repeat of unrelated composition/loading tests is needed.

## Current scope

This first compiler uses the existing **directed cycle graph**. Each forward leg
has one possible path, so resolving station positions and directed distances is
the route calculation. Geometry remains shared, not copied per train. Per-speed
braking thresholds are computed once per profile (32 velocities per background
tick), shared by all compatible routes/trains, and looked up while approaching.
Cruise-distance gating skips the approach search while braking is unnecessary.

Route IDs are monotonic, published routes immutable, and only one compiler job is
accepted at a time. Stops lists have 2–16 integer station IDs; repeated IDs mean
another forward lap. Tables remain shared across reload. Partial jobs/tables are
never assignable. Runtime follows snapshots with constant-sized per-train state;
it does not rerun graph search or rebuild a braking profile per lap.

General branching/junction pathfinding, waypoints, following-block occupancy,
reservations, compact segment geometry, multi-network chunk ownership and manual
rail discovery are not implemented in this cycle. The next backend phase adds a
generated branching test graph rather than reading manually placed rails.
