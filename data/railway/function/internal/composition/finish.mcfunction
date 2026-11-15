$execute store result score #actual rw.sys run data get storage railway:state trains.t$(train).carts
execute unless score #actual rw.sys = #total rw.sys run tellraw @s {"text":"[Railway] Spawning incomplete; partial train preserved for inspection. Check available world space.","color":"red"}
execute unless score #actual rw.sys = #total rw.sys run return 0
function railway:api/train/inspect with storage railway:scratch spawn
return 1
