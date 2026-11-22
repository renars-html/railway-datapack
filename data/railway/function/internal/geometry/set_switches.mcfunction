execute at @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] if score #switch_mode rw.sys matches 0 run setblock ~30 ~0 ~2 minecraft:rail[shape=east_west]
execute at @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] if score #switch_mode rw.sys matches 0 run setblock ~60 ~0 ~2 minecraft:rail[shape=east_west]
execute at @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] if score #switch_mode rw.sys matches 1 run setblock ~30 ~0 ~2 minecraft:rail[shape=south_west]
execute at @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] if score #switch_mode rw.sys matches 1 run setblock ~60 ~0 ~2 minecraft:rail[shape=south_east]
