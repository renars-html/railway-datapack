$execute store result score #pf_cursor rw.sys run data get storage railway:graph jobs.j$(path).cursor
execute store result storage railway:path_work ctx.index int 1 run scoreboard players get #pf_cursor rw.sys
$data modify storage railway:path_work ctx.path set value $(path)
$data modify storage railway:path_work ctx.graph set value $(graph)
