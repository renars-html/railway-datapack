scoreboard players set #bad rw.sys 0
execute store result storage railway:scratch ctx.index int 1 run scoreboard players get @s rw.car
function railway:internal/movement/validate_uuid with storage railway:scratch ctx
execute unless score #bad rw.sys matches 0 run return 0
scoreboard players operation #frame rw.dev = @s rw.car
scoreboard players operation #frame rw.dev *= #offset rw.dev
scoreboard players operation #frame rw.dev *= #negative rw.sys
scoreboard players operation #frame rw.dev += #train_phase rw.sys
scoreboard players operation #frame rw.dev %= #length rw.dev
execute if score #frame rw.dev matches ..-1 run scoreboard players operation #frame rw.dev += #length rw.dev
execute store result storage railway:dev ctx.frame int 1 run scoreboard players get #frame rw.dev
function railway:dev/internal/sample with storage railway:dev ctx
