# Test cycle 1: minecart movement backend

Status: ready for player testing in **Java 26.3**. Static checks have passed;
Minecraft command loading, rider retention, geometry, and smoothness have not
been verified in-game. This gate decides whether to keep the proposed movement
backend before implementing production trains or pathfinding.

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
| Occupied movement | Right-click the empty cart on the north rail. Run `/function railway:dev/start`. Ride two laps (about 32 seconds), then run `/function railway:dev/fast` and ride two more (about 16 seconds). | You stay mounted. Both carts follow the rails, including the hill and corners. The cargo cart remains about 3 track blocks behind. No sustained shaking, visible rail clipping, or unexplained speed changes. |
| Hold/resume | While riding, run `/function railway:dev/stop`, wait 10 seconds, then run `/function railway:dev/start`. | Both carts hold in place and resume together. No continued movement, sinking, or dismount. |
| Slope and powered rail | Stop and dismount. Run `/function railway:dev/hill`, board the repositioned passenger cart, and wait 10 seconds before starting. Then repeat after stopping/dismounting with `/function railway:dev/powered`. | The passenger cart holds on the slope and on powered rail. Boarding does not push it away. It resumes correctly at both locations. |
| Gravity comparison | Run `/function railway:dev/gravity_on` and ride one lap. Repeat the hill hold if possible, then restore `/function railway:dev/gravity_off`. | Report any difference in height, jitter, drift, or passenger retention. The default uses gravity off; this comparison helps identify physics conflicts. |
| Reload and cargo | While riding, run `/reload`. Wait 10 seconds, then run `/function railway:dev/start`. Stop, dismount, and open the chest cart. | Reload pauses in place and does not eject you. Start resumes. Cargo remains exactly 7 diamonds and 11 cobblestone. |

Run `/function railway:dev/status` at the end and copy its output. The status shows
run (1=moving), sample index, speed (1/2), NoGravity (1=gravity off), fault (0=normal),
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
centerline. Speeds are approximately 0.125 and 0.249 blocks/tick, with 2.993 blocks
between the carts. One marker supplies the local origin; two explicitly tagged
carts use shared progress with an offset. Position and zero velocity are applied
each tick, including while held. Curve interpolation follows the vanilla diagonal
rail centerline; the rail height and its interaction with entity physics are
deliberately under test. No smoothing or physics success is claimed in advance.

This fixture has no automatic chunk loading, track-edit detection, braking curve,
collision protection, route creation, or multiplayer ownership. Remain nearby.
The full-train loading/recovery and reservation gates remain on the roadmap.
