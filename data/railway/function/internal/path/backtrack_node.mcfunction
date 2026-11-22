$data modify storage railway:graph jobs.j$(path).leg_nodes prepend value $(node)
$execute store result score #pf_source rw.sys run data get storage railway:graph jobs.j$(path).current_from
$scoreboard players set #pf_node rw.sys $(node)
scoreboard players set #pf_finished rw.sys 0
execute if score #pf_source rw.sys = #pf_node rw.sys run scoreboard players set #pf_finished rw.sys 1
execute if score #pf_finished rw.sys matches 1 run return 1
$data modify storage railway:path_work previous_edge set from storage railway:graph jobs.j$(path).labels.n$(node).edge
$data modify storage railway:graph jobs.j$(path).leg_edges prepend from storage railway:path_work previous_edge
$data modify storage railway:graph jobs.j$(path).back_node set from storage railway:graph jobs.j$(path).labels.n$(node).previous
