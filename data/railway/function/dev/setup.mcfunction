# Replaces a 16x16x6 area beginning at the caller's feet. Disposable test world only.
execute unless entity @s[type=minecraft:player,gamemode=creative] run return run tellraw @s {"text": "[Railway test] Setup requires a Creative player.", "color": "aqua"}
execute unless dimension minecraft:overworld run return run tellraw @s {"text": "[Railway test] Setup is restricted to the Overworld.", "color": "aqua"}
execute if data storage railway:dev fixture.registered run return run tellraw @s {"text": "[Railway test] A fixture is already registered. Return to it and run dev/cleanup first.", "color": "aqua"}
execute store result score #setup_y rw.dev run data get entity @s Pos[1] 1
execute unless score #setup_y rw.dev matches -60..300 run return run tellraw @s {"text": "[Railway test] Build between Y=-60 and Y=300.", "color": "aqua"}
execute align xyz positioned ~ ~1 ~ run function railway:dev/internal/build
teleport @s ~5.5 ~2 ~5.5
tellraw @s {"text": "[Railway test] Loop built nearby. Passenger cart holds at the north rail; cargo cart contains 7 diamonds and 11 cobblestone. Right-click to board, then run /function railway:dev/start.", "color": "aqua"}
