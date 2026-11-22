# Railway backend roadmap

Target: Minecraft Java Edition **26.3**, data pack format **121.0**.
Status: the player confirms the one-train loading/movement tests pass at
simulation distances 5 and 12 with 20 TPS; fleet-scale profiling is explicitly
deferred. The next backend slice adds immutable ordered loop routes, resumable
shared braking-profile compilation, automatic station cycling and per-train route
assignment/cursors, awaiting [cycle 10 tests](TESTING.md). This is a directed-cycle
compiler, not general junction pathfinding. Geometry is shared, and compatible
routes reuse a braking table instead of calculating it per train/lap. Multiplayer
recovery and high-double-digit fleet capacity remain unverified.

Build a command-driven backend first. Crafting, coupling tools, station blocks,
player menus, redstone interfaces, and survival costs come after the backend
passes the milestones below. Use real minecart entities and ordinary rail tracks.
Initially support routes inside one dimension, forward travel, and an explicitly
limited set of rail configurations. Expand that set through tested milestones.

## Roadmap and acceptance gates

| Order | Milestone | Backend work | Done when |
| --- | --- | --- | --- |
| 0 | Verify movement on 26.3 | Test command-controlled empty and occupied carts, retained passengers, gravity, collision, slopes, curves, stop holding, and entity loading. Test vanilla minecart behavior with the world's actual settings. | A passenger can ride a controlled cart through the supported geometry without dismounts, persistent drift, or unacceptable jitter. Record the supported settings and geometry before implementing the rest. |
| 1 | Core runtime | Add idempotent load/tick entry points, persistent IDs, train/cart registration, configuration, bounded job processing, diagnostics, and schema versioning. | Reloading preserves registrations and state; two registered trains have independent IDs and data. Unregistered minecarts are untouched. |
| 2 | One working train | Use a manually registered short test path; create one train controller, ordered cart membership, distance-based spacing, and a shared speed/progress update. | Three carts follow the same path through straights, curves, and slopes with stable spacing during acceleration and braking. Cargo and passenger tests pass. |
| 3 | Stop and start | Prioritize smooth, configurable acceleration/deceleration in blocks/s²; add fractional progress, start, service braking, a latched emergency stop, independent stop reasons, target speed and stationary holding. | Every cart stops as one train, stays stopped on supported slopes and powered rails, and resumes without spacing changes. Removing one stop reason cannot override another. |
| 4 | Track graph and reusable routes | Register stations/waypoints, discover track in bounded jobs, build a directed graph, run creation-time pathfinding, and publish versioned shared routes. | Two trains use the same completed route without running pathfinding while travelling. Ordered waypoints, unreachable destinations, and explicit route rebuilding work. |
| 5 | Stations and traffic control | Add station stop positions, dwell timers, conflict sections, reservations, junction locks, and signal-derived stop reasons. | Opposing trains cannot enter the same reserved conflict section. A junction remains locked until the final cart clears it. Trains stop accurately at stations. |
| 6 | Multiplayer reliability and performance | Handle partial chunk loading, reload/restart reconciliation, broken track, missing carts, concurrent requests, ownership, and profiling. | Recovery never duplicates a cart or frees an occupied section merely because it unloaded. Measured operating limits and repeatable server benchmarks are documented. |
| 7 | Survival interaction layer | Connect survival interactions to the proven function API; add recipes, costs, permissions, feedback, and cleanup rules. | Players can create trains and routes without operator commands while the backend retains the same validation and limits. |

Each gate must pass before dependent features are considered complete. Reliability
and performance constraints apply throughout, even though milestone 6 tests them
together under load.

## Movement and train control

### Proposed movement backend

Use one authoritative controller per train, rather than independent cart AI.
The first candidate is command-controlled movement of real carts along a stored
rail path. Keep the movement operations behind internal functions so milestone 0
can change their implementation without changing routes or station logic.

Teleportation, velocity writes, gravity control, and collision behavior must be
tested together on 26.3. Moving a ridden minecart through commands must preserve
its passengers and inventories. Do not assume that setting Motion to zero once
will hold a cart, or that NoGravity disables rail propulsion or collision.
Do not use visual display entities as a substitute for working minecarts.
If the candidate fails the rider or physics gate, investigate a vanilla-motion
backend with path tracking and measured coupling correction before proceeding.

