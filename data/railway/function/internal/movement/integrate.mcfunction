scoreboard players set #target rw.sys 0
execute if score @s rw.run matches 1 if score @s rw.emerg matches 0 if score #valid rw.sys matches 1 run scoreboard players operation #target rw.sys = @s rw.speed
scoreboard players operation #target rw.sys *= #thousand rw.sys
execute if score @s rw.vel < #target rw.sys run function railway:internal/movement/accelerate
execute if score @s rw.vel > #target rw.sys run function railway:internal/movement/decelerate
execute if score @s rw.emerg matches 1 run scoreboard players set @s rw.vel 0
scoreboard players operation @s rw.pos += @s rw.vel
scoreboard players operation @s rw.pos %= #fine_length rw.sys
scoreboard players operation @s rw.phase = @s rw.pos
scoreboard players operation @s rw.phase /= #thousand rw.sys
execute if score #valid rw.sys matches 1 run function railway:internal/movement/motion_state with storage railway:scratch ctx
