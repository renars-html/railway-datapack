$data modify storage railway:geometry_work a set from storage railway:geometry paths.p$(path).frames[$(index)]
$data modify storage railway:geometry_work b set from storage railway:geometry paths.p$(path).frames[$(next)]
scoreboard players set #geo_mask rw.sys 0
execute store result score #geo_a rw.sys run data get storage railway:geometry_work a.ax
execute store result score #geo_b rw.sys run data get storage railway:geometry_work b.ax
scoreboard players operation #geo_b rw.sys -= #geo_a rw.sys
$execute store result storage railway:geometry paths.p$(path).frames[$(index)].dx int 1 run scoreboard players get #geo_b rw.sys
execute unless score #geo_b rw.sys matches 0 run scoreboard players add #geo_mask rw.sys 1
execute store result score #geo_a rw.sys run data get storage railway:geometry_work a.ay
execute store result score #geo_b rw.sys run data get storage railway:geometry_work b.ay
scoreboard players operation #geo_b rw.sys -= #geo_a rw.sys
$execute store result storage railway:geometry paths.p$(path).frames[$(index)].dy int 1 run scoreboard players get #geo_b rw.sys
execute unless score #geo_b rw.sys matches 0 run scoreboard players add #geo_mask rw.sys 2
execute store result score #geo_a rw.sys run data get storage railway:geometry_work a.az
execute store result score #geo_b rw.sys run data get storage railway:geometry_work b.az
scoreboard players operation #geo_b rw.sys -= #geo_a rw.sys
$execute store result storage railway:geometry paths.p$(path).frames[$(index)].dz int 1 run scoreboard players get #geo_b rw.sys
execute unless score #geo_b rw.sys matches 0 run scoreboard players add #geo_mask rw.sys 4
execute store result storage railway:geometry_work ctx.mask int 1 run scoreboard players get #geo_mask rw.sys
function railway:internal/geometry/set_axes with storage railway:geometry_work ctx
