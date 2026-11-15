# One score check when the opt-in fixture is absent. Never selects ordinary carts.
execute if score #enabled rw.dev matches 1 in minecraft:overworld as @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] at @s run function railway:dev/internal/tick
