tellraw @s [{"text":"[Railway test] run="},{"score":{"name":"#run","objective":"rw.dev"}},{"text":" phase="},{"score":{"name":"#phase","objective":"rw.dev"}},{"text":"/318 speed="},{"score":{"name":"#speed","objective":"rw.dev"}},{"text":" NoGravity="},{"score":{"name":"#gravity","objective":"rw.dev"}},{"text":" fault="},{"score":{"name":"#fault","objective":"rw.dev"}},{"text":" rider-loss transitions="},{"score":{"name":"#loss","objective":"rw.dev"}},{"text":" (manual dismounts also count)"}]
data get storage railway:dev fixture.origin
data get entity @e[type=minecraft:minecart,tag=railway.dev.rider,limit=1] Pos
data get entity @e[type=minecraft:chest_minecart,tag=railway.dev.cargo,limit=1] Items
