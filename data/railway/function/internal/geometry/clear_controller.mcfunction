function railway:internal/geometry/read_selected_factor
scoreboard players set @s rw.geom 0
scoreboard players set @s rw.pos 0
scoreboard players set @s rw.phase 0
scoreboard players set @s rw.station 0
scoreboard players set @s rw.remain 0
scoreboard players set #switch_mode rw.sys 0
function railway:internal/geometry/set_switches
scoreboard players operation @s rw.cruise *= #selected_factor rw.sys
scoreboard players operation @s rw.cruise /= #base_factor rw.sys
