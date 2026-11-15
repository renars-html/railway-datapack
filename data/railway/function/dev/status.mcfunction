execute in minecraft:overworld unless entity @e[type=minecraft:marker,tag=railway.dev.anchor] run return run tellraw @s {"text": "[Railway test] No loaded fixture. Return to its location, or run dev/setup in an empty Creative test area.", "color": "aqua"}
execute in minecraft:overworld at @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] run function railway:dev/internal/control/status
