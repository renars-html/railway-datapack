$data modify storage railway:graph jobs.j$(path).back_node set value $(node)
$data modify storage railway:graph jobs.j$(path).leg_nodes set value []
$data modify storage railway:graph jobs.j$(path).leg_edges set value []
$data modify storage railway:graph jobs.j$(path).cursor set value 0
$data modify storage railway:graph jobs.j$(path).stage set value "backtrack"
$execute store result score #pf_leg_cost rw.sys run data get storage railway:graph jobs.j$(path).labels.n$(node).distance
$execute store result score #pf_total rw.sys run data get storage railway:graph jobs.j$(path).total_cost
scoreboard players operation #pf_total rw.sys += #pf_leg_cost rw.sys
$execute store result storage railway:graph jobs.j$(path).total_cost int 1 run scoreboard players get #pf_total rw.sys
