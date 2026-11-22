$execute store result score #pf_cost rw.sys run data get storage railway:graph graphs.g$(graph).edges.e$(edge).cost
$execute store result score #pf_dist rw.sys run data get storage railway:graph jobs.j$(path).labels.n$(node).distance
scoreboard players operation #pf_candidate rw.sys = #pf_dist rw.sys
scoreboard players operation #pf_candidate rw.sys += #pf_cost rw.sys
$data modify storage railway:path_work ctx.neighbor set from storage railway:graph graphs.g$(graph).edges.e$(edge).to
function railway:internal/path/update_neighbor with storage railway:path_work ctx
