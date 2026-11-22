$data modify storage railway:route_work cache set from storage railway:routes jobs.j$(route).draft
function railway:internal/routes/read_cruise_distance with storage railway:route_work cache
scoreboard players set #leg_i rw.sys 0
function railway:internal/routes/compile_legs with storage railway:routes active_job
$data modify storage railway:routes routes.r$(route) set from storage railway:routes jobs.j$(route).draft
$data modify storage railway:routes routes.r$(route).state set value "ready"
$data remove storage railway:routes jobs.j$(route)
data remove storage railway:routes active_job
$tellraw @a {"text":"[Railway] Route $(route) compiled and ready. Station snapshots and braking profile are reusable.","color":"aqua"}
return 1
