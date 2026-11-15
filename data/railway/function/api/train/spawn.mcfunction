data modify storage railway:api result set value {ok:0b,error:"Use a Creative Overworld player and integer normal/chest counts totaling 1..64."}
execute unless entity @s[type=minecraft:player,gamemode=creative] run return 0
execute unless dimension minecraft:overworld run return 0
execute store result score #build_y rw.sys run data get entity @s Pos[1] 1
execute unless score #build_y rw.sys matches -60..300 run return 0
$data modify storage railway:scratch composition_request set value {normal:$(normal),chest:$(chest)}
scoreboard players set #normal rw.sys -1
scoreboard players set #chest rw.sys -1
execute store result score #normal rw.sys run data get storage railway:scratch composition_request.normal 1
execute store result score #chest rw.sys run data get storage railway:scratch composition_request.chest 1
execute unless score #normal rw.sys matches 0..64 run return 0
execute unless score #chest rw.sys matches 0..64 run return 0
scoreboard players operation #total rw.sys = #normal rw.sys
scoreboard players operation #total rw.sys += #chest rw.sys
execute unless score #total rw.sys matches 1..64 run return 0
execute store result storage railway:scratch counts.normal int 1 run scoreboard players get #normal rw.sys
execute store result storage railway:scratch counts.chest int 1 run scoreboard players get #chest rw.sys
execute store result score #valid rw.sys run function railway:internal/composition/check_counts with storage railway:scratch counts
execute unless score #valid rw.sys matches 1 run return 0
return run function railway:internal/composition/spawn
