function railway:dev/internal/occupied
execute if score #occupied rw.dev matches 1 run return run tellraw @s {"text": "[Railway test] Dismount before cleanup.", "color": "aqua"}
function railway:dev/internal/count
execute unless score #rider_carts rw.dev matches 1 run return run tellraw @s {"text": "[Railway test] Cleanup requires both original carts loaded. Inspect missing/duplicate carts first.", "color": "aqua"}
execute unless score #cargo_carts rw.dev matches 1 run return run tellraw @s {"text": "[Railway test] Cleanup requires both original carts loaded. Inspect missing/duplicate carts first.", "color": "aqua"}
scoreboard players set #enabled rw.dev 0
scoreboard players set #run rw.dev 0
# Intentionally deletes only fixture cargo. Prevent item drops from the test cart.
data remove entity @e[type=minecraft:chest_minecart,tag=railway.dev.cargo,limit=1] Items
kill @e[type=minecraft:minecart,tag=railway.dev.rider]
kill @e[type=minecraft:chest_minecart,tag=railway.dev.cargo]
kill @e[type=minecraft:marker,tag=railway.dev.anchor]
data remove storage railway:dev fixture
tellraw @s {"text": "[Railway test] Test carts, marker, and test cargo removed. The platform/track remains; original blocks cannot be restored.", "color": "aqua"}
