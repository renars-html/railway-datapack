scoreboard players operation #frame rw.dev = #phase rw.dev
scoreboard players operation #frame rw.dev -= #offset rw.dev
execute if score #frame rw.dev matches ..-1 run scoreboard players operation #frame rw.dev += #length rw.dev
execute store result storage railway:dev ctx.frame int 1 run scoreboard players get #frame rw.dev
function railway:dev/internal/sample with storage railway:dev ctx
