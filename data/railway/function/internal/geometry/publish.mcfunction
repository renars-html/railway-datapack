execute store result score #geo_step rw.sys run data get storage railway:geometry job.step
execute store result score #geo_count rw.sys run data get storage railway:geometry job.count
$execute store result storage railway:geometry paths.p$(path).metadata.count int 1 run scoreboard players get #geo_count rw.sys
scoreboard players operation #geo_fine rw.sys = #geo_count rw.sys
scoreboard players operation #geo_fine rw.sys *= #thousand rw.sys
$execute store result storage railway:geometry paths.p$(path).metadata.fine_length int 1 run scoreboard players get #geo_fine rw.sys
$execute store result storage railway:geometry paths.p$(path).metadata.metrics.velocity_scale double 0.000002 run scoreboard players get #geo_step rw.sys
$execute store result storage railway:geometry paths.p$(path).metadata.metrics.accel_scale double 0.00004 run scoreboard players get #geo_step rw.sys
$execute store result storage railway:geometry paths.p$(path).metadata.metrics.distance_scale double 0.0000001 run scoreboard players get #geo_step rw.sys
scoreboard players operation #geo_factor rw.sys = #geo_step rw.sys
scoreboard players operation #geo_factor rw.sys *= #two rw.sys
$execute store result storage railway:geometry paths.p$(path).metadata.speed_factor int 1 run scoreboard players get #geo_factor rw.sys
scoreboard players set #geo_max rw.sys 20000000
scoreboard players operation #geo_max rw.sys /= #geo_factor rw.sys
$execute store result storage railway:geometry paths.p$(path).metadata.max_velocity int 1 run scoreboard players get #geo_max rw.sys
$data modify storage railway:geometry paths.p$(path).metadata.path set value $(path)
$data modify storage railway:geometry paths.p$(path).metadata.graph set value $(graph)
$data modify storage railway:geometry paths.p$(path).metadata.profile set from storage railway:geometry job.profile
$data modify storage railway:geometry paths.p$(path).metadata.switch_mode set from storage railway:geometry job.detour
$data modify storage railway:geometry paths.p$(path).state set value "ready"
data remove storage railway:geometry job
data remove storage railway:geometry active_job
$tellraw @a {"text":"[Railway] Geometry for path $(path) ready. Assign it to the stopped test train with api/train/assign_path.","color":"aqua"}
return 1
