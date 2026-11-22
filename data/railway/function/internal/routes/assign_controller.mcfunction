function railway:internal/recovery/cancel
$scoreboard players set @s rw.route $(route)
scoreboard players set @s rw.stopidx 0
scoreboard players set @s rw.auto 1
scoreboard players set @s rw.station 0
scoreboard players set @s rw.remain 0
$execute store result score @s rw.cruise run data get storage railway:routes routes.r$(route).cruise
$execute store result score @s rw.accel run data get storage railway:routes routes.r$(route).accel
$execute store result score @s rw.brake run data get storage railway:routes routes.r$(route).brake
$data modify entity @s data.railway.cache set from storage railway:routes routes.r$(route).cache
$data modify entity @s data.railway.profile set from storage railway:routes routes.r$(route).profile
