execute store result score #geo_ei rw.sys run data get storage railway:geometry job.edge_index
scoreboard players add #geo_ei rw.sys 1
execute store result storage railway:geometry job.edge_index int 1 run scoreboard players get #geo_ei rw.sys
data modify storage railway:geometry job.segment_index set value 0
return run function railway:internal/geometry/choose_segment with storage railway:geometry active_job
