# Test cycle 5: registered 20-cart movement

Train inspection now prints the expected information, confirmed by the player.
This cycle connects persistent membership to the existing movement path. It does
not add pathfinding, collision protection, reservations, or survival controls.

## Setup

1. Update and `/reload`. Return to the existing rail loop with the original
   two-cart fixture still present. Ensure the 20 registered carts from the grid
   are also loaded (stay within simulation distance of both). Dismount all carts.
2. Use the ID of the **20-cart train**, not the empty second train:

   ```mcfunction
   /function railway:dev/long_train {train:ID}
   ```

   Replace `ID` with its integer value. Expect 20 carts to form one held train
   around the loop. The original two fixture carts and their cargo are parked
   inside the loop. This binding is single-use and changes no blocks. It refuses
   missing carts, incorrect membership, passengers, or a train of another length.

## Tests

All train controls below require `{train:ID}` with that same numeric ID.

- **Movement:** board the head cart on the north rail, then run
  `/function railway:api/train/start {train:ID}`. Ride at least three laps at the
  default step **3 (~7.5 blocks/s)**. Check all 20 carts, not only the first pair:
  stable order/spacing, no lost carts, rider ejections, pileups, or accumulating
  errors through the hill, curves and powered rail.
- **Hold:** `/function railway:api/train/stop {train:ID}` should hold every cart.
  Wait 10 seconds, then start again. Repeat with the head on the slope. Boarding
  another cart while stopped must work; try a middle and rear cart for one lap.
- **Speed:** `api/train/fast` and `api/train/slow` with the same argument adjust
  this train alone, between steps 1 and 8. Test three laps at **8 (~20 blocks/s)**,
  then restore 3. Known curve rounding and temporary visual spacing distortion
  at higher speeds remain; report whether a long train makes them worse.
- **Reload/restart:** while riding, `/reload` should pause the entire train in
  place without ejecting you. Start should resume it at the same speed and
  progress. Repeat after world/server restart. Inspect the train before/after:
  same 20 member UUIDs/order, controller UUID, and cargo (7 diamonds/11 cobblestone).
- **Independence:** inspect the second empty train. It should remain unassigned
  with zero carts. Its start command must fail without moving anything.

`/function railway:api/train/inspect {train:ID}` now also shows speed step and
progress sample for a bound train. Inspect should show state `running` after
start and `stopped` after stop/reload, and 20 registered/loaded carts nearby.

Report pass/fail for each test, the train ID, any cart index/track location where
problems appear, whether speed makes them worse, and any obvious server slowdown.
If there are command errors, include their exact text and relevant latest.log
function-loading errors. Leave the fixtures in place for the next cycle.

## Backend notes

One registered marker controls speed, shared progress, and 20 fixed cart offsets
of 13 samples (1.621 path blocks between centers). The loop is 318 samples long,
so this train fits without lapping itself. Each registered UUID and index is
checked before advancement; invalid entities are never moved as replacements.
A fault holds the remaining valid carts at their last shared progress. Explicit
start is required after recovery. Reload epochs also pause controllers that were
unloaded during reload on their first subsequent tick.

Binding uses the test route `dev_loop` and disables the original two-cart tick.
Old `dev/start`, speed, gravity, reposition and cleanup commands are blocked while
bound; use the new per-train API controls. Controllers stay active while stopped
so the carts remain held. `dev/status` still describes the original fixture;
use train inspection for the long train. The existing singleton loop accepts one
registered train; independent track placement and reservations are later work.

This is still a loaded-area movement prototype. Keep the entire loop nearby.
Block readability/entity-ticking boundaries, arbitrary track edits, safe movement
across unavailable chunks, braking curves, automatic station stops, removal and
ownership enforcement are not implemented. No force loading or automatic cart
respawning is used. Owner identities remain stored for future survival access.