Represent the rail path as directed geometric segments with lengths and entry/
exit directions. A curve follows the actual rail geometry; interpolating directly
between block centers would cut corners. Slopes need tested height offsets and
orientations. Keep runtime progress as bounded, segment-local fixed-point integers
to avoid overflowing scoreboard values far from spawn or on long journeys.

Emergency start immediately selects maximum speed, bypasses operational holds
and cancels a station plan for manual recovery. It moves only loaded UUID-verified
members; it cannot move missing carts. Normal start/stop exits override and
restores normal rules, while emergency stop and reload cancel it immediately.

Advance the train once per tick. Each cart has a fixed distance behind the train
reference point and its own cached segment cursor. Evaluate its position on the
same path at that distance. This preserves spacing through speed changes; a
fixed delay in ticks would not. Only walk across segments that a cart actually
crosses, rather than searching the entire route each tick.

Registration requires enough validated track behind the reference point for the
whole train. Include approach/departure geometry at stations and full train
clearance at route boundaries. For the first implementation, departure is forward
and a reverse journey uses a separately compiled directed route. Later reversal
requires explicit handling of cart order, path history, and occupied sections.

### Train state and stop rules

Use states such as `stopped`, `running`, `braking`, `waiting`, `suspended`, and
`faulted`. Track independent stop reasons: manual request, station dwell, denied
reservation, unavailable chunks, invalid track, missing cart, and emergency.
Start removes the manual stop request; it never clears safety-related reasons.

Acceleration/deceleration are configurable independently per train. First use
linear speed ramps with fractional path progress so low acceleration does not
quantize to whole path samples. Consider optional jerk limits/easing only after
the basic ramps are verified. Lowering cruise speed uses service deceleration;
manual stop requests target zero. Emergency/fault/reload holds bypass the ramp.

Plan braking from remaining path distance and configured deceleration, including
a conservative tick margin. Milestone 0 must establish a reliable hard stop and
stationary hold. Emergency stop bypasses normal braking and freezes the entire
controlled train at its current validated positions. Check every path section
crossed in a tick, and cap speed to the validated movement/clearance budget.

## Track discovery, pathfinding, and route reuse

1. Register stations, ordered waypoints, and initial track access points through
   functions. Give stations a direction, stop offset, and platform clearance.
2. Discover physical rails with a resumable, budgeted traversal. Read rail shape,
   connectivity, height, and travel direction. Bound rail count and search area;
   require relevant chunks to be available instead of scanning the whole world.
3. Compress uninterrupted track into edges between stations, waypoints, junctions,
   and conflict boundaries. Preserve the underlying geometry for cart movement
   and local track validation. Model incoming direction and legal junction states;
   connecting every adjacent rail block would allow impossible turns.
4. Run Dijkstra over the directed graph when the player creates a route, separately
   between successive mandatory waypoints. Use distance as the first cost metric.
   Keep the frontier, predecessors, and reconstruction in a persistent job so
   large searches span ticks. Cap graph size, work per tick, and queue length.
5. Compile the result into ordered segment references, cumulative lengths,
   fixed station-center targets, following-block occupancy boundaries, conflict
   sections, and required junction settings. Precompute station/signal braking
   entry points for deceleration profiles 2, 2.5, 3, 3.5, 4, 4.5 and 5 blocks/s²
   at the route cruise speeds. Cache departure/acceleration profiles likewise;
   share those tables across trains. Include profile/speed in the cache key,
   generating a missing profile once when configuration changes. Train-length
   offsets remain per-consist arithmetic, not a duplicate route. The dynamic
   safe-speed solver is the temporary test implementation until compilation. Publish only
   a complete, validated route. Failed/cancelled jobs never expose partial routes.
6. Every train references the same immutable route ID and revision. Keep only
   per-train progress, speed, cart cursors, and reservation state separately.
   Route following does no graph search and does not copy the entire route.

Route computation happens once **per route revision**. Congestion changes stopping
and reservations, not the selected path. An edit creates a new revision; active
trains retain the old one until a safe reassignment. Retain referenced geometry
until no train needs it, including geometry still underneath trailing carts.

