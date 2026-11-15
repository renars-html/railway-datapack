execute store result score #attached rw.sys run function railway:api/train/attach with storage railway:scratch spawn
execute unless score #attached rw.sys matches 1 run scoreboard players set #spawn_bad rw.sys 1
