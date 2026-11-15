scoreboard players set @s rw.run 0
scoreboard players operation @s rw.epoch = #epoch rw.sys
$data modify storage railway:state trains.t$(id).state set value "stopped"
