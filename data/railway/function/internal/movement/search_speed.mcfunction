execute if score #iterations rw.sys matches 13.. run return 0
scoreboard players operation #candidate rw.sys = #low rw.sys
scoreboard players operation #candidate rw.sys += #high rw.sys
scoreboard players add #candidate rw.sys 1
scoreboard players operation #candidate rw.sys /= #two rw.sys
function railway:internal/movement/braking_distance
scoreboard players operation #stopping rw.sys += #candidate rw.sys
execute if score #stopping rw.sys <= @s rw.remain run scoreboard players operation #low rw.sys = #candidate rw.sys
execute if score #stopping rw.sys > @s rw.remain run scoreboard players operation #high rw.sys = #candidate rw.sys
execute if score #stopping rw.sys > @s rw.remain run scoreboard players remove #high rw.sys 1
scoreboard players add #iterations rw.sys 1
return run function railway:internal/movement/search_speed
