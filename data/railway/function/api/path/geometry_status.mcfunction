$execute unless data storage railway:geometry paths.p$(path) run return 0
data modify storage railway:geometry_work summary set value {}
$data modify storage railway:geometry_work summary.state set from storage railway:geometry paths.p$(path).state
$data modify storage railway:geometry_work summary.metadata set from storage railway:geometry paths.p$(path).metadata
$data modify storage railway:geometry_work summary.error set from storage railway:geometry paths.p$(path).error
$tellraw @s [{"text":"[Railway] Geometry $(path): "},{"type":"nbt","source":"storage","storage":"railway:geometry_work","nbt":"summary","interpret":false}]
return 1
