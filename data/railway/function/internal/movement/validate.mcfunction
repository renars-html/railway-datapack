scoreboard players set #loaded rw.sys 0
scoreboard players set #bad rw.sys 0
$execute as @e[tag=railway.cart,scores={rw.train=$(id)}] run function railway:internal/movement/validate_cart
$execute store result score #expected rw.sys run data get storage railway:state trains.t$(id).carts
execute unless score #loaded rw.sys = #expected rw.sys run return 0
execute unless score #bad rw.sys matches 0 run return 0
return 1
