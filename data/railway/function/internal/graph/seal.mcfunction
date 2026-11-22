$execute unless data storage railway:graph_work raw{graph:$(graph)} run return 0
$execute unless data storage railway:graph graphs.g$(graph){state:"draft"} run return 0
$execute store result score #g_count rw.sys run data get storage railway:graph graphs.g$(graph).node_ids
execute unless score #g_count rw.sys matches 1..64 run return 0
$data modify storage railway:graph graphs.g$(graph).state set value "sealed"
data modify storage railway:api result set value {ok:1b}
$tellraw @s {"text":"[Railway] Graph $(graph) sealed and immutable. New versions use a new graph ID.","color":"aqua"}
return 1
