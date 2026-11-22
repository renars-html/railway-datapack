function railway:internal/geometry/read_index
execute store result score #geo_count rw.sys run data get storage railway:geometry job.count
execute if score #geo_index rw.sys >= #geo_count rw.sys run return run function railway:internal/geometry/frames_done
execute store result score #geo_distance rw.sys run data get storage railway:geometry job.distance
function railway:internal/geometry/choose_segment with storage railway:geometry active_job
execute unless score #geo_source_ok rw.sys matches 1 run return run function railway:internal/geometry/fail with storage railway:geometry active_job
function railway:internal/geometry/make_frame with storage railway:geometry_work segment
$data modify storage railway:geometry paths.p$(path).frames append from storage railway:geometry_work frame
function railway:internal/geometry/advance_distance
scoreboard players add #geo_index rw.sys 1
execute store result storage railway:geometry job.index int 1 run scoreboard players get #geo_index rw.sys
scoreboard players remove #geo_budget rw.sys 1
execute if score #geo_budget rw.sys matches 1.. run function railway:internal/geometry/frame_step with storage railway:geometry active_job
