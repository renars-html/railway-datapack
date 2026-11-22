# Performance and persistent loading

## What is known

The player has verified motion, exact repeatable center stops across different
speeds/rates, signals/overrides and singleplayer reload/quit persistence. No MSPT,
CPU profile, high-train-count benchmark, or dedicated-server result is available.
There is no defensible train-capacity number yet. A 20-cart functional test does
not establish that 80–99 such trains will maintain 20 TPS.

80 × 20 carts = 1,600 real ticking minecarts; 99 × 20 = 1,980. At 64 carts/train,
80 trains would be 5,120 entities. Entity physics, client rendering, packet updates,
chunk simulation, datapack commands, and route data all contribute. Capacity
must be specified by **total carts, unique loaded chunks, traffic density and
hardware**, not just train count. Singleplayer also shares CPU with rendering.

The existing fixture is still a prototype. Runtime normal selection uses local
entity sections within 110 blocks of the generated loop origin, replacing whole-
dimension train-member queries. This bound covers these fixtures only; future
arbitrary routes need spatial dispatch from train positions or shared route tiles.
Dense yards can still make per-train selection scale poorly. Emergency recovery
intentionally retains global loaded-member selection to recover displaced carts.

## Changes in this version

- One full UUID/index verification per member per tick, with a current-tick stamp
  reused for movement. Previously verification ran twice. Missing-member detection
  still runs before every advancement; this is not a once-per-second safety audit.
- One precompiled sample fetch instead of two. Integer interpolation origins and
  slopes are compiled once. Only changing coordinate axes are evaluated, with
  static kernels to avoid instantiating large numeric macros for every position.
- Normal runtime uses spatially bounded selection. Admin inspection/start/bind
  validation remains global, and is not run routinely per tick.
- `dev/performance_report` provides loaded train/cart workload counts. It does not
  pretend these counts or fewer commands are measured server-time improvements.

There are still two member-selection passes per train, dense per-sample route
storage, per-cart teleport/velocity writes, station approach searches, and vanilla
minecart ticking. Stopped trains still receive corrections and UUID checks every
tick, so stopped-versus-moving is not an empty-pack baseline. These costs must be
measured. Compiled graph edges/segments and shared block dispatch remain priorities
before claiming high-double-digit support. Sparse/native movement alternatives
remain an investigation if measured budgets cannot be met with this controller.

`tools/compile_paths.py` regenerates interpolation metadata from the stored fixture
samples. Minecraft ignores this development-only Python file. The datapack needs
no Python installation or build step to run.

## Persistent test-loop loading

```mcfunction
/function railway:api/network/load_test_loop
/function railway:api/network/unload_test_loop
```

The first command force-loads the current generated loop's chunk rectangle in the
Overworld, with a strict **64-chunk fixture lease cap** (the large fixture occupies
at most 24 depending on alignment). It also covers the controller's fixed origin.
It does not scan arbitrary rails. Native tickets persist over reload and world/
server restart. No load/unload commands run per train tick.

Each chunk is queried first. The lease records whether this pack added its ticket;
unload removes only those tickets and preserves pre-existing forced chunks. Partial
load/release failures retain the lease for cleanup/retry. Unload immediately pauses
prototype trains before releasing tickets; it never removes carts or cargo. Loop
relocation and fixture cleanup require lease release first. Re-enable after moving
the fixture. Do not manually change tickets covered by a lease: vanilla tickets do
not have independent per-pack owners, so concurrent administrative changes cannot
be distinguished. Broader cross-pack ticket coordination is future work.

The production design now requires always-loaded **registered railway chunks**.
It will use a persistent unique-chunk registry with route/network reference counts,
explicit ownership, overlap deduplication, a configurable global budget and admin
reporting. Route publication acquires all required tickets once; retiring the last
reference releases pack-owned tickets. Reject publication if the budget is exceeded.
The fixture lease is an initial test adapter, not that complete multi-network system.

Force-loading also simulates other entities/redstone in those chunks. Use the union
of railway chunks for planning; overlapping routes should not multiply that count.

## First timing measurements (singleplayer is sufficient)

1. Keep the current 20-cart train, settings and view/simulation distance fixed.
   Run `dev/performance_report` and note the train/cart counts.
2. While stopped, run `/tick query` directly several times over ~30 seconds. Note
   the reported average tick time, not only FPS. Repeat during normal 7.5 blocks/s
   motion, 20 blocks/s motion and a station approach. Avoid world generation and
   unrelated gameplay during measurement.
3. For a CPU breakdown, `/debug start`, run the test for 60 seconds, then
   `/debug stop`. Minecraft reports the profile location. It is optional to send
   the resulting profile, but it can show whether functions, entities or chunk
   simulation dominate. Profiling itself has overhead; compare like with like.
4. Repeat after enabling the loading lease, keeping the same player position.
   Then travel at least 300 blocks away and check twice with train inspection:
   loaded count stays 20 and progress changes while running. Return and verify
   inventory and station accuracy. Reload/quit retains the lease. Eligible normal running intent now resumes after
   validation; manual/emergency holds stay held. Inspection works remotely.
5. Optional: repeat with 64 carts on the large loop, preserving cargo through the
   rebuild workflow. This measures cart-count growth for one train, not the
   per-train selection cost of 64 separate trains.

An empty/idle baseline needs a comparable copy of the world before adding trains,
with the same forced chunks and distances. Disabling the datapack changes cart
physics and is not an equivalent stopped-train baseline.

A tick has a 50 ms budget at 20 TPS. Report absolute average MSPT and variability,
not just whether TPS remains 20. Keep headroom for players and normal survival
activity. Release capacity will require multiple independent trains/routes at
10/25/50/80/99 trains, 20 carts each, both dispersed and in shared yards, with the
same loaded-chunk set and separately measured vanilla/entity costs. The singleton
test loop cannot represent that benchmark; generated multi-route graph fixtures
and compact route compilation are the next backend phase.

The player subsequently confirmed one-train operation at simulation distances 5
and 12, maintaining 20 TPS. MSPT/CPU measurements and fleet capacity remain unknown;
further performance testing is deferred. Ordered loop routes now share compiled
braking tables and skip the per-tick approach search outside the braking corridor.
This is an architectural change, not a measured timing improvement.

Graph-path service now keys braking caches by geometry ID as well as profile,
cruise speed and deceleration. Healthy reload recovery uses a short validation
phase and then normal acceleration; it adds no extra per-cart movement work on
the steady-state path. This is not a new capacity measurement. Fleet-scale
profiling remains deferred as requested.
