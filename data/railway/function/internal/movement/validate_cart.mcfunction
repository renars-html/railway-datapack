scoreboard players add #loaded rw.sys 1
execute unless entity @s[type=minecraft:minecart] unless entity @s[type=minecraft:chest_minecart] run scoreboard players set #bad rw.sys 1
execute store result storage railway:scratch ctx.index int 1 run scoreboard players get @s rw.car
function railway:internal/movement/validate_uuid with storage railway:scratch ctx
