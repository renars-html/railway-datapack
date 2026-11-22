$execute store result score #route_count rw.sys run data get storage railway:routes routes.r$(route).count
scoreboard players add @s rw.stopidx 1
scoreboard players operation @s rw.stopidx %= #route_count rw.sys
