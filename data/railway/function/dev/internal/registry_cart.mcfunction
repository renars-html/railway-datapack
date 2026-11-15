tag @s add railway.registry_test
execute if entity @s[type=minecraft:chest_minecart] run item replace entity @s container.0 with minecraft:diamond 7
execute if entity @s[type=minecraft:chest_minecart] run item replace entity @s container.1 with minecraft:cobblestone 11
function railway:api/train/attach with storage railway:registry_test
