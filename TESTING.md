# Test cycle 12: graph-selected physical branching movement

The player confirmed correct topology paths/costs and mid-compile reload recovery.
Failed queued path jobs now also announce their failure in chat, rather than only
exposing it through status. The new slice compiles selected graph edges into shared
closed-circuit geometry and lets the registered train follow that geometry.

Replace the pack and `/reload`. Use your existing 20-cart train; do not replace its
members. Train IDs, graph IDs and path IDs are different counters. Substitute their
numeric values in the commands below. Keep the world unpaused while jobs compile.

## Create the generated branch fixture

1. Stop and wait until stationary, dismount, and clear the old service route:

   ```mcfunction
   /function railway:api/train/stop {train:TRAIN}
   /function railway:api/train/clear_route {train:TRAIN}
   /function railway:api/network/unload_test_loop
   ```

   Ignore unload returning 0 if no lease exists. Keep the old fixture/controller
   and all train members loaded. Choose clear flat ground adjacent to the old loop.
2. Run:

   ```mcfunction
   /function railway:dev/branch_loop
   ```

   **Overwrites a 76×36×6 volume extending +X/+Z at your feet.** It relocates the
   existing bound train and builds the outer loop plus a U-shaped inner detour,
   split and merge. It also prints a **new sealed graph ID**. The prior virtual
   graph remains unchanged. Existing stations/routes belong to the old geometry
   revision and must not be used on this new fixture. No carts/cargo are replaced.
3. Re-enable persistent loading with `api/network/load_test_loop` if desired.
   The same chunk rectangle covers both branches.

## Select and ride the outer circuit

```mcfunction
/function railway:api/path/create {graph:GRAPH,from:1,to:1,via:[3]}
```

Wait for the ready message, or check `api/path/status {path:PATH}`. Expect nodes
`[1,2,3,1]`, edges `[1,2,3]`. Then compile its geometry:

```mcfunction
/function railway:api/path/compile_geometry {path:PATH}
/function railway:api/path/geometry_status {path:PATH}
```

Wait until geometry state is `ready` (about 10–12 seconds of ticking at 20 TPS).
It should have **1,598 samples**, switch_mode 0. Stop/dismount before assigning:

```mcfunction
/function railway:api/train/assign_path {train:TRAIN,path:PATH}
/function railway:api/train/start {train:TRAIN}
```

Assignment repositions the held train at the new circuit origin and sets static
switch states. Board before starting if riding. Ride two laps at 7.5 blocks/s and
then at 20 using configure_motion. Expect all 20 carts to follow the outer loop,
going straight through the split/merge without entering the detour. Watch the
middle/rear carts, spacing, riders and cargo through both junctions.

## Select the inner detour

Create a second closed path with `from:1,to:1,via:[4,3]`. Expect nodes
`[1,2,4,5,3,1]`, edges `[1,4,5,6,3]`. Compile its geometry and wait for ready.
It should have **1,812 samples**, switch_mode 1, about **226.485 blocks** instead
of the outer circuit's **199.657 blocks**.

Stop, wait, dismount and assign this second path to the same train. Start and
repeat both speeds. Every cart should take the U-shaped inner branch, merge back
onto the outer track, and complete the loop without jumping directly between
junctions, splitting the train, accumulating spacing error or taking the straight
shortcut. Unchanged commanded speed should remain approximately unchanged in
physical blocks/second despite the different circuit length.

## Persistence and recovery

- `/reload` and quit/reopen while riding the detour: immediately hold, retain
  geometry path, exact progress, members, passengers and cargo. Manual start must
  continue on the **detour**, not revert to the outer default path. Inspect should
  show the geometry path ID. Check progress/sampling past the outer loop's length:
  the longer detour must not wrap early or jump when inspecting/starting.
- Reload during geometry compilation: resume and publish the same ready result.
  Recompiling an already-ready geometry is idempotent and reports that it exists.
- Signal/manual holds and emergency start/stop should retain their prior behavior
  on either circuit. Emergency override must still follow the selected geometry.
- Retry the prior unreachable topology query on the virtual graph. In addition
  to failed status, expect a red failure message without manually inspecting.

Report outer/detour choice for the entire train, branch/merge spacing, high-speed
behavior, inspection/reload persistence, inventory and any command-loading errors.
No fleet performance test is needed.

## Scope and return to loop service

This is still one bound train on the fixture. Switches are set only during stopped,
unoccupied assignment, not flipped while a train is crossing. A circuit requiring
both straight and detour switch modes in different laps is explicitly rejected
until runtime switch actions/tail-clear locks are implemented. Topology paths stay
valid even if geometry compilation rejects an unsupported case.

Graph geometry currently supports closed circuits on this generated template.
It is immutable, reusable by reference, and sampled once in bounded 16-frame batches;
per-train progress selects its own geometry rather than overwriting the shared loop.
It supports up to 8,192 samples and the existing 64-cart registration bound.
No runtime pathfinding occurs while travelling.

Saved loop-station/service-route snapshots cannot yet be used on graph geometry:
those APIs deliberately reject it. The next integration adds graph-aware station
positions, profile caches and automatic service. To return to the base outer loop,
stop, dismount and use `api/train/clear_path {train:TRAIN}`. It resets progress and
switches to straight; loop station/service APIs become available again. Mark fresh
stations/create fresh routes on the new fixture revision. Automatic reload resume
remains outstanding; manual start after reload is still required.
