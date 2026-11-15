scoreboard players set @s rw.vel 0
scoreboard players set @s rw.run 0
scoreboard players operation @s rw.epoch = #epoch rw.sys
$execute if score @s rw.emerg matches 0 run data modify storage railway:state trains.t$(id).state set value "stopped"
$execute if score @s rw.emerg matches 1 run data modify storage railway:state trains.t$(id).state set value "emergency"
