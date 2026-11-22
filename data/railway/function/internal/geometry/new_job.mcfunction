$execute unless data storage railway:edge_geometry graphs.g$(graph).edges run return 0
$execute store result score #geo_profile rw.sys run data get storage railway:edge_geometry graphs.g$(graph).profile
execute unless score #geo_profile rw.sys = #base_profile rw.sys run return 0
$data modify storage railway:geometry paths.p$(path) set value {state:"compiling",frames:[]}
$data modify storage railway:geometry job set value {path:$(path),graph:$(graph),stage:"edges",index:0,total:0,direct:0,detour:0}
execute store result storage railway:geometry job.profile int 1 run scoreboard players get #geo_profile rw.sys
$data modify storage railway:geometry active_job set value {path:$(path),graph:$(graph)}
data modify storage railway:api result set value {ok:1b}
$tellraw @s {"text":"[Railway] Geometry for path $(path) queued. Check geometry_status; compilation is resumable and bounded.","color":"aqua"}
return 1
