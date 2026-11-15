execute store result storage railway:scratch ctx.id int 1 run scoreboard players get @s rw.train
# Every controller pauses on its first tick after any reload, including unloaded controllers.
execute unless score @s rw.epoch = #epoch rw.sys run function railway:internal/movement/reload_pause with storage railway:scratch ctx
execute store result score #valid rw.sys run function railway:internal/movement/validate with storage railway:scratch ctx
execute unless score #valid rw.sys matches 1 run function railway:internal/movement/fault with storage railway:scratch ctx
execute if score @s rw.run matches 1 run scoreboard players operation @s rw.phase += @s rw.speed
scoreboard players operation @s rw.phase %= #length rw.dev
scoreboard players operation #train_phase rw.sys = @s rw.phase
function railway:internal/movement/move_members with storage railway:scratch ctx
