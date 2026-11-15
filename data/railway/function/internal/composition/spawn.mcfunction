execute store result score #created rw.sys run function railway:api/train/create
execute unless score #created rw.sys matches 1 run return 0
execute store result storage railway:scratch spawn.train int 1 run scoreboard players get #selected rw.sys
scoreboard players set #spawn_index rw.sys 0
scoreboard players set #eight rw.sys 8
scoreboard players set #two rw.sys 2
scoreboard players set #spawn_bad rw.sys 0
function railway:internal/composition/next
execute unless score #spawn_bad rw.sys matches 0 run return 0
return run function railway:internal/composition/finish with storage railway:scratch spawn
