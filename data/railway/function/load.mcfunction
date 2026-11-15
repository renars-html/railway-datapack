function railway:internal/core/load
# Dev-only objective and immutable fixture samples. Reload always pauses motion.
execute unless data storage railway:dev initialized run scoreboard objectives add rw.dev dummy
data modify storage railway:dev initialized set value 1b
scoreboard players set #length rw.dev 318
scoreboard players set #rate_unit rw.dev 2494
scoreboard players set #hundred rw.dev 100
scoreboard players set #ten rw.dev 10
# 13 samples = 1.621 blocks between centers, about 0.641 blocks clear on straights.
scoreboard players set #offset rw.dev 13
execute unless score #phase rw.dev matches 0..317 run scoreboard players set #phase rw.dev 0
execute unless score #speed rw.dev matches 1..8 run scoreboard players set #speed rw.dev 3
execute unless score #gravity rw.dev matches 0..1 run scoreboard players set #gravity rw.dev 1
execute unless score #fault rw.dev matches 0..1 run scoreboard players set #fault rw.dev 0
execute unless score #loss rw.dev matches 0.. run scoreboard players set #loss rw.dev 0
scoreboard players set #last_riders rw.dev 0
scoreboard players set #run rw.dev 0
scoreboard players set #enabled rw.dev 0
execute if data storage railway:dev fixture.registered run scoreboard players set #enabled rw.dev 1
function railway:dev/internal/path_load
execute if data storage railway:dev loop_train run scoreboard players set #enabled rw.dev 0
