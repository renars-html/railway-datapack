scoreboard players set @s rw.vel 0
scoreboard players set @s rw.station 2
scoreboard players operation @s rw.wait = @s rw.dwell
execute if score @s rw.route matches 1.. if score @s rw.auto matches 1 run function railway:internal/routes/next_stop
