$execute unless data storage railway:route_work path_request{path:$(geometry)} run return 0
$execute unless data storage railway:geometry paths.p$(geometry){state:"ready"} run return 0
$execute store result score #route_path_profile rw.sys run data get storage railway:geometry paths.p$(geometry).metadata.profile
execute unless score #route_path_profile rw.sys = #base_profile rw.sys run return 0
$execute store result score #fine_length rw.sys run data get storage railway:geometry paths.p$(geometry).metadata.fine_length
$execute store result score #speed_factor rw.sys run data get storage railway:geometry paths.p$(geometry).metadata.speed_factor
return 1
