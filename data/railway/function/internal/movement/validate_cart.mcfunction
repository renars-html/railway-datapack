scoreboard players add #loaded rw.sys 1
scoreboard players operation #prior_bad rw.sys = #bad rw.sys
scoreboard players set #bad rw.sys 0
scoreboard players set @s rw.validtick -1
execute unless entity @s[type=minecraft:minecart] unless entity @s[type=minecraft:chest_minecart] run scoreboard players set #bad rw.sys 1
execute store result storage railway:scratch ctx.index int 1 run scoreboard players get @s rw.car
function railway:internal/movement/validate_uuid with storage railway:scratch ctx
execute if score #bad rw.sys matches 0 run scoreboard players operation @s rw.validtick = #tick rw.sys
execute if score #prior_bad rw.sys matches 1 run scoreboard players set #bad rw.sys 1
