# Railway datapack

Minecraft Java **26.3**, data pack format **121.0**. Operator-driven backend in
active development. See [ROADMAP.md](ROADMAP.md) and the current combined test in
[TESTING.md](TESTING.md). No Python, build step or dependencies are needed to run.

## Installation

Replace the pack folder in your world's datapacks directory, with pack.mcmeta at
its root. Run `/reload` and `/datapack list enabled`. Replacing instead of merging
removes obsolete functions. A ZIP with pack.mcmeta/data at its root also works.

## Backend

Persistent train/member/controller UUIDs, explicit membership, 1–64 normal/chest
cart compositions, fractional movement, physical speed/rates, manual/signal holds,
service/emergency control, saved train-center stations, immutable graphs and
waypoint-aware Dijkstra, shared geometry compilation, automatic ordered service,
profile caches, persistent fixture loading and revalidated automatic recovery.

Function namespaces: `api/train/` for train operations, `api/route/` for service
routes, `api/graph/` and `api/path/` for topology/geometry, `api/network/` for fixture
loading, `dev/` for test helpers, `internal/` for implementation. These remain
operator APIs; ownership enforcement and survival interactions are future work.

The track geometry is generated/stored; physical rail edits do not reroute trains.
The small/large/branch builders are destructive test fixtures (documented in prior
tests). The branch fixture uses a 76×36×6 volume; old terrain cannot be restored.
The current test harness permits one bound train and sets switches only while
stopped/unoccupied. Shared-traffic reservations and runtime switch locks are next.

## Current controls

- `configure_motion {train:T,speed:7.5,accel:2.5,decel:2.5}` uses blocks/s and
  blocks/s². Default speed 7.5, max ~20; rates round to .5 and clamp to 2–5.
- `start`, `stop`, `emergency_start`, `emergency_stop`, `set_signal` and `inspect`
  control/query the train. Override jumps to max and bypasses operational holds;
  normal start/stop restores normal rules. There is no separate emergency release.
- `spawn` / `rebuild` create grouped normal/chest compositions. Rebuild retires the
  old ID, preserves/parks loaded survivors and cargo, and returns a new train ID.
- `assign_path` / `clear_path` select shared compiled closed geometry. `clear_route`
  is required before changing a service route's geometry.

Graph paths and service-route IDs are different resources. After path creation,
compile_geometry creates shared movement frames. Register centers using
`dev/path_station_here {path:P,station:S}`; `api/route/create_path` snapshots those
stations and the selected path/profile. `assign_route` starts ordered service on
an already matching path. The legacy `dev/station_here` / `api/route/create`
continue to support the default loop. TESTING.md contains complete commands.

Reload/quit now automatically restores eligible normal running intent after
readiness checks; manual stops and emergency states stay held. Dwell time freezes
during recovery/manual pause. Missing/invalid readiness eventually faults without
spawning replacements. Native fixture loading tickets persist and are released
only when pack-owned; see [PERFORMANCE.md](PERFORMANCE.md). Server/disconnect and
crash consistency are not yet validated. Fleet profiling is deferred.

All human documentation uses .md and development tools use .py, which Minecraft
ignores. Only actual runtime resources use .mcfunction, resource .json and
pack.mcmeta; resource directories use singular names such as function.
