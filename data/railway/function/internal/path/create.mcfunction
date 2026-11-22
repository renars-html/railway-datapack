$execute unless data storage railway:graph_work raw{graph:$(graph),from:$(from),to:$(to)} run return 0
$execute unless data storage railway:graph graphs.g$(graph){state:"sealed"} run return 0
$execute unless data storage railway:graph graphs.g$(graph).nodes.n$(from) run return 0
$execute unless data storage railway:graph graphs.g$(graph).nodes.n$(to) run return 0
scoreboard players set #pf_via rw.sys -1
execute store result score #pf_via rw.sys run data get storage railway:graph_work via
execute unless score #pf_via rw.sys matches 0..16 run return 0
execute store result score #pf_id rw.sys run data get storage railway:graph next_path
execute if score #pf_id rw.sys matches 2147483646.. run return 0
scoreboard players add #pf_id rw.sys 1
execute store result storage railway:graph next_path int 1 run scoreboard players get #pf_id rw.sys
execute store result storage railway:graph_work ctx.path int 1 run scoreboard players get #pf_id rw.sys
return run function railway:internal/path/new_job with storage railway:graph_work ctx
