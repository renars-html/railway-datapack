scoreboard players set #rider_carts rw.dev 0
scoreboard players set #cargo_carts rw.dev 0
execute as @e[type=minecraft:minecart,tag=railway.dev.rider] run scoreboard players add #rider_carts rw.dev 1
execute as @e[type=minecraft:chest_minecart,tag=railway.dev.cargo] run scoreboard players add #cargo_carts rw.dev 1
