$execute if data storage railway:routes caches.$(cache){ready:1b} run return run function railway:internal/routes/cache_done with storage railway:routes active_job
execute if score #cache_budget rw.sys matches 0 run return 1
$execute store result score #cache_v rw.sys run data get storage railway:routes caches.$(cache).thresholds
$scoreboard players set #cache_brake rw.sys $(brake)
$execute if score #cache_v rw.sys matches $(cruise).. run function railway:internal/routes/check_cache_end with storage railway:route_work cache
$execute if data storage railway:routes caches.$(cache){ready:1b} run return run function railway:internal/routes/cache_done with storage railway:routes active_job
function railway:internal/routes/cache_distance
execute store result storage railway:route_work threshold int 1 run scoreboard players get #cache_distance rw.sys
$data modify storage railway:routes caches.$(cache).thresholds append from storage railway:route_work threshold
scoreboard players remove #cache_budget rw.sys 1
return run function railway:internal/routes/cache_step with storage railway:route_work cache
