$execute unless data storage railway:graph_work raw{graph:$(graph),from:$(from),to:$(to),cost:$(cost)} run return 0
$execute unless data storage railway:graph graphs.g$(graph){state:"draft"} run return 0
$execute unless data storage railway:graph graphs.g$(graph).nodes.n$(from) run return 0
$execute unless data storage railway:graph graphs.g$(graph).nodes.n$(to) run return 0
$execute store result score #g_edge rw.sys run data get storage railway:graph graphs.g$(graph).next_edge
execute unless score #g_edge rw.sys matches 0..255 run return 0
scoreboard players add #g_edge rw.sys 1
execute store result storage railway:graph_work ctx.edge int 1 run scoreboard players get #g_edge rw.sys
return run function railway:internal/graph/store_edge with storage railway:graph_work ctx
