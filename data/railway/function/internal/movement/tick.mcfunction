function railway:internal/movement/ensure_motion
execute store result storage railway:scratch ctx.id int 1 run scoreboard players get @s rw.train
# Every controller pauses on its first tick after any reload, including unloaded controllers.
execute unless score @s rw.epoch = #epoch rw.sys run function railway:internal/movement/reload_pause with storage railway:scratch ctx
execute if score @s rw.override matches 0 store result score #valid rw.sys run function railway:internal/movement/validate_runtime with storage railway:scratch ctx
execute if score @s rw.override matches 1 store result score #valid rw.sys run function railway:internal/movement/validate with storage railway:scratch ctx
execute unless score #valid rw.sys matches 1 if score @s rw.override matches 0 run function railway:internal/movement/fault with storage railway:scratch ctx
function railway:internal/movement/integrate with storage railway:scratch ctx
scoreboard players operation #train_pos rw.sys = @s rw.pos
function railway:internal/movement/move_members with storage railway:scratch ctx
