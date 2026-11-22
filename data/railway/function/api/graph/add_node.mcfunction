data modify storage railway:api result set value {ok:0b,error:"Use a draft graph and unique integer node 1..64."}
$data modify storage railway:graph_work raw.graph set value $(graph)
scoreboard players set #g_graph rw.sys 0
execute store result score #g_graph rw.sys run data get storage railway:graph_work raw.graph
execute store result storage railway:graph_work ctx.graph int 1 run scoreboard players get #g_graph rw.sys
$data modify storage railway:graph_work raw.node set value $(node)
scoreboard players set #g_node rw.sys 0
execute store result score #g_node rw.sys run data get storage railway:graph_work raw.node
execute store result storage railway:graph_work ctx.node int 1 run scoreboard players get #g_node rw.sys
execute unless score #g_graph rw.sys matches 1..2147483646 run return 0
execute unless score #g_node rw.sys matches 1..64 run return 0
return run function railway:internal/graph/add_node with storage railway:graph_work ctx
