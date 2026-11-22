# Normal operation uses local entity sections, not every forced-loaded cart in the dimension.
$execute if score @s rw.override matches 0 as @e[tag=railway.cart,distance=..110,scores={rw.train=$(id)}] run function railway:internal/movement/cart_step
# Explicit recovery can reach any loaded, UUID-verified member.
$execute if score @s rw.override matches 1 as @e[tag=railway.cart,scores={rw.train=$(id)}] run function railway:internal/movement/cart_step
