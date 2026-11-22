data modify storage railway:api result set value {ok:0b,error:"Route creation requires integer stops list (2..16), dwell 1..12000, speed .05..20; one compile job may run at a time."}
execute if data storage railway:routes active_job run return 0
$data modify storage railway:route_work request set value {stops:$(stops),speed:$(speed),accel:$(accel),decel:$(decel),dwell:$(dwell)}
scoreboard players set #stop_count rw.sys 0
scoreboard players set #route_cruise rw.sys 0
scoreboard players set #route_dwell rw.sys 0
execute store result score #stop_count rw.sys run data get storage railway:route_work request.stops
execute store result score #route_cruise rw.sys run data get storage railway:route_work request.speed 1000
execute store result score #route_dwell rw.sys run data get storage railway:route_work request.dwell
execute unless score #stop_count rw.sys matches 2..16 run return 0
execute unless score #route_cruise rw.sys matches 50..20000 run return 0
execute unless score #route_dwell rw.sys matches 1..12000 run return 0
scoreboard players operation #route_cruise rw.sys *= #thousand rw.sys
scoreboard players operation #route_cruise rw.sys /= #speed_factor rw.sys
execute store result score #route_accel rw.sys run data get storage railway:route_work request.accel 1000
execute store result score #route_brake rw.sys run data get storage railway:route_work request.decel 1000
execute if score #route_accel rw.sys matches ..1999 run scoreboard players set #route_accel rw.sys 2000
execute if score #route_brake rw.sys matches ..1999 run scoreboard players set #route_brake rw.sys 2000
execute if score #route_accel rw.sys matches 5001.. run scoreboard players set #route_accel rw.sys 5000
execute if score #route_brake rw.sys matches 5001.. run scoreboard players set #route_brake rw.sys 5000
scoreboard players add #route_accel rw.sys 250
scoreboard players add #route_brake rw.sys 250
scoreboard players operation #route_accel rw.sys /= #fivehundred rw.sys
scoreboard players operation #route_brake rw.sys /= #fivehundred rw.sys
scoreboard players operation #route_accel rw.sys *= #fivehundred rw.sys
scoreboard players operation #route_brake rw.sys *= #fivehundred rw.sys
scoreboard players operation #route_accel rw.sys /= #fifty rw.sys
scoreboard players operation #route_brake rw.sys /= #fifty rw.sys
execute store result score #route_id rw.sys run data get storage railway:routes next_id
execute if score #route_id rw.sys matches 2147483646.. run return 0
scoreboard players add #route_id rw.sys 1
execute store result storage railway:routes next_id int 1 run scoreboard players get #route_id rw.sys
execute store result storage railway:route_work ctx.route int 1 run scoreboard players get #route_id rw.sys
execute store result storage railway:route_work ctx.profile int 1 run scoreboard players get #profile rw.sys
execute store result storage railway:route_work ctx.cruise int 1 run scoreboard players get #route_cruise rw.sys
execute store result storage railway:route_work ctx.brake int 1 run scoreboard players get #route_brake rw.sys
function railway:internal/routes/new with storage railway:route_work ctx
tellraw @s [{"text":"[Railway] Route "},{"score":{"name":"#route_id","objective":"rw.sys"}},{"text":" queued. Inspect api/route/status {route:ID}; first profile compilation takes a few seconds."}]
return 1
