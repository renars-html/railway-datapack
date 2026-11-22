function railway:internal/geometry/read_index
$execute store result score #geo_edges rw.sys run data get storage railway:graph paths.p$(path).edges
execute if score #geo_index rw.sys >= #geo_edges rw.sys run return run function railway:internal/geometry/edges_done with storage railway:geometry active_job
function railway:internal/geometry/read_edge_id with storage railway:geometry_work ctx
function railway:internal/geometry/add_edge_length with storage railway:geometry_work ctx
scoreboard players add #geo_index rw.sys 1
execute store result storage railway:geometry job.index int 1 run scoreboard players get #geo_index rw.sys
scoreboard players remove #geo_budget rw.sys 1
execute if score #geo_budget rw.sys matches 1.. run function railway:internal/geometry/edge_step with storage railway:geometry active_job
