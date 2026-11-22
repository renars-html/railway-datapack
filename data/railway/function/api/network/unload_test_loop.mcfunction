data modify storage railway:api result set value {ok:0b,error:"No test-loop loading lease exists."}
execute unless data storage railway:loading lease run return 0
# Pause all prototype trains before releasing entity-ticking chunks.
execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active] run function railway:internal/loading/pause
execute store result score #lease_count rw.sys run data get storage railway:loading lease.chunks
scoreboard players set #release_index rw.sys 0
scoreboard players set #release_failed rw.sys 0
execute in minecraft:overworld run function railway:internal/loading/remove_next
execute unless score #release_failed rw.sys matches 0 run return 0
data remove storage railway:loading lease
data modify storage railway:api result set value {ok:1b}
tellraw @s {"text":"[Railway] Pack-owned test-loop tickets released. Pre-existing tickets were preserved. Trains are held; no entities/cargo were removed.","color":"aqua"}
return 1
