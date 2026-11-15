# Test cycle 7: physical speed settings, station braking and independent holds

The player reports cycle 6 passed in singleplayer, including ramps, settings,
service/emergency stops, reload, and quitting/reopening while riding. Multiplayer
specific recovery remains unverified and is not required for this cycle.

Replace the old datapack folder with this version (rather than merging files,
so removed functions disappear), then `/reload` near the existing 20-cart train.
No rebuilding is required. Replace `ID` below with its numeric train ID.

## Configuration changes included in this cycle

```mcfunction
/function railway:api/train/configure_motion {train:ID,speed:7.5,accel:2.5,decel:2.5}
```

Speed is now **blocks/second**, from 0.05 to 20. Accel/decel remain independently
configurable in blocks/s² from 0.05 to 50. Supply all three fields. Defaults for
newly bound trains are 7.5/2.5/2.5. Existing configured rates are preserved, so use
the command above to set the new defaults on your existing train. Physical speed
is rounded to the nearest available fixed-point resolution (~0.0025 blocks/s);
inspection prints the effective speed. `fast`/`slow` functions are removed.

`emergency_stop` remains an immediate stop. `start` now resumes it directly,
clearing the emergency/manual request but respecting faults, station dwell and
blocked signals. The separate emergency-release function is removed. Confirm
these changes with one start/stop/emergency cycle; a normal stop from 7.5 blocks/s
now takes about 3 seconds with decel 2.5. Default acceleration still takes 3 seconds.

## New station approach test

1. Stop and wait until stationary. Apply the settings above, then arm a station:

   ```mcfunction
   /function railway:api/train/station_stop {train:ID,sample:0,dwell:100}
   /function railway:api/train/start {train:ID}
   ```

   `sample` is an integer 0–317 on this test loop; 0 is the original head-cart
   starting point on the north straight. `dwell` is 1–12000 ticks (100 = 5 seconds).
   It selects the next occurrence ahead, including a full lap if already at 0.
2. Expect controlled acceleration and braking, **exact arrival at sample 0**, a
   5-second hold, then acceleration/departure automatically. Inspect during dwell:
   state `dwelling`, progress sample 0, speed 0 and station distance 0. Check the
   middle/rear carts maintain spacing. Repeat the station command after departure
   to verify the head stops at the same location again.
3. After finishing that stop, repeat from rest with speed 20, accel/decel 2.5.
   The approach may deliberately never reach 20: the loop is only ~40 blocks and
   braking from 20 with decel 2.5 needs ~80 blocks. Reaching the stop safely is
   the expected behavior. Changing settings during an armed stop/dwell is refused.
4. After departure, a station request made too close at high speed should return
   0 with an explanatory message, leaving movement unchanged. Do not require an
   arbitrary request to succeed: normal braking distance must be available.

This is a backend stop target, not a station block or saved route yet. Only one
stop may be armed at a time. Track changes/chunk-boundary safety remain later work.

## Independent signal/manual stop test

```mcfunction
/function railway:api/train/set_signal {train:ID,blocked:1}
```

The train should service-brake and hold. `start` must not override the blocked
signal. Clear it with `blocked:0`: it should resume if a start request is active.
Repeat, but issue `stop` while waiting at the signal; clearing the signal must
leave it held until `start`. Repeat with `emergency_stop`, then `start` while
blocked: it must stay held until the signal clears. Clearing an already-clear
signal must not release a manual stop.

For a station/signal combination, arm sample 0 from rest, start, block/clear the
signal en route, and check the remaining station distance is preserved. It should
still stop exactly at 0. A signal left blocked through station departure must
prevent departure after the dwell expires. Do not request another station until
the current dwell finishes.

## Persistence and report

Reload and quit/reopen during an armed approach and during a signal hold. The
train should immediately pause, preserve settings, target distance, membership,
passenger and cargo, then continue appropriately after `start`; a blocked signal
must remain blocked. Station dwell time is counted only while the controller is
loaded/ticking. Reload never automatically restarts the train.

Report configuration changes, exact/repeated station arrival, dwell/departure,
independent holds, reload persistence, and any spacing/jitter issues at 7.5 or
20 blocks/s. No separate repeat of every previous test is needed.

## Existing composition commands

In Creative on clear flat ground:

```mcfunction
/function railway:api/train/spawn {normal:19,chest:1}
/function railway:api/train/rebuild {train:ID,normal:18,chest:2}
/function railway:dev/long_train {train:ID}
```

Spawn/rebuild support 1–64 carts, grouped normal then chest. Rebuild retires the
old ID and returns a new ID; loaded surviving carts/cargo are parked separately,
not deleted. Replacement chests are empty. Reserve 16×36 blocks along +X/+Z for
rebuilding. Stop and dismount first. Loop binding supports 1–24 carts; larger
trains need a longer route. All acceptance movement tests still use 20 carts.

## Implementation notes

Progress uses 1/1000 sample with interpolation. Station approach limits velocity
using exact discrete stopping distance and a bounded 13-iteration binary search.
Arrival consumes the remaining path distance exactly; emergency/fault/reload
holds preserve that distance. Manual, signal, station and integrity conditions
are independent. This is not yet physical signal blocks, shared-track reservation,
track-edit validation or arbitrary route creation. Remain near the loop.
