$execute store result score #index rw.sys run data get storage railway:state trains.t$(id).carts
execute unless score #index rw.sys matches 0..63 run return 0
data modify storage railway:scratch cart set value {}
data modify storage railway:scratch cart.uuid set from entity @s UUID
execute store result storage railway:scratch cart.index int 1 run scoreboard players get #index rw.sys
$data modify storage railway:state trains.t$(id).carts append from storage railway:scratch cart
scoreboard players operation @s rw.train = #selected rw.sys
scoreboard players operation @s rw.car = #index rw.sys
tag @s add railway.cart
data modify storage railway:api result set value {ok:1b}
execute store result storage railway:api result.train int 1 run scoreboard players get #selected rw.sys
execute store result storage railway:api result.index int 1 run scoreboard players get #index rw.sys
return 1
