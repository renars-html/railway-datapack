$execute store result score #stop_count rw.sys run data get storage railway:routes jobs.j$(route).draft.count
execute if score #leg_i rw.sys >= #stop_count rw.sys run return 1
scoreboard players operation #leg_next rw.sys = #leg_i rw.sys
scoreboard players add #leg_next rw.sys 1
scoreboard players operation #leg_next rw.sys %= #stop_count rw.sys
execute store result storage railway:route_work leg.route int 1 run data get storage railway:routes active_job.route
execute store result storage railway:route_work leg.index int 1 run scoreboard players get #leg_i rw.sys
execute store result storage railway:route_work leg.next int 1 run scoreboard players get #leg_next rw.sys
function railway:internal/routes/compile_leg with storage railway:route_work leg
scoreboard players add #leg_i rw.sys 1
return run function railway:internal/routes/compile_legs with storage railway:routes active_job
