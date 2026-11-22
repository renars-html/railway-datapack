execute unless score #stop_id rw.sys matches 1..64 run return 0
# Source index must exist and contain the exact canonical integer.
$execute unless data storage railway:routes jobs.j$(route).input[$(index)] run return 0
$data modify storage railway:route_work canonical_id set value $(station)
# Compare tags by trying to overwrite a copy of the input value.
execute store success score #changed rw.sys run data modify storage railway:route_work canonical_id set from storage railway:route_work raw_id
execute unless score #changed rw.sys matches 0 run return 0
$execute unless data storage railway:stations stations.s$(station) run return 0
$execute store result score #station_profile rw.sys run data get storage railway:stations stations.s$(station).profile
$execute store result score #route_profile rw.sys run data get storage railway:routes jobs.j$(route).draft.profile
execute unless score #station_profile rw.sys = #route_profile rw.sys run return 0
scoreboard players set #station_geometry rw.sys 0
$execute if data storage railway:stations stations.s$(station).geometry store result score #station_geometry rw.sys run data get storage railway:stations stations.s$(station).geometry
$execute store result score #route_geometry rw.sys run data get storage railway:routes jobs.j$(route).draft.geometry
execute unless score #station_geometry rw.sys = #route_geometry rw.sys run return 0
$data modify storage railway:route_work entry set value {station:$(station)}
$data modify storage railway:route_work entry.sample set from storage railway:stations stations.s$(station).sample
$data modify storage railway:routes jobs.j$(route).draft.stops append from storage railway:route_work entry
return 1
