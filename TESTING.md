# Test cycle 9: optimized hot path and persistent loading

The player confirms cycle 8 passes, with exact repeatable center stops across
speeds/deceleration rates and working reload persistence. No rebuild is required.
Replace the pack and `/reload` near the existing 20-cart train.

## New checks

1. Ride one lap at 7.5 and one at 20 blocks/s, then repeat one saved center-station
   stop. Interpolation and validation were optimized; behavior, spacing, marker
   alignment, passengers and cargo must remain unchanged.
2. Run `/function railway:dev/performance_report`. It should show the loaded bound
   controller and registered carts. Read `/tick query` directly while held/moving
   and on approach. Report its average tick time, CPU model if known, and fixed
   render/simulation distances. See [PERFORMANCE.md](PERFORMANCE.md) for optional
   CPU profiling and meaningful baseline comparisons.
3. Enable persistent loading:

   ```mcfunction
   /function railway:api/network/load_test_loop
   ```

   Expect a reported chunk count (at most 24 on the large fixture). Leave the
   train running and travel/teleport 300+ blocks away. Inspect twice: it should
   still have 20 loaded carts and changing progress. Return and check cargo and
   center stopping. Reload/quit preserves tickets but still pauses the train;
   start it explicitly as before, including when away from the loop.
4. Once, test `/function railway:api/network/unload_test_loop`: trains should
   immediately hold, tickets added by this pack should be released, and existing
   externally forced chunks must remain forced. Re-enable loading afterwards for
   future tests. Release the lease before using large_loop again. Optional: run
   the loading test on a negative-coordinate fixture to verify chunk boundaries.

Full route/network loading and high-double-digit capacity are not established
by this single-loop test. Do not spawn dozens of trains on top of one another as
a capacity test; collision density would make the result unrepresentative.

## Existing fixture setup and controls (reference)

## Build a realistic-size fixture

1. Stop and wait until stationary, then dismount. Choose empty flat space adjacent
   to the old loop, keeping it and all registered members loaded. Run:

   ```mcfunction
   /function railway:dev/large_loop
   ```

   **This overwrites a 76×36×6 volume at your feet**, extending +X/+Z. The new loop
   is **199.657 blocks**, about five times the old 39.657. It includes straights,
   curves, a hill and powered rails. A bound train is relocated and held without
   replacing its carts or cargo; the old rails remain. If there is no bound train,
   use `dev/long_train {train:ID}` afterwards. The new loop fits **up to 64 carts**;
   use 20 for the required tests. A return of 0 means the original fixture/train
   is not loaded, is still moving, has missing members, or has a rider.
2. Apply the normal operating profile:

   ```mcfunction
   /function railway:api/train/configure_motion {train:ID,speed:7.5,accel:2.5,decel:2.5}
   /function railway:api/train/start {train:ID}
   ```

   Ride three laps and stop/restart. Watch spacing, corner behavior, rider/cargo
   retention and any slowdown. Inspect speed values. Accel/decel now round to
   the nearest **0.5** and clamp between **2 and 5 blocks/s²**; e.g. 1 becomes 2,
   3.2 becomes 3, 3.3 becomes 3.5, and 8 becomes 5. Default rates are still 2.5.

## Pick a stable station location

1. Stop the train. Stand on or next to a **long straight section** where you want
   the **center of the train** to stop, and run:

   ```mcfunction
   /function railway:dev/station_here {station:1}
   ```

   Wait for the saved message and repeating end-rod particle marker (~1.3 seconds
   on the large loop). The closest point of the stored path is selected, with
   roughly 0.125-block sampling resolution. Station IDs are integers 1–64.
2. Request that marked station, then start if currently held:

   ```mcfunction
   /function railway:api/train/station_stop {train:ID,station:1,dwell:100}
   /function railway:api/train/start {train:ID}
   ```

   Expect the midpoint between carts **9 and 10** (indices 0–19) to line up with
   the marker along the track, a 5-second dwell, then departure. Inspect should
   show distance 0 while dwelling. The head is about **15.4 blocks beyond** the
   center marker; this is intentional. Marker and head progress samples differ.
3. Repeat after departing and again from another location/speed. The **same train
   center** should stop at the **same marker**, even though travel time differs.
   If the nearest pass is too close for normal braking, it skips to the next lap
   rather than rejecting or abruptly stopping. At rest, a nearby station can
   legitimately require only a short trip; the marked location must remain fixed.
4. Repeat with speed 20 and decel profiles 2, 2.5 and 5 (configure only after the
   previous dwell completes). Mark a second station on another straight with
   `station:2` and test it. Report center error relative to the marker and whether
   repeated stops drift. Test signal holds and reload/quit persistence during an
   approach as before. Center means midpoint **along the route**, not a bounding
   box midpoint when the train bends around corners.

`station_stop` now takes a saved **station ID**, replacing the old raw `sample`
argument. A marker is tied to its route revision. Running large_loop again moves
and rebuilds the geometry, invalidates prior station marks, cancels an armed stop,
and holds the train; place fresh station marks afterwards. Reload preserves the
current loop profile, stations and valid approach/dwell state.

## Emergency recovery override

```mcfunction
/function railway:api/train/emergency_start {train:ID}
```

Expect an **immediate jump to maximum speed (~20 blocks/s)**, bypassing normal
acceleration, manual/signal holds, emergency stop and station dwell/approach. The
station plan is cancelled; the signal's stored blocked state is retained but
ignored during override. Inspect shows `override:1`.

Test with a blocked signal and during dwell. `api/train/stop` exits override and
service-brakes; `api/train/start` exits override and restores normal rules, so a
still-blocked signal brakes/holds the train again. `emergency_stop` always exits
it and stops immediately. Reload and quit/reopen also cancel override and pause.

This deliberately allows the **remaining valid members** of a damaged train to
move for recovery. It never invents missing carts, loads chunks or moves an entity
whose UUID fails the stored membership check. Do not destroy cargo to test this;
an optional test may remove one empty cart, run override, then emergency-stop and
use rebuild to repair the composition.

## Report and limitations

Report large-loop movement, repeated **center-marker** stopping error at each
rate, override/normal control transitions, signal behavior and persistence. No
need to repeat unaffected spawning/composition tests. Optional: run a 64-cart
composition on the large loop after the 20-cart tests and report performance.

The track remains generated geometry, not a scan of physical rails. Manual rail
edits do not reroute trains. Route graph compilation and profile-specific cached
braking points come next; the current stop planner calculates the discrete safe
approach dynamically. Following-block occupancy/reservations are not implemented:
`set_signal` is still an operator-supplied backend condition. Without a loading
lease, stay near the loop; readiness reconciliation and chunk-boundary safety and arbitrary block-change detection remain future gates.
