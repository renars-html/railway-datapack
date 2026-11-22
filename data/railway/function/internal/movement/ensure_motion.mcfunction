execute unless score @s rw.pos matches 0.. run function railway:internal/movement/migrate_progress
execute if score @s rw.pos >= #fine_length rw.sys run scoreboard players operation @s rw.pos %= #fine_length rw.sys
execute unless score @s rw.vel matches 0..8019 run scoreboard players set @s rw.vel 0
execute unless score @s rw.accel matches 1..1000 run scoreboard players set @s rw.accel 50
execute unless score @s rw.brake matches 1..1000 run scoreboard players set @s rw.brake 50
execute unless score @s rw.emerg matches 0..1 run scoreboard players set @s rw.emerg 0
execute unless score @s rw.cruise matches 20..8019 run function railway:internal/movement/migrate_cruise
execute unless score @s rw.signal matches 0..1 run scoreboard players set @s rw.signal 0
execute unless score @s rw.station matches 0..2 run scoreboard players set @s rw.station 0
execute unless score @s rw.override matches 0..1 run scoreboard players set @s rw.override 0
execute if score @s rw.accel matches ..39 run scoreboard players set @s rw.accel 40
execute if score @s rw.accel matches 101.. run scoreboard players set @s rw.accel 100
execute if score @s rw.brake matches ..39 run scoreboard players set @s rw.brake 40
execute if score @s rw.brake matches 101.. run scoreboard players set @s rw.brake 100
scoreboard players add @s rw.accel 5
scoreboard players add @s rw.brake 5
scoreboard players operation @s rw.accel /= #ten rw.dev
scoreboard players operation @s rw.brake /= #ten rw.dev
scoreboard players operation @s rw.accel *= #ten rw.dev
scoreboard players operation @s rw.brake *= #ten rw.dev
execute unless score @s rw.route matches 0.. run scoreboard players set @s rw.route 0
execute unless score @s rw.stopidx matches 0..15 run scoreboard players set @s rw.stopidx 0
execute unless score @s rw.auto matches 0..1 run scoreboard players set @s rw.auto 0
