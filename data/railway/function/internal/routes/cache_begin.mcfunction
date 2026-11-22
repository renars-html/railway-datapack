$data modify storage railway:route_work cache set from storage railway:routes jobs.j$(route).draft
function railway:internal/routes/prepare_cache with storage railway:route_work cache
$data modify storage railway:routes jobs.j$(route).stage set value "cache"
return 1
