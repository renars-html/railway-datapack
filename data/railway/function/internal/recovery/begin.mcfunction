# Preserve a pending intent across repeated reloads instead of replacing it with the temporary hold.
execute if score @s rw.recover matches 0 run scoreboard players set @s rw.resume 0
execute if score @s rw.recover matches 0 if score @s rw.run matches 1 if score @s rw.override matches 0 if score @s rw.emerg matches 0 run scoreboard players set @s rw.resume 1
scoreboard players set @s rw.recover 1
scoreboard players set @s rw.grace 2
scoreboard players set @s rw.recage 0
scoreboard players set @s rw.vel 0
scoreboard players set @s rw.run 0
scoreboard players set @s rw.override 0
scoreboard players operation @s rw.epoch = #epoch rw.sys
$data modify storage railway:state trains.t$(id).state set value "recovering"
