scoreboard players set #pf_node rw.sys 0
$data modify storage railway:path_work raw_node set from storage railway:graph jobs.j$(path).via[$(index)]
execute store result score #pf_node rw.sys run data get storage railway:path_work raw_node
