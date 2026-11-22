$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id),rw.vel=0,rw.run=0}] run return 0
$scoreboard players set @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.route 0
$scoreboard players set @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.auto 0
$scoreboard players set @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.stopidx 0
$scoreboard players set @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.station 0
$scoreboard players set @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] rw.remain 0
$data remove storage railway:state trains.t$(id).service_route
data modify storage railway:api result set value {ok:1b}
tellraw @s {"text":"[Railway] Service route cleared. Train held; manual station/configuration APIs available.","color":"aqua"}
return 1
