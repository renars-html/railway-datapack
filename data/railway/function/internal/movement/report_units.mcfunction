$execute store result storage railway:api result.actual_blocks_per_second double $(velocity_scale) run scoreboard players get @s rw.vel
$execute store result storage railway:api result.target_blocks_per_second double $(velocity_scale) run scoreboard players get @s rw.cruise
$execute store result storage railway:api result.acceleration double $(accel_scale) run scoreboard players get @s rw.accel
$execute store result storage railway:api result.deceleration double $(accel_scale) run scoreboard players get @s rw.brake
$execute store result storage railway:api result.station_remaining double $(distance_scale) run scoreboard players get @s rw.remain
