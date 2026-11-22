scoreboard players set #report_trains rw.sys 0
scoreboard players set #report_carts rw.sys 0
execute in minecraft:overworld as @e[type=minecraft:marker,tag=railway.active] run scoreboard players add #report_trains rw.sys 1
execute in minecraft:overworld as @e[type=minecraft:minecart,tag=railway.cart] run scoreboard players add #report_carts rw.sys 1
execute in minecraft:overworld as @e[type=minecraft:chest_minecart,tag=railway.cart] run scoreboard players add #report_carts rw.sys 1
tellraw @s [{"text":"[Railway] Loaded bound controllers: "},{"score":{"name":"#report_trains","objective":"rw.sys"}},{"text":"; loaded registered carts (including unbound): "},{"score":{"name":"#report_carts","objective":"rw.sys"}},{"text":". Moving/held bound carts each get one UUID verification and one path lookup per tick. This is workload count, not timing."}]
tellraw @s {"text":"[Railway] Run /tick query directly for server tick-time output. For a 60-second CPU profile: /debug start, wait, then /debug stop. Compare identical stopped/moving conditions and view distance.","color":"aqua"}
return 1
