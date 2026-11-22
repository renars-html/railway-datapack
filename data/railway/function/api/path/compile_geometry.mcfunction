data modify storage railway:api result set value {ok:0b,error:"Use a ready non-empty CLOSED path on the generated branch graph; one geometry job at a time."}
execute if data storage railway:geometry active_job run return 0
$data modify storage railway:geometry_work requested_path set value $(path)
scoreboard players set #geo_path rw.sys 0
execute store result score #geo_path rw.sys run data get storage railway:geometry_work requested_path
execute unless score #geo_path rw.sys matches 1..2147483646 run return 0
execute store result storage railway:geometry_work ctx.path int 1 run scoreboard players get #geo_path rw.sys
execute store result score #geo_queued rw.sys run function railway:internal/geometry/queue with storage railway:geometry_work ctx
execute unless score #geo_queued rw.sys matches 1 run tellraw @s {"text":"[Railway] Geometry rejected: path must be ready, closed, non-empty and use the current branch fixture. Inspect the topology path first.","color":"red"}
execute unless score #geo_queued rw.sys matches 1 run return 0
return 1
