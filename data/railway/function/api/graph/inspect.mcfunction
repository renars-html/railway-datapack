$execute unless data storage railway:graph graphs.g$(graph) run return 0
$data modify storage railway:graph_work summary set from storage railway:graph graphs.g$(graph)
$tellraw @s [{"text":"[Railway] Graph $(graph): "},{"type":"nbt","source":"storage","storage":"railway:graph_work","nbt":"summary","interpret":false}]
return 1
