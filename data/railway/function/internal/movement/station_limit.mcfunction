scoreboard players set #low rw.sys 0
scoreboard players operation #high rw.sys = #max_velocity rw.sys
scoreboard players set #iterations rw.sys 0
function railway:internal/movement/search_speed
execute if score #target rw.sys > #low rw.sys run scoreboard players operation #target rw.sys = #low rw.sys
