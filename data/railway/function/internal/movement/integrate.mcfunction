scoreboard players set #target rw.sys 0
execute if score @s rw.run matches 1 if score @s rw.emerg matches 0 if score @s rw.signal matches 0 unless score @s rw.station matches 2 if score #valid rw.sys matches 1 run scoreboard players operation #target rw.sys = @s rw.cruise
execute if score @s rw.station matches 1 if score @s rw.route matches 0 run function railway:internal/movement/station_limit
execute if score @s rw.station matches 1 if score @s rw.route matches 1.. run function railway:internal/routes/cached_limit
execute if score @s rw.override matches 1 run scoreboard players operation #target rw.sys = #max_velocity rw.sys
execute if score @s rw.override matches 1 run scoreboard players operation @s rw.vel = #max_velocity rw.sys
execute if score @s rw.vel < #target rw.sys run function railway:internal/movement/accelerate
execute if score @s rw.vel > #target rw.sys run function railway:internal/movement/decelerate
execute if score @s rw.emerg matches 1 run scoreboard players set @s rw.vel 0
execute if score @s rw.station matches 1 run scoreboard players operation @s rw.remain -= @s rw.vel
scoreboard players operation @s rw.pos += @s rw.vel
scoreboard players operation @s rw.pos %= #fine_length rw.sys
scoreboard players operation @s rw.phase = @s rw.pos
scoreboard players operation @s rw.phase /= #thousand rw.sys
execute if score @s rw.station matches 1 if score @s rw.remain matches 0 run function railway:internal/movement/arrive
execute if score @s rw.station matches 2 run function railway:internal/movement/dwell
execute if score #valid rw.sys matches 1 run function railway:internal/movement/motion_state with storage railway:scratch ctx

$execute if score @s rw.override matches 1 run data modify storage railway:state trains.t$(id).state set value "override"
