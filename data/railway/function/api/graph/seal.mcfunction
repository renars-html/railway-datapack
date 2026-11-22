data modify storage railway:api result set value {ok:0b,error:"Graph must be a non-empty draft."}
$data modify storage railway:graph_work raw.graph set value $(graph)
scoreboard players set #g_graph rw.sys 0
execute store result score #g_graph rw.sys run data get storage railway:graph_work raw.graph
execute store result storage railway:graph_work ctx.graph int 1 run scoreboard players get #g_graph rw.sys
execute unless score #g_graph rw.sys matches 1..2147483646 run return 0
return run function railway:internal/graph/seal with storage railway:graph_work ctx
