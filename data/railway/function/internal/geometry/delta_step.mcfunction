function railway:internal/geometry/read_index
execute store result score #geo_count rw.sys run data get storage railway:geometry job.count
execute if score #geo_index rw.sys >= #geo_count rw.sys run return run function railway:internal/geometry/publish with storage railway:geometry active_job
scoreboard players operation #geo_next rw.sys = #geo_index rw.sys
scoreboard players add #geo_next rw.sys 1
scoreboard players operation #geo_next rw.sys %= #geo_count rw.sys
execute store result storage railway:geometry_work ctx.next int 1 run scoreboard players get #geo_next rw.sys
function railway:internal/geometry/compile_delta with storage railway:geometry_work ctx
scoreboard players add #geo_index rw.sys 1
execute store result storage railway:geometry job.index int 1 run scoreboard players get #geo_index rw.sys
scoreboard players remove #geo_budget rw.sys 1
execute if score #geo_budget rw.sys matches 1.. run function railway:internal/geometry/delta_step with storage railway:geometry active_job
