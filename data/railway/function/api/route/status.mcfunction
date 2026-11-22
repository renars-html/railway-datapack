$execute unless data storage railway:routes routes.r$(route) run tellraw @s {"text":"[Railway] Unknown route ID.","color":"red"}
$execute unless data storage railway:routes routes.r$(route) run return 0
$data modify storage railway:route_work status set from storage railway:routes routes.r$(route)
$tellraw @s [{"text":"[Railway] Route $(route): "},{"type":"nbt","source":"storage","storage":"railway:route_work","nbt":"status","interpret":false}]
return 1
