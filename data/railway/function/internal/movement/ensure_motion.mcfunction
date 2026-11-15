execute unless score @s rw.pos matches 0..317999 run function railway:internal/movement/migrate_progress
execute unless score @s rw.vel matches 0..8000 run scoreboard players set @s rw.vel 0
execute unless score @s rw.accel matches 1..1000 run scoreboard players set @s rw.accel 50
execute unless score @s rw.brake matches 1..1000 run scoreboard players set @s rw.brake 100
execute unless score @s rw.emerg matches 0..1 run scoreboard players set @s rw.emerg 0
