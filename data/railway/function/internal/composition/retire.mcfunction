$execute if data storage railway:state trains.t$(id){state:"retired"} run return 0
$execute if entity @e[type=minecraft:marker,tag=railway.controller,scores={rw.train=$(id),rw.run=1}] run return 0
$execute if entity @e[type=minecraft:marker,tag=railway.controller,scores={rw.train=$(id),rw.vel=1..}] run return 0
scoreboard players set #controllers rw.sys 0
$execute as @e[type=minecraft:marker,tag=railway.controller,scores={rw.train=$(id)}] run scoreboard players add #controllers rw.sys 1
execute unless score #controllers rw.sys matches 1 run return 0
$data modify storage railway:scratch expected_controller set from storage railway:state trains.t$(id).controller
$execute as @e[type=minecraft:marker,tag=railway.controller,scores={rw.train=$(id)},limit=1] store success score #different rw.sys run data modify storage railway:scratch expected_controller set from entity @s UUID
execute unless score #different rw.sys matches 0 run return 0
scoreboard players set #occupied rw.sys 0
$execute as @e[tag=railway.cart,scores={rw.train=$(id)}] on passengers if entity @s[type=minecraft:player] run scoreboard players set #occupied rw.sys 1
execute unless score #occupied rw.sys matches 0 run return 0
$execute as @e[type=minecraft:marker,tag=railway.controller,scores={rw.train=$(id)}] run function railway:internal/recovery/cancel
$scoreboard players set @e[type=minecraft:marker,tag=railway.controller,scores={rw.train=$(id)}] rw.run 0
$tag @e[type=minecraft:marker,tag=railway.controller,scores={rw.train=$(id)}] remove railway.active
$data modify storage railway:state trains.t$(id).state set value "retired"
$data remove storage railway:state trains.t$(id).route
scoreboard players set #loop_id rw.sys -1
execute store result score #loop_id rw.sys run data get storage railway:dev loop_train 1
execute if score #loop_id rw.sys = #selected rw.sys run data remove storage railway:dev loop_train
scoreboard players set #eight rw.sys 8
scoreboard players set #two rw.sys 2
$execute as @e[tag=railway.cart,scores={rw.train=$(id)}] run function railway:internal/composition/park
tellraw @s {"text":"[Railway] Old train retired. Loaded members and cargo preserved in a separate grid, 20 blocks forward along +Z. Replacement receives a new train ID.","color":"yellow"}
return 1
