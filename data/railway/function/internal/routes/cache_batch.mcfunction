$data modify storage railway:route_work cache set from storage railway:routes jobs.j$(route).draft
scoreboard players set #cache_budget rw.sys 32
function railway:internal/routes/cache_step with storage railway:route_work cache
return 1
