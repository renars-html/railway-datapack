$execute unless data storage railway:geometry_work {requested_path:$(path)} run return 0
$execute unless data storage railway:graph paths.p$(path){state:"ready"} run return 0
$execute if data storage railway:geometry paths.p$(path){state:"ready"} run data modify storage railway:api result set value {ok:1b}
$execute if data storage railway:geometry paths.p$(path){state:"ready"} run tellraw @s {"text":"[Railway] This shared geometry is already compiled.","color":"aqua"}
$execute if data storage railway:geometry paths.p$(path){state:"ready"} run return 1
$execute store result score #geo_from rw.sys run data get storage railway:graph paths.p$(path).from
$execute store result score #geo_to rw.sys run data get storage railway:graph paths.p$(path).to
execute unless score #geo_from rw.sys = #geo_to rw.sys run return 0
$execute store result score #geo_edge_count rw.sys run data get storage railway:graph paths.p$(path).edges
execute unless score #geo_edge_count rw.sys matches 1..1071 run return 0
$data modify storage railway:geometry_work ctx.graph set from storage railway:graph paths.p$(path).graph
return run function railway:internal/geometry/new_job with storage railway:geometry_work ctx
