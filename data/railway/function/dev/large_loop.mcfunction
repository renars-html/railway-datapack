execute if data storage railway:loading lease run tellraw @s {"text":"[Railway] Unload the test-loop lease before moving/rebuilding the loop.","color":"red"}
execute if data storage railway:loading lease run return 0
execute unless entity @s[type=minecraft:player,gamemode=creative] run return 0
execute unless dimension minecraft:overworld run return 0
execute unless entity @e[type=minecraft:marker,tag=railway.dev.anchor] run return 0
execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.run=1}] run return 0
execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.vel=1..}] run return 0
execute if data storage railway:dev loop_train run function railway:dev/internal/check_bound_loaded
execute if data storage railway:dev loop_train unless score #bound_valid rw.sys matches 1 run return 0
execute unless loaded ~75 ~5 ~35 run return 0
scoreboard players set #occupied rw.dev 0
execute as @e[tag=railway.cart] on passengers if entity @s[type=minecraft:player] run scoreboard players set #occupied rw.dev 1
execute as @e[tag=railway.dev.cart] on passengers if entity @s[type=minecraft:player] run scoreboard players set #occupied rw.dev 1
execute if score #occupied rw.dev matches 1 run return 0
execute store result score #build_y rw.sys run data get entity @s Pos[1]
execute unless score #build_y rw.sys matches -60..300 run return 0
execute align xyz positioned ~ ~1 ~ run function railway:dev/internal/build_large
teleport @s ~5.5 ~2 ~5.5
tellraw @s {"text":"[Railway] Large loop built: 199.66 blocks, 76x36 footprint. Existing bound train moved here and held. Prior station marks belong to the previous route and must be placed again.","color":"aqua"}
return 1
