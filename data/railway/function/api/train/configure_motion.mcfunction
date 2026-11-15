data modify storage railway:api result set value {ok:0b,error:"Use accel/decel numbers from 0.05 to 50 blocks/s^2 and a loaded bound train."}
$data modify storage railway:scratch request set value {train:$(train)}
scoreboard players set #selected rw.sys 0
execute store result score #selected rw.sys run data get storage railway:scratch request.train 1
execute store result storage railway:scratch ctx.id int 1 run scoreboard players get #selected rw.sys
execute store result score #valid rw.sys run function railway:internal/registry/select with storage railway:scratch ctx
execute unless score #valid rw.sys matches 1 run tellraw @s {"text":"[Railway] Invalid or unknown train ID. Use a positive integer ID printed by train creation.","color":"red"}
execute unless score #valid rw.sys matches 1 run return 0

$data modify storage railway:scratch settings set value {accel:$(accel),decel:$(decel)}
scoreboard players set #accel rw.sys 0
scoreboard players set #brake rw.sys 0
execute store result score #accel rw.sys run data get storage railway:scratch settings.accel 1000
execute store result score #brake rw.sys run data get storage railway:scratch settings.decel 1000
execute unless score #accel rw.sys matches 50..50000 run return 0
execute unless score #brake rw.sys matches 50..50000 run return 0
scoreboard players add #accel rw.sys 25
scoreboard players add #brake rw.sys 25
scoreboard players operation #accel rw.sys /= #fifty rw.sys
scoreboard players operation #brake rw.sys /= #fifty rw.sys
return run function railway:internal/movement/configure with storage railway:scratch ctx
