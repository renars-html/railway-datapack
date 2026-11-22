execute if data storage railway:geometry job{direct:1,detour:1} run return run function railway:internal/geometry/fail with storage railway:geometry active_job
execute store result score #geo_total rw.sys run data get storage railway:geometry job.total
execute unless score #geo_total rw.sys matches 1..10240000 run return run function railway:internal/geometry/fail with storage railway:geometry active_job
scoreboard players set #geo_stride rw.sys 1250
scoreboard players operation #geo_count rw.sys = #geo_total rw.sys
scoreboard players add #geo_count rw.sys 1249
scoreboard players operation #geo_count rw.sys /= #geo_stride rw.sys
execute store result storage railway:geometry job.count int 1 run scoreboard players get #geo_count rw.sys
scoreboard players operation #geo_step rw.sys = #geo_total rw.sys
scoreboard players operation #geo_step rw.sys /= #geo_count rw.sys
execute store result storage railway:geometry job.step int 1 run scoreboard players get #geo_step rw.sys
scoreboard players operation #geo_remainder rw.sys = #geo_total rw.sys
scoreboard players operation #geo_remainder rw.sys %= #geo_count rw.sys
execute store result storage railway:geometry job.remainder int 1 run scoreboard players get #geo_remainder rw.sys
data modify storage railway:geometry job.index set value 0
data modify storage railway:geometry job.distance set value 0
data modify storage railway:geometry job.carry set value 0
data modify storage railway:geometry job.edge_index set value 0
data modify storage railway:geometry job.segment_index set value 0
data modify storage railway:geometry job.segment_start set value 0
data modify storage railway:geometry job.stage set value "frames"
return 1
