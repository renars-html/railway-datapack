data modify storage railway:api result set value {ok:0b,error:"Use an Overworld player near the test anchor; unload the existing lease first."}
execute unless entity @s[type=minecraft:player] run return 0
execute unless dimension minecraft:overworld run return 0
execute if data storage railway:loading lease run return 0
execute unless entity @e[type=minecraft:marker,tag=railway.dev.anchor] run return 0
execute store result score #min_x rw.sys run data get entity @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] Pos[0]
execute store result score #min_z rw.sys run data get entity @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] Pos[2]
scoreboard players operation #max_x rw.sys = #min_x rw.sys
scoreboard players operation #max_z rw.sys = #min_z rw.sys
execute if data storage railway:dev {route_profile:1} run scoreboard players add #max_x rw.sys 75
execute if data storage railway:dev {route_profile:1} run scoreboard players add #max_z rw.sys 35
execute unless data storage railway:dev {route_profile:1} run scoreboard players add #max_x rw.sys 15
execute unless data storage railway:dev {route_profile:1} run scoreboard players add #max_z rw.sys 15
scoreboard players operation #min_x rw.sys /= #sixteen rw.sys
scoreboard players operation #min_z rw.sys /= #sixteen rw.sys
scoreboard players operation #max_x rw.sys /= #sixteen rw.sys
scoreboard players operation #max_z rw.sys /= #sixteen rw.sys
scoreboard players operation #lease_count rw.sys = #max_x rw.sys
scoreboard players operation #lease_count rw.sys -= #min_x rw.sys
scoreboard players add #lease_count rw.sys 1
scoreboard players operation #rows rw.sys = #max_z rw.sys
scoreboard players operation #rows rw.sys -= #min_z rw.sys
scoreboard players add #rows rw.sys 1
scoreboard players operation #lease_count rw.sys *= #rows rw.sys
execute unless score #lease_count rw.sys matches 1..64 run return 0
data modify storage railway:loading lease set value {chunks:[],dimension:"minecraft:overworld",complete:0b}
scoreboard players operation #chunk_x rw.sys = #min_x rw.sys
scoreboard players operation #chunk_z rw.sys = #min_z rw.sys
scoreboard players set #load_failed rw.sys 0
function railway:internal/loading/add_next
execute unless score #load_failed rw.sys matches 0 run return 0
data modify storage railway:loading lease.complete set value 1b
data modify storage railway:api result set value {ok:1b}
tellraw @s [{"text":"[Railway] Persistent loading enabled for "},{"score":{"name":"#lease_count","objective":"rw.sys"}},{"text":" test-loop chunks. Native tickets survive reload/restart. Pre-existing forced chunks remain externally owned."}]
return 1
