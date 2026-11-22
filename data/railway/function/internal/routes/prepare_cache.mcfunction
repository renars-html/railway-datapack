$data modify storage railway:routes jobs.j$(id).draft.cache_reused set value 0b
$execute if data storage railway:routes caches.$(cache){ready:1b} run data modify storage railway:routes jobs.j$(id).draft.cache_reused set value 1b
$execute if data storage railway:routes caches.$(cache){ready:1b} run return 1
$execute unless data storage railway:routes caches.$(cache).thresholds run data modify storage railway:routes caches.$(cache) set value {ready:0b,thresholds:[]}
return 1
