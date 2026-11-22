scoreboard players set #geo_valid rw.sys 1
execute unless score @s rw.geom matches 0.. run scoreboard players set @s rw.geom 0
scoreboard players operation #train_geometry rw.sys = @s rw.geom
execute store result storage railway:motion sample.path int 1 run scoreboard players get @s rw.geom
execute if score @s rw.geom matches 1.. run scoreboard players set #geo_valid rw.sys 0
execute if score @s rw.geom matches 1.. run function railway:internal/geometry/controller_globals with entity @s data.path_geometry
