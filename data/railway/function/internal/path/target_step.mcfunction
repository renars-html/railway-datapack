function railway:internal/path/read_cursor with storage railway:graph active_job
$execute store result score #pf_length rw.sys run data get storage railway:graph jobs.j$(path).via
execute if score #pf_cursor rw.sys >= #pf_length rw.sys run return run function railway:internal/path/targets_done with storage railway:graph active_job
function railway:internal/path/read_target with storage railway:path_work ctx
execute store result storage railway:path_work ctx.node int 1 run scoreboard players get #pf_node rw.sys
execute store result score #pf_ok rw.sys run function railway:internal/path/validate_target with storage railway:path_work ctx
execute unless score #pf_ok rw.sys matches 1 run return run function railway:internal/path/fail with storage railway:graph active_job
scoreboard players add #pf_cursor rw.sys 1
$execute store result storage railway:graph jobs.j$(path).cursor int 1 run scoreboard players get #pf_cursor rw.sys
scoreboard players remove #pf_budget rw.sys 1
execute if score #pf_budget rw.sys matches 1.. run function railway:internal/path/target_step with storage railway:graph active_job
