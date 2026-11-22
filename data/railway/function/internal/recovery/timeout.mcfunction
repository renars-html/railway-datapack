scoreboard players set @s rw.recover 0
scoreboard players set @s rw.resume 0
scoreboard players set @s rw.run 0
scoreboard players set @s rw.vel 0
function railway:internal/movement/fault with storage railway:scratch ctx
$tellraw @a[distance=..110] {"text":"[Railway] Train $(id) recovery timed out: inspect members, controller, route/geometry and loading lease before starting manually. No entities were replaced.","color":"red"}
return 0
