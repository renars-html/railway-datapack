function railway:dev/internal/count
execute unless score #rider_carts rw.dev matches 1 run function railway:dev/internal/fault
execute unless score #cargo_carts rw.dev matches 1 run function railway:dev/internal/fault
execute if score #run rw.dev matches 1 run scoreboard players operation #phase rw.dev += #speed rw.dev
scoreboard players operation #phase rw.dev %= #length rw.dev
execute as @e[type=minecraft:minecart,tag=railway.dev.rider,limit=1] run function railway:dev/internal/rider_step
execute as @e[type=minecraft:chest_minecart,tag=railway.dev.cargo,limit=1] run function railway:dev/internal/cargo_step
scoreboard players set #riders rw.dev 0
execute as @e[type=minecraft:minecart,tag=railway.dev.rider,limit=1] on passengers if entity @s[type=minecraft:player] run scoreboard players add #riders rw.dev 1
execute if score #last_riders rw.dev matches 1.. if score #riders rw.dev matches 0 run scoreboard players add #loss rw.dev 1
scoreboard players operation #last_riders rw.dev = #riders rw.dev
