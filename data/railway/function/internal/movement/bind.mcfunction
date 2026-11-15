execute unless entity @e[type=minecraft:marker,tag=railway.dev.anchor] run tellraw @s {"text":"[Railway] No loaded rail fixture. Return to the original loop.","color":"red"}
execute unless entity @e[type=minecraft:marker,tag=railway.dev.anchor] run return 0
execute if data storage railway:dev loop_train run tellraw @s {"text":"[Railway] The test loop already has a registered train. Use train/start or train/stop.","color":"red"}
execute if data storage railway:dev loop_train run return 0
function railway:dev/internal/occupied
$execute as @e[tag=railway.cart,scores={rw.train=$(id)}] on passengers if entity @s[type=minecraft:player] run scoreboard players set #occupied rw.dev 1
execute if score #occupied rw.dev matches 1 run tellraw @s {"text":"[Railway] Dismount all test carts before binding.","color":"red"}
execute if score #occupied rw.dev matches 1 run return 0
execute store result score #valid rw.sys run function railway:internal/movement/validate with storage railway:scratch ctx
execute unless score #valid rw.sys matches 1 run tellraw @s {"text":"[Railway] Missing carts or UUID/index mismatch. Binding refused.","color":"red"}
execute unless score #valid rw.sys matches 1 run return 0
execute unless score #expected rw.sys matches 1..64 run tellraw @s {"text":"[Railway] This train does not fit the selected loop.","color":"red"}
execute unless score #expected rw.sys matches 1..64 run return 0
scoreboard players operation #footprint rw.sys = #expected rw.sys
scoreboard players operation #footprint rw.sys *= #offset rw.dev
execute if score #footprint rw.sys > #length rw.dev run return 0
scoreboard players set #controllers rw.sys 0
$execute as @e[type=minecraft:marker,tag=railway.controller,scores={rw.train=$(id)}] run scoreboard players add #controllers rw.sys 1
execute unless score #controllers rw.sys matches 1 run return 0
scoreboard players set #enabled rw.dev 0
scoreboard players set #run rw.dev 0
# Preserve the original two test carts and cargo off the rail loop.
execute at @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] run teleport @e[type=minecraft:minecart,tag=railway.dev.rider] ~6 ~0.0625 ~6
execute at @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] run teleport @e[type=minecraft:chest_minecart,tag=railway.dev.cargo] ~8 ~0.0625 ~6
$execute as @e[tag=railway.cart,scores={rw.train=$(id)}] run data merge entity @s {NoGravity:1b,Motion:[0.0d,0.0d,0.0d]}
$execute as @e[type=minecraft:marker,tag=railway.controller,scores={rw.train=$(id)}] run function railway:internal/movement/bind_controller with storage railway:scratch ctx
$data modify storage railway:dev loop_train set value $(id)
$data modify storage railway:state trains.t$(id).route set value "dev_loop"
$data modify storage railway:state trains.t$(id).state set value "stopped"
data modify storage railway:api result set value {ok:1b}
tellraw @s {"text":"[Railway] Registered train bound and held on the loop. Use api/train/start {train:ID}. Old test carts are parked in the center.","color":"aqua"}
return 1
