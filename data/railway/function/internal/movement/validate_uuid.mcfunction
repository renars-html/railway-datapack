execute unless score @s rw.car matches 0..63 run return run scoreboard players set #bad rw.sys 1
$execute unless data storage railway:state trains.t$(id).carts[$(index)]{index:$(index)} run return run scoreboard players set #bad rw.sys 1
$execute unless data storage railway:state trains.t$(id).carts[$(index)].uuid run return run scoreboard players set #bad rw.sys 1
$data modify storage railway:scratch expected_uuid set from storage railway:state trains.t$(id).carts[$(index)].uuid
# An unchanged data-modify result means the entity UUID equals its persistent member UUID.
execute store success score #different rw.sys run data modify storage railway:scratch expected_uuid set from entity @s UUID
execute unless score #different rw.sys matches 0 run scoreboard players set #bad rw.sys 1
