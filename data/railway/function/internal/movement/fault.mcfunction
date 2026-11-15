scoreboard players set @s rw.vel 0
scoreboard players set @s rw.run 0
$execute unless data storage railway:state trains.t$(id){state:"faulted"} run tellraw @a[distance=..64] {"text":"[Railway] Registered train paused: missing member or UUID/index mismatch. No carts have been replaced.","color":"red"}
$data modify storage railway:state trains.t$(id).state set value "faulted"
