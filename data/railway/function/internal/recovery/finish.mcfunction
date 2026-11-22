scoreboard players operation @s rw.run = @s rw.resume
execute if score @s rw.emerg matches 1 run scoreboard players set @s rw.run 0
scoreboard players set @s rw.resume 0
scoreboard players set @s rw.recover 0
