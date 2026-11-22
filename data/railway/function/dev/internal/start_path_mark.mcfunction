$execute unless data storage railway:scratch path_mark_request{path:$(geometry)} run return 0
$execute unless data storage railway:geometry paths.p$(geometry){state:"ready"} run return 0
$execute store result score #mark_requested_profile rw.sys run data get storage railway:geometry paths.p$(geometry).metadata.profile
execute unless score #mark_requested_profile rw.sys = #base_profile rw.sys run return 0
execute store result score #mark_started rw.sys run function railway:dev/station_here with storage railway:scratch path_mark_request
execute unless score #mark_started rw.sys matches 1 run return 0
$scoreboard players set #mark_path rw.sys $(geometry)
$execute store result score #mark_length rw.sys run data get storage railway:geometry paths.p$(geometry).metadata.count
return 1
