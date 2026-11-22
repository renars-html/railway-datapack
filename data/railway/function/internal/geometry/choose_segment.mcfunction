scoreboard players set #geo_source_ok rw.sys 0
data modify storage railway:geometry_work source set from storage railway:geometry active_job
data modify storage railway:geometry_work source.edge_index set from storage railway:geometry job.edge_index
data modify storage railway:geometry_work source.segment_index set from storage railway:geometry job.segment_index
function railway:internal/geometry/read_source_edge with storage railway:geometry_work source
execute unless score #geo_source_ok rw.sys matches 1 run return 0
execute store result score #geo_si rw.sys run data get storage railway:geometry job.segment_index
execute if score #geo_si rw.sys >= #geo_seg_count rw.sys run return run function railway:internal/geometry/next_edge with storage railway:geometry active_job
function railway:internal/geometry/read_segment with storage railway:geometry_work source
execute store result score #geo_seg_start rw.sys run data get storage railway:geometry job.segment_start
execute store result score #geo_seg_len rw.sys run data get storage railway:geometry_work segment.length
scoreboard players operation #geo_seg_end rw.sys = #geo_seg_start rw.sys
scoreboard players operation #geo_seg_end rw.sys += #geo_seg_len rw.sys
execute if score #geo_distance rw.sys >= #geo_seg_end rw.sys run return run function railway:internal/geometry/next_segment with storage railway:geometry active_job
return 1
