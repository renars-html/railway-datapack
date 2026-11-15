$data modify storage railway:stations stations.s$(id) set value {sample:$(sample),profile:$(profile)}
$kill @e[type=minecraft:marker,tag=railway.station_marker,scores={rw.stationid=$(id)}]
$data modify storage railway:motion target set from storage railway:dev_path frames[$(sample)]
execute summon minecraft:marker run function railway:dev/internal/station_marker with storage railway:scratch mark
$tellraw @a[distance=..100] {"text":"[Railway] Saved center station $(id). Use station_stop {train:ID,station:$(id),dwell:100}.","color":"aqua"}
