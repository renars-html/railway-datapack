$execute if data storage railway:graph jobs.j$(path).labels.n$(node){visited:1} run return 0
$execute store result score #pf_dist rw.sys run data get storage railway:graph jobs.j$(path).labels.n$(node).distance
$execute store result score #pf_best_dist rw.sys run data get storage railway:graph jobs.j$(path).best_distance
execute unless score #pf_dist rw.sys < #pf_best_dist rw.sys run return 0
$data modify storage railway:graph jobs.j$(path).best set value $(node)
$execute store result storage railway:graph jobs.j$(path).best_distance int 1 run scoreboard players get #pf_dist rw.sys
