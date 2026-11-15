scoreboard players operation @s rw.vel += @s rw.accel
execute if score @s rw.vel > #target rw.sys run scoreboard players operation @s rw.vel = #target rw.sys
