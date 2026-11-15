# Test cycle 3: incremental speed stress test

Status: the player reported no issues with the closer spacing in cycle 2.
This cycle changes fast/slow to incremental controls; spacing is unchanged.

Replace the pack and `/reload` near the existing fixture; no rebuild is needed.
Reload pauses movement and preserves the current speed. Board and run
`/function railway:dev/start`, then repeat `/function railway:dev/fast` to increase
speed one step at a time. `/function railway:dev/slow` decreases it one step,
with a minimum of 1. Each command and `dev/status` report the current step and
approximate blocks/second at 20 TPS. Each step adds about **0.125 blocks/tick**
(**2.494 blocks/second**). For example, step 8 is about 20 blocks/s and step 16
is about 40 blocks/s. Use `dev/stop` to hold at any speed.

Check rider retention, jitter, curve/slope clipping, cart separation, and stop/
resume as speed rises. Report the highest acceptable step, the first problematic
step, and what changed. Check cargo and reload once at your preferred speed.

This small closed-loop fixture caps the step at **317** (about 791 blocks/s),
because 318 samples/tick would complete a whole lap between updates and appear
stationary. This is a test-fixture cap, not a proven backend speed limit. High
speeds skip more path samples; motion can visibly cut corners, and above half a
lap per tick it can appear to move backwards. Report speed by its step rather
than estimating it visually. This fixture does not validate collision handling
or every skipped track section at those speeds. Slower server TPS reduces actual
blocks/second. Repeat `slow` to bring the speed back down if needed.

The offset is now 13 samples instead of 24: **1.621 blocks between cart centers**,
giving approximately **0.641 blocks of visible clearance on straight track**
(using the standard 0.98-block cart width), versus about 2.013 previously. That is
roughly 32% of the previous clear gap. Clearance on curves and slopes varies with
geometry; check those locations for clipping or apparent overlap.

For an existing fixture, replace the datapack files and run `/reload` while near
it. Keep
the existing track and carts; do not run setup again. Then repeat the tests below,
checking spacing, overlap, jitter, and whether holding/restarting stays stable.

## Setup

1. Use a disposable **Creative superflat Overworld** with commands enabled. Keep
   the default minecart experiment settings; report if you enable experiments.
2. Copy the updated `railway-datapack` folder into the world's `datapacks` folder
   (with `pack.mcmeta` directly inside it), then run `/reload`.
3. Stand in an empty area and run `/function railway:dev/setup`. It **replaces a
   16×16×6 area beginning at your feet**. Stay near the fixture throughout this
   cycle. It creates a stone platform, rail loop, hill, powered rail, one passenger
   cart, and a chest cart containing **7 diamonds and 11 cobblestone**.

If a function is unknown or setup fails, stop and report the exact message plus
any `railway` function-loading errors in `.minecraft/logs/latest.log`.

## Tests

| Test | How | Expected result |
| --- | --- | --- |
| Occupied movement | Right-click the empty cart on the north rail. Run `/function railway:dev/start`. Ride two laps, then run `/function railway:dev/fast` and ride two more at the increased speed. | You stay mounted. Both carts follow the rails, including the hill and corners. The cargo cart remains about 1.62 track blocks behind by center distance. No overlap, sustained shaking, visible rail clipping, or unexplained speed changes. |
| Hold/resume | While riding, run `/function railway:dev/stop`, wait 10 seconds, then run `/function railway:dev/start`. | Both carts hold in place and resume together. No continued movement, sinking, or dismount. |
| Slope and powered rail | Stop and dismount. Run `/function railway:dev/hill`, board the repositioned passenger cart, and wait 10 seconds before starting. Then repeat after stopping/dismounting with `/function railway:dev/powered`. | The passenger cart holds on the slope and on powered rail. Boarding does not push it away. It resumes correctly at both locations. |
| Gravity comparison | Run `/function railway:dev/gravity_on` and ride one lap. Repeat the hill hold if possible, then restore `/function railway:dev/gravity_off`. | Report any difference in height, jitter, drift, or passenger retention. The default uses gravity off; this comparison helps identify physics conflicts. |
| Reload and cargo | While riding, run `/reload`. Wait 10 seconds, then run `/function railway:dev/start`. Stop, dismount, and open the chest cart. | Reload pauses in place and does not eject you. Start resumes. Cargo remains exactly 7 diamonds and 11 cobblestone. |

Run `/function railway:dev/status` at the end and copy its output. The status shows
run (1=moving), sample index, speed (samples/tick), NoGravity (1=gravity off), fault (0=normal),
rider-loss transitions, fixture origin, cart position, and inventory. **Manual
dismounts also increase the rider-loss counter**; separately report any ejection
that happened without pressing Shift. `/function railway:dev/slow` restores the
initial speed. Ordinary minecarts placed elsewhere should remain unaffected.

## Report back

- Exact game version, singleplayer/server, and minecart experiments on/off.
- Movement at slow/fast speed: pass/fail; where any jitter, clipping, or ejection
  occurs (straight, curve, uphill, downhill, powered rail).
- Hold/resume on flat, hill, and powered rail: pass/fail.
- Whether gravity on changes the behavior; reload retention and cargo counts.
- `/function railway:dev/status` output and any command errors. A short video is
  useful if the issue is visual; no need to record a passing test.

Leave the fixture installed for follow-up tests, or dismount and run
`/function railway:dev/cleanup`. Cleanup deletes the fixture carts and their test
cargo, leaves the track/platform, and cannot restore overwritten blocks. Missing
or duplicate carts require inspection rather than automatic respawning.

## Implementation limits for this cycle

The loop uses 318 uniformly spaced distance samples over a 39.657-block rail
centerline. Each speed step is approximately 0.125 blocks/tick, with 1.621 blocks
between cart centers. One marker supplies the local origin; two explicitly tagged
carts use shared progress with an offset. Position and zero velocity are applied
each tick, including while held. Curve interpolation follows the vanilla diagonal
rail centerline; the rail height and its interaction with entity physics are
deliberately under test. No smoothing or physics success is claimed in advance.

This fixture has no automatic chunk loading, track-edit detection, braking curve,
collision protection, route creation, or multiplayer ownership. Remain nearby.
The full-train loading/recovery and reservation gates remain on the roadmap.
