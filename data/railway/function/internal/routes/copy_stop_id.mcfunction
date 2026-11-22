scoreboard players set #stop_id rw.sys 0
$data modify storage railway:route_work raw_id set from storage railway:routes jobs.j$(route).input[$(index)]
execute store result score #stop_id rw.sys run data get storage railway:route_work raw_id
