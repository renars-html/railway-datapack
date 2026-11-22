$execute store result score #stop_i rw.sys run data get storage railway:routes jobs.j$(route).index
$execute store result score #stop_count rw.sys run data get storage railway:routes jobs.j$(route).draft.count
execute if score #stop_i rw.sys >= #stop_count rw.sys run return run function railway:internal/routes/cache_begin with storage railway:routes active_job
execute store result storage railway:route_work stop.route int 1 run data get storage railway:routes active_job.route
execute store result storage railway:route_work stop.index int 1 run scoreboard players get #stop_i rw.sys
function railway:internal/routes/copy_stop_id with storage railway:route_work stop
execute store result storage railway:route_work stop.station int 1 run scoreboard players get #stop_id rw.sys
execute store result score #copied rw.sys run function railway:internal/routes/resolve_stop with storage railway:route_work stop
execute unless score #copied rw.sys matches 1 run return run function railway:internal/routes/fail with storage railway:routes active_job
scoreboard players add #stop_i rw.sys 1
$execute store result storage railway:routes jobs.j$(route).index int 1 run scoreboard players get #stop_i rw.sys
return 1
