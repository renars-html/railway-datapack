# Twenty real carts, no block edits; use an empty flat Creative area.
execute unless entity @s[type=minecraft:player,gamemode=creative] run tellraw @s {"text":"[Railway] Registry setup requires a Creative player.","color":"red"}
execute unless entity @s[type=minecraft:player,gamemode=creative] run return 0
execute unless dimension minecraft:overworld run tellraw @s {"text":"[Railway] Registry setup requires the Overworld.","color":"red"}
execute unless dimension minecraft:overworld run return 0
execute if data storage railway:registry_test train run tellraw @s {"text":"[Railway] Registry fixture already registered. Inspect it with /function railway:api/train/inspect with storage railway:registry_test","color":"yellow"}
execute if data storage railway:registry_test train run return 0
execute store result score #created rw.sys run function railway:api/train/create
execute unless score #created rw.sys matches 1 run tellraw @s {"text":"[Railway] Train creation failed. Details: /data get storage railway:api result","color":"red"}
execute unless score #created rw.sys matches 1 run return 0
execute store result storage railway:registry_test train int 1 run scoreboard players get #selected rw.sys
execute positioned ~0 ~1 ~2 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~2 ~1 ~2 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~4 ~1 ~2 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~6 ~1 ~2 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~8 ~1 ~2 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~0 ~1 ~4 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~2 ~1 ~4 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~4 ~1 ~4 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~6 ~1 ~4 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~8 ~1 ~4 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~0 ~1 ~6 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~2 ~1 ~6 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~4 ~1 ~6 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~6 ~1 ~6 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~8 ~1 ~6 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~0 ~1 ~8 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~2 ~1 ~8 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~4 ~1 ~8 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~6 ~1 ~8 summon minecraft:minecart run function railway:dev/internal/registry_cart
execute positioned ~8 ~1 ~8 summon minecraft:chest_minecart run function railway:dev/internal/registry_cart
return run function railway:api/train/inspect with storage railway:registry_test
