$execute store result score #geo_len rw.sys run data get storage railway:edge_geometry graphs.g$(graph).edges.e$(edge).length
execute store result score #geo_total rw.sys run data get storage railway:geometry job.total
scoreboard players operation #geo_total rw.sys += #geo_len rw.sys
execute store result storage railway:geometry job.total int 1 run scoreboard players get #geo_total rw.sys
execute if data storage railway:geometry_work ctx{edge:2} run data modify storage railway:geometry job.direct set value 1
execute if data storage railway:geometry_work ctx{edge:4} run data modify storage railway:geometry job.detour set value 1
