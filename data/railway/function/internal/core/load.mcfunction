# Persistent registry; reload never resets IDs, membership or ownership.
execute unless data storage railway:state schema run function railway:internal/core/init
execute unless data storage railway:state movement_schema run function railway:internal/movement/init
scoreboard players add #epoch rw.sys 1
scoreboard players set #negative rw.sys -1
execute unless data storage railway:state smooth_schema run function railway:internal/movement/smooth_init
scoreboard players set #thousand rw.sys 1000
scoreboard players set #fine_length rw.sys 318000
scoreboard players set #fifty rw.sys 50
execute unless data storage railway:state station_schema run function railway:internal/movement/station_init
scoreboard players set #two rw.sys 2
scoreboard players set #speed_factor rw.sys 2494
execute unless data storage railway:state override_schema run function railway:internal/movement/override_init
scoreboard players set #fivehundred rw.sys 500
scoreboard players set #station_job rw.sys 0
execute unless data storage railway:state performance_schema run function railway:internal/performance/init
scoreboard players set #tick rw.sys 0
scoreboard players set #sixteen rw.sys 16
execute unless data storage railway:state routes_schema run function railway:internal/routes/init
execute unless data storage railway:state graph_schema run function railway:internal/graph/init
