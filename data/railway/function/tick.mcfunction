scoreboard players add #tick rw.sys 1
# One score check when the opt-in fixture is absent. Never selects ordinary carts.
execute if score #enabled rw.dev matches 1 in minecraft:overworld as @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] at @s run function railway:dev/internal/tick
execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active] at @s run function railway:internal/movement/tick
execute if score #station_job rw.sys matches 1 run function railway:dev/internal/station_scan
scoreboard players add #particle_clock rw.sys 1
execute if score #particle_clock rw.sys matches 20.. in minecraft:overworld as @e[type=minecraft:marker,tag=railway.station_marker] if score @s rw.profile = #profile rw.sys at @s run particle minecraft:end_rod ~ ~0.7 ~ 0.03 0.15 0.03 0 2 normal
execute if score #particle_clock rw.sys matches 20.. run scoreboard players set #particle_clock rw.sys 0
execute if data storage railway:routes active_job run function railway:internal/routes/worker
