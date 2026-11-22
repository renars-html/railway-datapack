$data modify storage railway:routes routes.r$(route) set value {state:"compiling"}
$data modify storage railway:routes jobs.j$(route) set value {stage:"stops",index:0,draft:{id:$(route),revision:1,profile:$(profile),cruise:$(cruise),brake:$(brake),cache:"p$(profile)_v$(cruise)_b$(brake)",stops:[]}}
$data modify storage railway:routes jobs.j$(route).input set from storage railway:route_work request.stops
$execute store result storage railway:routes jobs.j$(route).draft.accel int 1 run scoreboard players get #route_accel rw.sys
$execute store result storage railway:routes jobs.j$(route).draft.dwell int 1 run scoreboard players get #route_dwell rw.sys
$execute store result storage railway:routes jobs.j$(route).draft.count int 1 run scoreboard players get #stop_count rw.sys
$execute store result storage railway:routes jobs.j$(route).draft.length int 1 run scoreboard players get #fine_length rw.sys
$data modify storage railway:routes active_job set value {route:$(route)}
data modify storage railway:api result set value {ok:1b}
execute store result storage railway:api result.route int 1 run scoreboard players get #route_id rw.sys
