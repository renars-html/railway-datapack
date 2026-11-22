scoreboard players set @s rw.auto 0
function railway:internal/geometry/ensure_controller
scoreboard players set @s rw.override 1
scoreboard players set @s rw.run 1
scoreboard players set @s rw.emerg 0
scoreboard players set @s rw.station 0
scoreboard players set @s rw.remain 0
function railway:internal/geometry/read_selected_factor
scoreboard players operation @s rw.vel = #selected_max rw.sys
scoreboard players operation @s rw.epoch = #epoch rw.sys
