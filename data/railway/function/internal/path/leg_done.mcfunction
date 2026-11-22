$execute store result score #pf_target_i rw.sys run data get storage railway:graph jobs.j$(path).target_index
$execute if score #pf_target_i rw.sys matches 1.. run data remove storage railway:graph jobs.j$(path).leg_nodes[0]
$data modify storage railway:graph jobs.j$(path).nodes append from storage railway:graph jobs.j$(path).leg_nodes[]
$data modify storage railway:graph jobs.j$(path).edges append from storage railway:graph jobs.j$(path).leg_edges[]
scoreboard players add #pf_target_i rw.sys 1
$execute store result score #pf_targets rw.sys run data get storage railway:graph jobs.j$(path).targets
execute if score #pf_target_i rw.sys >= #pf_targets rw.sys run return run function railway:internal/path/publish with storage railway:graph active_job
scoreboard players operation #pf_prev_target rw.sys = #pf_target_i rw.sys
scoreboard players remove #pf_prev_target rw.sys 1
execute store result storage railway:path_work ctx.index int 1 run scoreboard players get #pf_prev_target rw.sys
function railway:internal/path/set_next_source with storage railway:path_work ctx
$execute store result storage railway:graph jobs.j$(path).target_index int 1 run scoreboard players get #pf_target_i rw.sys
$data modify storage railway:graph jobs.j$(path).cursor set value 0
$data modify storage railway:graph jobs.j$(path).stage set value "init"
