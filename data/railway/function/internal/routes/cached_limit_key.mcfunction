$execute unless data storage railway:routes caches.$(cache){ready:1b} run return run function railway:internal/routes/envelope_fault
scoreboard players operation #route_cruise rw.sys = @s rw.cruise
execute store result storage railway:route_work envelope.index int 1 run scoreboard players get #route_cruise rw.sys
function railway:internal/routes/read_threshold with storage railway:route_work envelope
execute if score @s rw.remain >= #threshold rw.sys run return 0
scoreboard players set #low rw.sys 0
scoreboard players operation #high rw.sys = @s rw.cruise
scoreboard players set #iterations rw.sys 0
function railway:internal/routes/cached_search
execute if score #target rw.sys > #low rw.sys run scoreboard players operation #target rw.sys = #low rw.sys
