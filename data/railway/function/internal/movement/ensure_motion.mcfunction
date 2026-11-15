execute unless score @s rw.pos matches 0..317999 run function railway:internal/movement/migrate_progress
execute unless score @s rw.vel matches 0..8019 run scoreboard players set @s rw.vel 0
execute unless score @s rw.accel matches 1..1000 run scoreboard players set @s rw.accel 50
execute unless score @s rw.brake matches 1..1000 run scoreboard players set @s rw.brake 50
execute unless score @s rw.emerg matches 0..1 run scoreboard players set @s rw.emerg 0
execute unless score @s rw.cruise matches 20..8019 run function railway:internal/movement/migrate_cruise
execute unless score @s rw.signal matches 0..1 run scoreboard players set @s rw.signal 0
execute unless score @s rw.station matches 0..2 run scoreboard players set @s rw.station 0
