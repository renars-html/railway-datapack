$execute if data storage railway:graph jobs.j$(path).labels.n$(neighbor){visited:1} run return 0
$execute store result score #pf_old rw.sys run data get storage railway:graph jobs.j$(path).labels.n$(neighbor).distance
execute unless score #pf_candidate rw.sys < #pf_old rw.sys run return 0
$execute store result storage railway:graph jobs.j$(path).labels.n$(neighbor).distance int 1 run scoreboard players get #pf_candidate rw.sys
$data modify storage railway:graph jobs.j$(path).labels.n$(neighbor).previous set value $(node)
$data modify storage railway:graph jobs.j$(path).labels.n$(neighbor).edge set value $(edge)
