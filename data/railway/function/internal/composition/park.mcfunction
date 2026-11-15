scoreboard players set #bad rw.sys 0
execute store result storage railway:scratch ctx.index int 1 run scoreboard players get @s rw.car
function railway:internal/movement/validate_uuid with storage railway:scratch ctx
execute unless score #bad rw.sys matches 0 run return 0
scoreboard players operation #grid_x rw.sys = @s rw.car
scoreboard players operation #grid_x rw.sys %= #eight rw.sys
scoreboard players operation #grid_x rw.sys *= #two rw.sys
scoreboard players operation #grid_z rw.sys = @s rw.car
scoreboard players operation #grid_z rw.sys /= #eight rw.sys
scoreboard players operation #grid_z rw.sys *= #two rw.sys
scoreboard players add #grid_z rw.sys 20
execute store result storage railway:scratch park.x int 1 run scoreboard players get #grid_x rw.sys
execute store result storage railway:scratch park.z int 1 run scoreboard players get #grid_z rw.sys
function railway:internal/composition/park_position with storage railway:scratch park
data merge entity @s {NoGravity:0b,Motion:[0.0d,0.0d,0.0d]}
tag @s remove railway.cart
tag @s add railway.detached
scoreboard players reset @s rw.train
scoreboard players reset @s rw.car
