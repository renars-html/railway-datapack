# Test cycle 4: speed limits and persistent 20-cart registration

The player reported closer spacing works at the original test speeds. Speed
stress testing found visible spacing distortion after curves around 17.5 blocks/s
and corner rounding around 20 blocks/s. These remain known visual limitations;
no smoothing fix is claimed. For now the maximum is **step 8 = 19.953 blocks/s**
and the default for a new fixture is **step 3 = 7.482 blocks/s**, at 20 TPS.
Reload preserves a valid current speed (1–8); an out-of-range speed resets to 3.

## Existing movement fixture

Update the pack and `/reload` nearby. No rebuild is needed. Run `dev/status`.
If it retained a speed other than 3, use `dev/slow` or `dev/fast` until it reads 3.
Check `dev/fast` stops at 8 and `dev/slow` stops at 1. Start/stop should still work.
The movement fixture still contains two carts: this cycle's twenty-cart test
checks registration, not twenty-cart movement. The current clear gap remains
about 0.641 blocks on straights (1.621 blocks between centers).

All names here are invoked as `/function railway:<name>`.

## New registry test

1. In the same Creative Overworld, stand on empty flat ground at least 30 blocks
   from the rail fixture. Reserve a clear 10×10 area. Run:

   ```mcfunction
   /function railway:dev/registry_setup
   ```

   It spawns **20 carts** (19 ordinary, one chest cart) and a persistent controller
   marker, without changing blocks. The chest contains 7 diamonds and 11 cobblestone.
   Note the train ID printed in chat. The helper is intentionally single-use;
   do not delete test carts yet.
2. Inspect that train using its printed ID (replace `1` below if different):

   ```mcfunction
   /function railway:api/train/inspect {train:1}
   ```

   Expect `ok:1b`, `loaded_carts:20`, `state:"unassigned"`, one owner UUID, one
   controller UUID, and **20 distinct cart UUIDs with indices 0 through 19**.
   The carts have no route or movement controller yet; ordinary pushing/gravity
   still applies. Movement and complete loading reconciliation are later gates.
3. Run `/reload` and inspect again. Save/quit and reopen (or restart the server),
   return to this area and inspect once more. Expect the **same ID, owner,
   controller UUID, ordered cart UUIDs and cargo**, and 20 loaded carts nearby.
4. Try attaching an already registered test cart again:

   ```mcfunction
   /execute as @e[type=minecraft:minecart,tag=railway.registry_test,limit=1] at @s run function railway:api/train/attach {train:1}
   /data get storage railway:api result
   ```

   Expect `ok:0b`. Inspect again: still 20 entries, with no duplicated member.
5. Run `/function railway:api/train/create` to create a second, empty train.
   Its ID must be greater than the first. Inspect it: zero carts and a different
   controller UUID. Reinspect the first: still 20, unchanged. Inspect ID `-1` or
   an unused positive ID: expect `ok:0b` and no changes to either train.

Report command errors, the two train IDs, counts before/after reload and restart,
any UUID/index changes, duplicate-attach result, and cargo contents. Also confirm
speed step 8 cannot be exceeded. This is the next in-game gate before connecting
persistent registration to twenty-cart movement.

## Backend interfaces and limits

`api/train/create` runs as an Overworld player, allocates a monotonic ID, records
its owner's UUID, and creates a tagged marker. `api/train/attach {train:N}` runs
as the **explicit cart entity**, with `at @s`, and records its UUID/index. Only
ordinary and chest minecarts are accepted, with a current bound of 64 per train.
The two movement-fixture carts cannot be attached to this registry. A registered
cart cannot be attached twice or to another train. `inspect` reads persistent
membership and counts loaded, tagged carts in the Overworld; an unloaded cart
remains registered and is never respawned by inspection.

These APIs are operator-only backend entry points. Owner identity is stored;
player-facing ownership enforcement, detach/remove, route assignment, bounded
recovery jobs and movement are not implemented yet. No controller or cargo is
respawned automatically. Do not treat loaded-tag counts as a completed UUID-based
reconciliation system. No per-train work is added to the tick function yet.
