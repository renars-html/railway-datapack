data modify storage railway:geometry_work ctx set from storage railway:geometry active_job
execute store result score #geo_index rw.sys run data get storage railway:geometry job.index
execute store result storage railway:geometry_work ctx.index int 1 run scoreboard players get #geo_index rw.sys
