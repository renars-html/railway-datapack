# Test cycle 5: registered 20-cart movement

Train inspection now prints the expected information, confirmed by the player.
This cycle connects persistent membership to the existing movement path. It does
not add pathfinding, collision protection, reservations, or survival controls.

## Creating and rebuilding compositions

In Creative, stand on clear flat ground away from the loop (reserve 16×36 blocks
extending along +X/+Z if rebuilding). Examples:

```mcfunction
/function railway:api/train/spawn {normal:19,chest:1}
/function railway:api/train/rebuild {train:ID,normal:18,chest:2}
```

Counts must be integers, each 0–64, totaling **1–64**. Zero of either type is
allowed. Normal carts come first, followed by chest carts. New chests are empty.
`spawn` creates a new train ID. `rebuild` retires the specified ID and creates a
replacement with a **new ID**, including when the old carts were destroyed.
Stop the old train and dismount before rebuilding. Its controller must be loaded.
Existing loaded carts/cargo are preserved in a separate grid starting 20 blocks
along +Z; they are detached rather than deleted. Unloaded old carts stay associated
with the retired ID and cannot become members of the replacement automatically.
Retired IDs cannot restart or accept attachments. No cargo is copied or respawned.

For the destroyed 20-cart train, use `rebuild` with its old ID and counts 19/1.
Then use the newly printed ID in `dev/long_train` and the tests below. If the train
was already bound, rebuild frees the loop for the replacement. Put known items in
its new chest cart before cargo tests; expect those items to survive unchanged.

The loop binding now accepts **1–24 carts**; 25–64 carts can be created/inspected
but need a longer test route before movement. The 20-cart tests below remain the
required long-train acceptance gate. Verify spawn with a short mixed composition,
and rebuilding it with different counts, before testing the long train. Invalid
counts (negative, fractional, zero total, or total 65+) must return 0 without
creating/retiring a train. Check that surviving old chest cargo remains in its
parked cart, and that the replacement has the requested count/order.

Member records now include `kind` (`normal` or `chest`). The ordered UUID/index
records remain the basis for a future interface that selects arbitrary cart
orders; this count-based command currently groups the two types.

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
   missing carts, incorrect membership, passengers, or trains longer than 24 carts.

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
