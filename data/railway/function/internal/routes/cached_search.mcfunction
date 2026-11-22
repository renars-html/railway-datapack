execute if score #iterations rw.sys matches 13.. run return 0
scoreboard players operation #candidate rw.sys = #low rw.sys
scoreboard players operation #candidate rw.sys += #high rw.sys
scoreboard players add #candidate rw.sys 1
scoreboard players operation #candidate rw.sys /= #two rw.sys
execute store result storage railway:route_work envelope.index int 1 run scoreboard players get #candidate rw.sys
function railway:internal/routes/read_threshold with storage railway:route_work envelope
execute if score #threshold rw.sys <= @s rw.remain run scoreboard players operation #low rw.sys = #candidate rw.sys
execute if score #threshold rw.sys > @s rw.remain run scoreboard players operation #high rw.sys = #candidate rw.sys
execute if score #threshold rw.sys > @s rw.remain run scoreboard players remove #high rw.sys 1
scoreboard players add #iterations rw.sys 1
return run function railway:internal/routes/cached_search
