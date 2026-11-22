$execute store result score #pf_best rw.sys run data get storage railway:graph jobs.j$(path).best
execute if score #pf_best rw.sys matches 0 run return run function railway:internal/path/fail with storage railway:graph active_job
$execute store result score #pf_target_i rw.sys run data get storage railway:graph jobs.j$(path).target_index
execute store result storage railway:path_work ctx.index int 1 run scoreboard players get #pf_target_i rw.sys
function railway:internal/path/read_goal with storage railway:path_work ctx
execute store result storage railway:path_work ctx.node int 1 run scoreboard players get #pf_best rw.sys
execute if score #pf_best rw.sys = #pf_goal rw.sys run return run function railway:internal/path/begin_backtrack with storage railway:path_work ctx
function railway:internal/path/visit with storage railway:path_work ctx
$data modify storage railway:graph jobs.j$(path).cursor set value 0
$data modify storage railway:graph jobs.j$(path).stage set value "relax"
