execute unless score #pf_node rw.sys matches 1..64 run return 0
$execute unless data storage railway:graph jobs.j$(path).via[$(index)] run return 0
$data modify storage railway:path_work canonical set value $(node)
execute store success score #pf_changed rw.sys run data modify storage railway:path_work canonical set from storage railway:path_work raw_node
execute unless score #pf_changed rw.sys matches 0 run return 0
$execute unless data storage railway:graph graphs.g$(graph).nodes.n$(node) run return 0
$data modify storage railway:graph jobs.j$(path).targets append value $(node)
return 1
