data modify storage railway:api result set value {ok:0b,error:"Use a sealed graph, existing from/to integer IDs, via list of up to 16 nodes; one path job at a time."}
execute if data storage railway:graph active_job run return 0
$data modify storage railway:graph_work raw.graph set value $(graph)
scoreboard players set #g_graph rw.sys 0
execute store result score #g_graph rw.sys run data get storage railway:graph_work raw.graph
execute store result storage railway:graph_work ctx.graph int 1 run scoreboard players get #g_graph rw.sys
$data modify storage railway:graph_work raw.from set value $(from)
scoreboard players set #g_from rw.sys 0
execute store result score #g_from rw.sys run data get storage railway:graph_work raw.from
execute store result storage railway:graph_work ctx.from int 1 run scoreboard players get #g_from rw.sys
$data modify storage railway:graph_work raw.to set value $(to)
scoreboard players set #g_to rw.sys 0
execute store result score #g_to rw.sys run data get storage railway:graph_work raw.to
execute store result storage railway:graph_work ctx.to int 1 run scoreboard players get #g_to rw.sys
$data modify storage railway:graph_work via set value $(via)
execute unless score #g_graph rw.sys matches 1..2147483646 run return 0
execute unless score #g_from rw.sys matches 1..64 run return 0
execute unless score #g_to rw.sys matches 1..64 run return 0
return run function railway:internal/path/create with storage railway:graph_work ctx
