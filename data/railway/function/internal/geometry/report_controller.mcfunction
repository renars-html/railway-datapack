execute if score @s rw.geom matches 0 run function railway:internal/movement/report_units with storage railway:dev_path metrics
execute if score @s rw.geom matches 1.. run function railway:internal/movement/report_units with entity @s data.path_geometry.metrics
