execute unless entity @s[type=minecraft:player,gamemode=creative] run return 0
execute unless dimension minecraft:overworld run return 0
execute if score #station_job rw.sys matches 1 run return 0
execute unless entity @e[type=minecraft:marker,tag=railway.dev.anchor] run return 0
$data modify storage railway:scratch station_id set value $(station)
scoreboard players set #mark_id rw.sys 0
execute store result score #mark_id rw.sys run data get storage railway:scratch station_id
execute unless score #mark_id rw.sys matches 1..64 run return 0
execute store result score #mark_x rw.sys run data get entity @s Pos[0] 100
execute store result score #mark_z rw.sys run data get entity @s Pos[2] 100
execute store result score #origin_x rw.sys run data get entity @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] Pos[0] 100
execute store result score #origin_z rw.sys run data get entity @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] Pos[2] 100
scoreboard players operation #mark_x rw.sys -= #origin_x rw.sys
scoreboard players operation #mark_z rw.sys -= #origin_z rw.sys
execute unless score #mark_x rw.sys matches -800..8400 run return 0
execute unless score #mark_z rw.sys matches -800..4400 run return 0
scoreboard players set #mark_path rw.sys 0
scoreboard players operation #mark_length rw.sys = #base_length rw.sys
scoreboard players set #scan rw.sys 0
scoreboard players set #best_distance rw.sys 2147483647
scoreboard players set #station_job rw.sys 1
tellraw @s {"text":"[Railway] Marking nearest test-path point for the TRAIN CENTER. Wait for the station particle marker (~1.3 seconds on the large loop).","color":"aqua"}
return 1
