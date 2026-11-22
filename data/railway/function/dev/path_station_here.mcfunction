$data modify storage railway:scratch path_mark_request set value {path:$(path),station:$(station)}
scoreboard players set #mark_requested_path rw.sys 0
execute store result score #mark_requested_path rw.sys run data get storage railway:scratch path_mark_request.path
execute unless score #mark_requested_path rw.sys matches 1..2147483646 run return 0
execute store result storage railway:scratch path_mark_request.geometry int 1 run scoreboard players get #mark_requested_path rw.sys
return run function railway:dev/internal/start_path_mark with storage railway:scratch path_mark_request
