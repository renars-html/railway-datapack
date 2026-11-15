scoreboard players set #stopping rw.sys 0
execute if score #candidate rw.sys matches ..0 run return 0
scoreboard players operation #k rw.sys = #candidate rw.sys
scoreboard players remove #k rw.sys 1
scoreboard players operation #k rw.sys /= @s rw.brake
scoreboard players operation #stopping rw.sys = #k rw.sys
scoreboard players operation #stopping rw.sys *= #candidate rw.sys
scoreboard players operation #term rw.sys = #k rw.sys
scoreboard players add #term rw.sys 1
scoreboard players operation #term rw.sys *= #k rw.sys
scoreboard players operation #term rw.sys /= #two rw.sys
scoreboard players operation #term rw.sys *= @s rw.brake
scoreboard players operation #stopping rw.sys -= #term rw.sys
