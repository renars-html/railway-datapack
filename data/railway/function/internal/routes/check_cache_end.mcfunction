$execute if score #cache_v rw.sys matches $(cruise) run return 0
$data modify storage railway:routes caches.$(cache).ready set value 1b
