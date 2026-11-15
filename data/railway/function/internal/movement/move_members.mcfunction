# No movement of an entity whose UUID failed validation, even while fault-held.
$execute as @e[tag=railway.cart,scores={rw.train=$(id)}] run function railway:internal/movement/cart_step
