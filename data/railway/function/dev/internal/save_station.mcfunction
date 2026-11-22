$data modify storage railway:stations stations.s$(id) set value {sample:$(sample),profile:$(profile),geometry:$(geometry)}
$kill @e[type=minecraft:marker,tag=railway.station_marker,scores={rw.stationid=$(id)}]
execute if score #mark_path rw.sys matches 0 run function railway:dev/internal/save_base_point with storage railway:scratch mark
execute if score #mark_path rw.sys matches 1.. run function railway:dev/internal/save_path_point with storage railway:scratch mark
execute summon minecraft:marker run function railway:dev/internal/station_marker with storage railway:scratch mark
$tellraw @a[distance=..100] {"text":"[Railway] Saved center station $(id). Use station_stop {train:ID,station:$(id),dwell:100}.","color":"aqua"}