Survival track edits can invalidate a cached route. The datapack cannot cheaply
observe every arbitrary block change worldwide. Validate a bounded corridor ahead
of moving trains, extending beyond braking distance and the next movement step.
Validate the whole train footprint before departure/resume and audit occupied
track within a defined budget. Stop on a mismatch; require explicit repair and
rebuild. Immediate detection of every edit anywhere is not a backend guarantee.

## Stations, signals, and shared track

Stations store a player-selected route position for the **center of the train**
(midpoint along its path, not the head or an axis-aligned bounding box). Convert
that to a head target using the ordered consist length; repeated approaches must
stop the same center at the same marker. Stations add a stop target and dwell
timer to the existing stop system. A signal is a station-like stopping boundary: stop only when its following
track block/conflict section is occupied or unavailable. Following-block occupancy
and boundaries are compiled at route creation, with tail-clear release. An
operator boolean is the current test adapter; physical signal interaction comes
after the backend. Emergency override may deliberately bypass these conditions. Reserve physical conflict sections so routes in opposite directions
still contend for the same track. Include crossing and junction conflicts.

Before entering a conflict area, atomically acquire the complete next safe
movement authority, including an available exit/holding area. Process requests
serially with deterministic priority and aging. Denied requests acquire nothing,
which avoids partial reservation cycles; document the limits of this initial
scheme for complex networks. Never promise general deadlock freedom from simple
per-section locks alone.

Keep a section reserved until the train's rear clears it. Hold physical switches
in the required state for the whole train passage if the chosen movement backend
needs them; reject unsupported junctions until actuation and external redstone
interference are tested. No train may start unless its complete stopping envelope
is validated and protected.

## Persistent data and function boundaries

Use the existing `railway` namespace. Public names below are planned interfaces,
not commands already supplied by this pack.

| Area | Planned functions | Main data |
| --- | --- | --- |
| Lifecycle | `railway:load`, `railway:tick`, `railway:admin/status` | Schema version, monotonic ID counters, limits, bounded job queues |
| Train API | `railway:api/train/create`, `attach`, `assign_route`, `start`, `stop`, `emergency_stop`, `inspect`, `remove` | Train ID, owner UUID, dimension, ordered cart UUIDs, route revision, state, cursors, speed, stop reasons |
| Network API | `railway:api/station/register`, `railway:api/waypoint/register`, `railway:api/network/scan` | Directed track geometry, stations, waypoints, conflict sections, network revisions |
| Route API | `railway:api/route/create`, `status`, `rebuild`, `delete` | Immutable compiled routes and resumable construction jobs |
| Internal modules | `railway:internal/movement/*`, `jobs/*`, `traffic/*`, `recovery/*` | Temporary execution context and validated lookup caches |

Store hot numeric state in namespaced scoreboard objectives and persistent
records in command storage, partitioned by stable IDs and dimension. One tagged
marker controller per train is the initial entity budget; no marker per track
block or pathfinding node. Tag managed carts and store train ID/cart index scores
on them. UUIDs are authoritative membership references; never infer membership
using nearest-entity selectors.

Use scalar macro arguments for validated IDs/indices where necessary. Route
tables remain storage data interpreted by a fixed set of shipped functions:
vanilla functions cannot write new `.mcfunction` files while the game is running.
Avoid repeatedly copying large NBT lists. The cursor/index lookup strategy itself
must be benchmarked rather than assuming storage arrays have constant-time access.

Every public API validates arguments, ownership, dimension, entity type, existence,
and operation state before committing changes. Initial operator tests invoke
functions directly; later player interactions call the same API. Scratch state
must be reset per operation. Jobs retain their own state across ticks, and
scheduled functions must restore executor/dimension/context explicitly.

## Chunk loading, recovery, and multiplayer

Keep **all registered railway chunks persistently loaded**, per the user's
network requirement. Acquire native tickets at route/network publication, not
on each train tick. Deduplicate chunks across route revisions with reference
counts, track pre-existing versus pack-owned tickets, preserve ownership across
reload/restart, and release only the pack's last reference. Add a configurable
network/global chunk budget, reporting, partial-acquisition rollback and cleanup.
Reject a new route publication if its full required loading footprint exceeds
budget. The current bounded test-loop lease is the first adapter for this design.

