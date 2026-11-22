scoreboard players set #recover_permit rw.sys 1
execute unless score @s rw.recover matches 1 run return 1
scoreboard players set #recover_permit rw.sys 0
scoreboard players add @s rw.recage 1
execute if score @s rw.recage matches 200.. run return run function railway:internal/recovery/timeout with storage railway:scratch ctx
execute if score @s rw.grace matches 1.. run return run scoreboard players remove @s rw.grace 1
execute unless score #valid rw.sys matches 1 run return 0
execute store result score #recovery_ready rw.sys run function railway:internal/recovery/controller_ready with storage railway:scratch ctx
execute unless score #recovery_ready rw.sys matches 1 run return 0
function railway:internal/recovery/finish
scoreboard players set #recover_permit rw.sys 1
return 1
