# The mandatory pre-advance pass verified this exact entity/slot earlier this tick.
execute unless score @s rw.validtick = #tick rw.sys run return 0
scoreboard players operation #fine rw.sys = @s rw.car
scoreboard players operation #fine rw.sys *= #offset rw.dev
scoreboard players operation #fine rw.sys *= #thousand rw.sys
scoreboard players operation #fine rw.sys *= #negative rw.sys
scoreboard players operation #fine rw.sys += #train_pos rw.sys
scoreboard players operation #fine rw.sys %= #fine_length rw.sys
execute if score #fine rw.sys matches ..-1 run scoreboard players operation #fine rw.sys += #fine_length rw.sys
scoreboard players operation #frame rw.dev = #fine rw.sys
scoreboard players operation #frame rw.dev /= #thousand rw.sys
scoreboard players operation #fraction rw.sys = #fine rw.sys
scoreboard players operation #fraction rw.sys %= #thousand rw.sys
scoreboard players operation #next rw.sys = #frame rw.dev
scoreboard players add #next rw.sys 1
scoreboard players operation #next rw.sys %= #length rw.dev
execute store result storage railway:motion sample.frame int 1 run scoreboard players get #frame rw.dev
execute store result storage railway:motion sample.next int 1 run scoreboard players get #next rw.sys
function railway:internal/movement/interpolate with storage railway:motion sample
