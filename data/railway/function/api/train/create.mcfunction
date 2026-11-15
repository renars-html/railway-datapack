data modify storage railway:api result set value {ok:0b,error:"Creation requires an Overworld player."}
execute unless entity @s[type=minecraft:player] run return 0
execute unless dimension minecraft:overworld run return 0
execute store result score #selected rw.sys run data get storage railway:state next_train 1
execute if score #selected rw.sys matches 2147483646.. run return 0
scoreboard players add #selected rw.sys 1
# Consume ID before entity creation; IDs are never reused, including on failure.
execute store result storage railway:state next_train int 1 run scoreboard players get #selected rw.sys
execute store result storage railway:scratch ctx.id int 1 run scoreboard players get #selected rw.sys
data modify storage railway:scratch owner set from entity @s UUID
execute store result score #spawned rw.sys summon minecraft:marker run function railway:internal/registry/create with storage railway:scratch ctx
execute unless score #spawned rw.sys matches 1 run return 0
tellraw @s [{"text":"[Railway] Created unassigned train "},{"score":{"name":"#selected","objective":"rw.sys"}}]
return 1
