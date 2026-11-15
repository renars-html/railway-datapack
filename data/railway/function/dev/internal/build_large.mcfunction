fill ~0 ~-1 ~0 ~75 ~4 ~35 minecraft:air
fill ~0 ~-1 ~0 ~75 ~-1 ~35 minecraft:stone
fill ~73 ~0 ~5 ~73 ~0 ~6 minecraft:stone
fill ~3 ~0 ~2 ~72 ~0 ~2 minecraft:rail[shape=east_west]
fill ~3 ~0 ~31 ~72 ~0 ~31 minecraft:rail[shape=east_west]
fill ~2 ~0 ~3 ~2 ~0 ~30 minecraft:rail[shape=north_south]
setblock ~73 ~0 ~3 minecraft:rail[shape=north_south]
fill ~73 ~0 ~8 ~73 ~0 ~30 minecraft:rail[shape=north_south]
fill ~73 ~1 ~5 ~73 ~1 ~6 minecraft:rail[shape=north_south]
setblock ~73 ~0 ~4 minecraft:rail[shape=ascending_south]
setblock ~73 ~0 ~7 minecraft:rail[shape=ascending_north]
setblock ~2 ~0 ~2 minecraft:rail[shape=south_east]
setblock ~73 ~0 ~2 minecraft:rail[shape=south_west]
setblock ~73 ~0 ~31 minecraft:rail[shape=north_west]
setblock ~2 ~0 ~31 minecraft:rail[shape=north_east]
fill ~2 ~-1 ~6 ~2 ~-1 ~8 minecraft:redstone_block
fill ~2 ~0 ~6 ~2 ~0 ~8 minecraft:powered_rail[shape=north_south,powered=true]
teleport @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] ~ ~ ~
data modify storage railway:dev fixture.origin set from entity @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] Pos
data modify storage railway:dev route_profile set value 1
scoreboard players add #profile rw.sys 1
execute store result storage railway:dev route_revision int 1 run scoreboard players get #profile rw.sys
scoreboard players set #station_job rw.sys 0
scoreboard players operation #old_factor rw.sys = #speed_factor rw.sys
function railway:dev/internal/path_load
execute as @e[type=minecraft:marker,tag=railway.active] run function railway:dev/internal/relocate_train
teleport @e[type=minecraft:minecart,tag=railway.dev.rider] ~6 ~0.0625 ~6
teleport @e[type=minecraft:chest_minecart,tag=railway.dev.cargo] ~8 ~0.0625 ~6
scoreboard players set #phase rw.dev 0
scoreboard players set #run rw.dev 0
