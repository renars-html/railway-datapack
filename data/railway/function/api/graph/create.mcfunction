execute store result score #g_id rw.sys run data get storage railway:graph next_graph
execute if score #g_id rw.sys matches 2147483646.. run return 0
scoreboard players add #g_id rw.sys 1
execute store result storage railway:graph next_graph int 1 run scoreboard players get #g_id rw.sys
execute store result storage railway:graph_work ctx.graph int 1 run scoreboard players get #g_id rw.sys
function railway:internal/graph/create with storage railway:graph_work ctx
tellraw @s [{"text":"[Railway] Created draft graph "},{"score":{"name":"#g_id","objective":"rw.sys"}}]
return 1
