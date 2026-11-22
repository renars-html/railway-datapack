execute if score #scan rw.sys >= #mark_length rw.sys run return run function railway:dev/internal/station_finish
execute if score #scan_budget rw.sys matches 0 run return 0
execute store result storage railway:scratch scan.index int 1 run scoreboard players get #scan rw.sys
execute store result storage railway:scratch scan.geometry int 1 run scoreboard players get #mark_path rw.sys
function railway:dev/internal/station_measure with storage railway:scratch scan
scoreboard players add #scan rw.sys 1
scoreboard players remove #scan_budget rw.sys 1
return run function railway:dev/internal/station_scan_step
