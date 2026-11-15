# Twenty real carts, no block edits; use an empty flat Creative area.
execute unless entity @s[type=minecraft:player,gamemode=creative] run return 0
execute unless dimension minecraft:overworld run return 0
execute if data storage railway:registry_test train run return 0
execute store result score #created rw.sys run function railway:api/train/create
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
function railway:api/train/inspect with storage railway:registry_test
