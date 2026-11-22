execute store result storage railway:route_work follow.route int 1 run scoreboard players get @s rw.route
execute store result storage railway:route_work follow.index int 1 run scoreboard players get @s rw.stopidx
function railway:internal/routes/follow_stop with storage railway:route_work follow
