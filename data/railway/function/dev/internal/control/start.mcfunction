function railway:dev/internal/count
execute unless score #rider_carts rw.dev matches 1 run return run tellraw @s {"text": "[Railway test] Expected exactly one passenger cart. Start refused.", "color": "aqua"}
execute unless score #cargo_carts rw.dev matches 1 run return run tellraw @s {"text": "[Railway test] Expected exactly one cargo cart. Start refused.", "color": "aqua"}
scoreboard players set #enabled rw.dev 1
scoreboard players set #fault rw.dev 0
scoreboard players set #run rw.dev 1
tellraw @s {"text": "[Railway test] Running. Use dev/stop to hold position.", "color": "aqua"}
