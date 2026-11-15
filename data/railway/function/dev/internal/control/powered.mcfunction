function railway:dev/internal/occupied
execute if score #occupied rw.dev matches 1 run return run tellraw @s {"text": "[Railway test] Dismount before repositioning the test carts.", "color": "aqua"}
scoreboard players set #run rw.dev 0
scoreboard players set #phase rw.dev 276
function railway:dev/internal/tick
tellraw @s {"text": "[Railway test] Passenger cart repositioned to powered. Board it, wait 10 seconds, then start again.", "color": "aqua"}
