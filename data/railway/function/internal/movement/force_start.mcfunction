scoreboard players set @s rw.auto 0
function railway:internal/movement/ensure_motion
scoreboard players set @s rw.override 1
scoreboard players set @s rw.run 1
scoreboard players set @s rw.emerg 0
scoreboard players set @s rw.station 0
scoreboard players set @s rw.remain 0
scoreboard players operation @s rw.vel = #max_velocity rw.sys
scoreboard players operation @s rw.epoch = #epoch rw.sys
