$execute unless data storage railway:graph paths.p$(path) run return 0
$data modify storage railway:path_work status set from storage railway:graph paths.p$(path)
$tellraw @s [{"text":"[Railway] Path $(path): "},{"type":"nbt","source":"storage","storage":"railway:path_work","nbt":"status","interpret":false}]
return 1
