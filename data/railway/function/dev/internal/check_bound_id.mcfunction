$execute unless entity @e[type=minecraft:marker,tag=railway.active,scores={rw.train=$(id)}] run return 0
return run function railway:internal/movement/validate with storage railway:scratch ctx
