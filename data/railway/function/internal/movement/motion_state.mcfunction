$execute if score @s rw.emerg matches 1 unless data storage railway:state trains.t$(id){state:"emergency"} run data modify storage railway:state trains.t$(id).state set value "emergency"
execute if score @s rw.emerg matches 1 run return 0
$execute if score @s rw.vel < #target rw.sys unless data storage railway:state trains.t$(id){state:"accelerating"} run data modify storage railway:state trains.t$(id).state set value "accelerating"
$execute if score @s rw.vel > #target rw.sys unless data storage railway:state trains.t$(id){state:"braking"} run data modify storage railway:state trains.t$(id).state set value "braking"
$execute if score @s rw.vel = #target rw.sys if score @s rw.run matches 1 unless data storage railway:state trains.t$(id){state:"running"} run data modify storage railway:state trains.t$(id).state set value "running"
$execute if score @s rw.vel matches 0 if score @s rw.run matches 0 unless data storage railway:state trains.t$(id){state:"stopped"} run data modify storage railway:state trains.t$(id).state set value "stopped"
$execute if score @s rw.station matches 2 unless data storage railway:state trains.t$(id){state:"dwelling"} run data modify storage railway:state trains.t$(id).state set value "dwelling"
$execute if score @s rw.signal matches 1 if score @s rw.vel matches 0 unless data storage railway:state trains.t$(id){state:"signal_wait"} run data modify storage railway:state trains.t$(id).state set value "signal_wait"
