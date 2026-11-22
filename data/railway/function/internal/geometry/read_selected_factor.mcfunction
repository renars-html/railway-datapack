scoreboard players operation #selected_factor rw.sys = #base_factor rw.sys
scoreboard players operation #selected_max rw.sys = #base_max rw.sys
execute if score @s rw.geom matches 1.. store result score #selected_factor rw.sys run data get entity @s data.path_geometry.speed_factor
execute if score @s rw.geom matches 1.. store result score #selected_max rw.sys run data get entity @s data.path_geometry.max_velocity
