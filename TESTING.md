# Test cycle 11: branching-graph pathfinding backend

The player confirms automatic ordered loop service and cache reuse pass. Reload
currently pauses normal service, including during dwell, and requires `start`.
Automatic restoration of service intent/dwell timing remains a roadmap gate.
This cycle does not change that policy or the working loop movement.

Update and `/reload`. These tests create **virtual topology data only**: they do
not place rails, move trains, alter stations, or change your assigned service route.
No performance test or repeat of the previous movement tests is needed.

## Generate the branching fixture

```mcfunction
/function railway:dev/graph_fixture
```

Note the printed **graph ID**, which is independent of train/service-route IDs.
Expect a sealed graph with 9 nodes and 10 directed edges. Rerunning inspects the
same graph rather than creating another. Its weighted branches are:

- 1 → 2 → 3 → 6: cost 30.
- 1 → 2 → 4 → 5 → 6: cost 25 (shortest).
- 1 → 7 → 6: cost 55.
- 6 → 1: cost 20; 6 → 8: cost 7.
- Node 8 is a dead end; node 9 is isolated.

Costs are positive integer test weights, not physical block distances yet.

## Path selection and ordered waypoints

Replace GRAPH with the graph ID; replace PATH with each newly printed path ID.
Only one path compilation job is accepted at a time. Wait for completion before
submitting the next. The unpaused world must tick; these small jobs take seconds.

```mcfunction
/function railway:api/path/create {graph:GRAPH,from:1,to:6,via:[]}
/function railway:api/path/status {path:PATH}
```

Expect `state:"ready"`, `nodes:[1,2,4,5,6]`, `edges:[1,4,5,6]`, `cost:25`.

Repeat with these arguments and compare ready results:

| From | To | Via | Expected nodes | Cost |
| --- | --- | --- | --- | --- |
| 1 | 6 | `[3]` | `[1,2,3,6]` | 30 |
| 1 | 6 | `[7]` | `[1,7,6]` | 55 |
| 1 | 8 | `[6,2]` | `[1,2,4,5,6,1,2,4,5,6,8]` | 77 |
| 6 | 6 | `[]` | `[6]` with empty edges | 0 |

`via` nodes are mandatory **in order**, but do not imply stopping/dwell. The same
node can legitimately appear more than once as consecutive legs traverse a cycle.

## Failure and persistence checks

- From 8 to 1, or from 1 to 9, with `via:[]`: expect `state:"failed"`, an error,
  and **no partial nodes/edges published**.
- From 1 to 6 with `via:[99]`: invalid waypoint must fail similarly. The existing
  valid paths and loop service must be unchanged.
- Start the `[6,2]` job and immediately `/reload`. It should eventually produce
  the same ready path and cost 77. A quit/reopen during compilation should work
  the same way. Normal trains still pause on reload and require manual start.
- Inspect an earlier ready path after other jobs: contents must remain unchanged.
- Try editing the sealed fixture:

  ```mcfunction
  /function railway:api/graph/add_edge {graph:GRAPH,from:1,to:8,cost:1}
  ```

  Expect return 0. Inspect with `api/graph/inspect {graph:GRAPH}`: still 10 edges.
  Repeating the original 1→6 query must still give cost 25.

Report returned states, node/edge sequences, costs, persistence and any command/
function-loading errors. No full new rail-layout or train ride test is required.

## Backend scope and API

`api/graph/create`, `add_node {graph:G,node:N}`, `add_edge
{graph:G,from:A,to:B,cost:C}`, `seal {graph:G}` and `inspect {graph:G}` build and
inspect topology. Nodes are integer IDs 1–64; edges are directed, with positive
integer costs 1–1,000,000 and at most 256 edges. A sealed graph is immutable;
changes require a new graph ID, so published paths remain stable.

The Dijkstra worker initializes labels, scans a bounded minimum frontier, relaxes
outgoing edges and reconstructs predecessors. Each tick processes at most eight
node/edge/backtracking operations in its current phase. State, cursors, labels and
partial results live in storage; there are no worker entities or world scans.
Up to 16 via nodes are supported. Only complete successful paths become ready.

Published **path IDs are topology results**, not the existing loop-service route
IDs. Do not pass them to train/assign_route yet: the next layer adds generated edge
geometry and makes the route compiler consume these paths for actual branching
movement. Physical conflict groups, occupancy/reservations, manual rail discovery,
and survival controls remain later work. Current trains continue using the
previously verified loop route controller.