A train still needs validated membership, geometry and an entity-ticking stopping
envelope. Ticket presence alone is not a proof that every entity is already
available immediately after a load/restart; reconcile before starting. Registration defines the loading footprint; physical rail blocks outside the
registered network are not discovered yet.

Persist train state so a completely unloaded train remains registered. Partial
unloading suspends the train; do not move only the loaded carts. Retain occupied
sections and uncertain reservations while suspended. A missing selector result
does not prove destruction: distinguish unavailable chunks from a cart confirmed
missing in an entity-ticking area. On a fault, preserve remaining carts and cargo;
never respawn inventory-bearing carts as an automatic repair.

On reload/restart, initialize only absent data, reconcile controllers and carts,
and validate reservations before resuming. Never start all trains automatically
from an unverified saved `running` flag. Ownership uses player UUIDs, with explicit
sharing/administration hooks and per-owner quotas for the later survival layer.
Serialize competing route edits and reservations. Persistent loading needs bounded tickets, ownership, reference counting and
cleanup; it is now a network prerequisite, rather than an optional feature.

## Scale target and architecture priorities

Target high-double-digit fleets explicitly: benchmark 10/25/50/80/99 independent
trains, normally 20 carts each and optionally 64, with dispersed corridors and
congested yards. No capacity claim until MSPT/CPU profiles and unique loaded-chunk
counts are recorded on reference hardware. The total 50 ms tick budget must retain
headroom for survival players, mobs and redstone. Dense sampled paths, per-train
cross-entity scans, full per-cart command motion and vanilla entity ticking are
current scaling risks; reducing command counts alone is not a timing benchmark.

Prioritize compact compiled rail segments and route spatial buckets over extending
the dense fixture format. Avoid repeated whole-dimension selection per train.
Batch dispatch/cart membership once where possible and reuse current-tick UUID
verification. Keep creation-time route/profile compilation separate from the hot
path. Benchmark before committing to the same per-cart controller at fleet scale.

## Tick budget and verification

- Update moving/braking trains every tick. Recheck waiting trains and maintenance
  on slower staggered schedules, with prompt wake-ups for explicit start requests.
- Use typed/tagged selectors and cached membership. Avoid nested global scans,
  per-train network searches, and one worker entity per rail block.
- Give discovery, pathfinding, reconciliation, and diagnostics separate bounded
  work quotas. A busy creation queue must not starve train movement or safety.
- Enforce maximum train length, speed, graph size, route size, job count, and total
  active carts. Determine release limits from measurements, not assumed capacity.
- Target runtime work proportional to active carts plus nearby route checks and
  crossed boundaries. Count storage/selector costs as well as command counts.
- Profile idle, 1/10/50 active trains with 3 and 8 carts each, increasing route
  lengths, and multiple simultaneous route jobs. These are test points, not
  promised supported capacities. Record hardware, vanilla settings, baseline and
  added MSPT, tail latency, command counts, and memory/storage growth. Set a
  documented tick-time budget from those results and enforce operating limits.

Acceptance worlds must cover curves, slopes, powered rails, station approach,
stop/resume, emergency stops, riders, cargo, two trains sharing a route, opposing
traffic, junction interference, broken rails, destroyed carts, partial unloading,
owner disconnects, reload, and server restart. Verify behavior on the actual 26.3
server. Metadata checks alone do not validate commands or minecart physics.

## File rules and next implementation slice

All human documentation uses `.md`, which Minecraft ignores. Keep scripts,
benchmark notes, and other development files outside runtime resource directories
and in ignored formats. Only actual runtime resources use `.mcfunction`, registry
`.json`, or `pack.mcmeta`; do not create placeholder runtime resources for planning.

Next: verify automatic station ordering, shared profile reuse, immutable route
snapshots, holds and reload persistence on the generated loop. Then extend the
compiler with a generated branching graph, explicit waypoints and time-sliced
pathfinding, followed by following-block boundaries and occupancy/reservations.
Compact segment geometry and multi-route chunk references remain design targets;
fleet-scale performance testing is deferred at the user's request. Manual rail
adapters and survival interactions follow the core backend gates.

Version reference: [official Java Edition 26.3 release notes](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-3),
Technical Changes (data pack version 121.0). The movement design above is proposed
and requires in-game testing; it is not a claim of verified 26.3 physics support.
