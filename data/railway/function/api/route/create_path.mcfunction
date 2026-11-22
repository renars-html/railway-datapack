data modify storage railway:api result set value {ok:0b,error:"Use ready current path geometry and station IDs registered on that same path."}
execute if data storage railway:routes active_job run return 0
$data modify storage railway:route_work path_request set value {path:$(path),stops:$(stops),speed:$(speed),accel:$(accel),decel:$(decel),dwell:$(dwell)}
scoreboard players set #route_geometry rw.sys 0
execute store result score #route_geometry rw.sys run data get storage railway:route_work path_request.path
execute unless score #route_geometry rw.sys matches 1..2147483646 run return 0
execute store result storage railway:route_work ctx.geometry int 1 run scoreboard players get #route_geometry rw.sys
execute store result score #path_profile_ready rw.sys run function railway:internal/routes/path_profile with storage railway:route_work ctx
execute unless score #path_profile_ready rw.sys matches 1 run return 0
execute store result score #new_route_ok rw.sys run function railway:api/route/create with storage railway:route_work path_request
function railway:internal/geometry/restore_base
execute unless score #new_route_ok rw.sys matches 1 run return 0
data modify storage railway:route_work ctx.geometry set from storage railway:route_work path_request.path
function railway:internal/routes/mark_path with storage railway:route_work ctx
return 1
