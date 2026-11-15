fill ~0 ~-1 ~0 ~15 ~4 ~15 minecraft:air
fill ~0 ~-1 ~0 ~15 ~-1 ~15 minecraft:stone
fill ~13 ~0 ~5 ~13 ~0 ~6 minecraft:stone
fill ~3 ~0 ~2 ~12 ~0 ~2 minecraft:rail[shape=east_west]
fill ~3 ~0 ~11 ~12 ~0 ~11 minecraft:rail[shape=east_west]
fill ~2 ~0 ~3 ~2 ~0 ~10 minecraft:rail[shape=north_south]
fill ~13 ~0 ~3 ~13 ~0 ~3 minecraft:rail[shape=north_south]
fill ~13 ~0 ~8 ~13 ~0 ~10 minecraft:rail[shape=north_south]
fill ~13 ~1 ~5 ~13 ~1 ~6 minecraft:rail[shape=north_south]
setblock ~13 ~0 ~4 minecraft:rail[shape=ascending_south]
setblock ~13 ~0 ~7 minecraft:rail[shape=ascending_north]
setblock ~2 ~0 ~2 minecraft:rail[shape=south_east]
setblock ~13 ~0 ~2 minecraft:rail[shape=south_west]
setblock ~13 ~0 ~11 minecraft:rail[shape=north_west]
setblock ~2 ~0 ~11 minecraft:rail[shape=north_east]
fill ~2 ~-1 ~6 ~2 ~-1 ~8 minecraft:redstone_block
fill ~2 ~0 ~6 ~2 ~0 ~8 minecraft:powered_rail[shape=north_south,powered=true]
execute summon minecraft:marker run function railway:dev/internal/init_anchor
execute positioned ~3 ~0.0625 ~2.5 summon minecraft:minecart run function railway:dev/internal/init_rider
execute positioned ~3 ~0.0625 ~2.5 summon minecraft:chest_minecart run function railway:dev/internal/init_cargo
scoreboard players set #phase rw.dev 0
scoreboard players set #speed rw.dev 1
scoreboard players set #run rw.dev 0
scoreboard players set #fault rw.dev 0
scoreboard players set #gravity rw.dev 1
scoreboard players set #loss rw.dev 0
scoreboard players set #last_riders rw.dev 0
scoreboard players set #enabled rw.dev 1
data modify storage railway:dev fixture.registered set value 1b
function railway:dev/internal/tick
