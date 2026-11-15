execute store result storage railway:scratch ctx.id int 1 run data get storage railway:dev loop_train
execute store result score #bound_valid rw.sys run function railway:dev/internal/check_bound_id with storage railway:scratch ctx
