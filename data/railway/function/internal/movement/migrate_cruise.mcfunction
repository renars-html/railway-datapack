scoreboard players operation @s rw.cruise = @s rw.speed
scoreboard players operation @s rw.cruise *= #thousand rw.sys
execute unless score @s rw.cruise matches 20..8019 run scoreboard players set @s rw.cruise 3007
