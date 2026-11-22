$execute unless data storage railway:geometry paths.p$(path){state:"ready"} run return run scoreboard players set #geo_valid rw.sys 0
$scoreboard players set #geo_profile rw.sys $(profile)
execute unless score #geo_profile rw.sys = #base_profile rw.sys run return run scoreboard players set #geo_valid rw.sys 0
$scoreboard players set #length rw.dev $(count)
$scoreboard players set #fine_length rw.sys $(fine_length)
$scoreboard players set #speed_factor rw.sys $(speed_factor)
$scoreboard players set #max_velocity rw.sys $(max_velocity)
scoreboard players set #geo_valid rw.sys 1
