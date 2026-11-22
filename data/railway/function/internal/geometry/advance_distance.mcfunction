execute store result score #geo_step rw.sys run data get storage railway:geometry job.step
execute store result score #geo_carry rw.sys run data get storage railway:geometry job.carry
execute store result score #geo_remainder rw.sys run data get storage railway:geometry job.remainder
scoreboard players operation #geo_distance rw.sys += #geo_step rw.sys
scoreboard players operation #geo_carry rw.sys += #geo_remainder rw.sys
execute if score #geo_carry rw.sys >= #geo_count rw.sys run scoreboard players add #geo_distance rw.sys 1
execute if score #geo_carry rw.sys >= #geo_count rw.sys run scoreboard players operation #geo_carry rw.sys -= #geo_count rw.sys
execute store result storage railway:geometry job.distance int 1 run scoreboard players get #geo_distance rw.sys
execute store result storage railway:geometry job.carry int 1 run scoreboard players get #geo_carry rw.sys
