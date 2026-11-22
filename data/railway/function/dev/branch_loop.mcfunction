execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.route=1..}] run tellraw @s {"text":"[Railway] Stop and clear_route before creating the branching fixture.","color":"red"}
execute if entity @e[type=minecraft:marker,tag=railway.active,scores={rw.route=1..}] run return 0
execute store result score #branch_built rw.sys run function railway:dev/large_loop
execute unless score #branch_built rw.sys matches 1 run return 0
execute at @e[type=minecraft:marker,tag=railway.dev.anchor,limit=1] run function railway:dev/internal/branch_rails
execute store result score #branch_graph_ok rw.sys run function railway:api/graph/create
execute unless score #branch_graph_ok rw.sys matches 1 run return 0
execute store result storage railway:branch_fixture graph int 1 run scoreboard players get #g_id rw.sys
execute store result storage railway:branch_fixture profile int 1 run scoreboard players get #profile rw.sys
function railway:dev/internal/branch_graph
function railway:dev/internal/branch_edge_data with storage railway:branch_fixture
tellraw @s [{"text":"[Railway] Physical branching fixture ready; graph "},{"score":{"name":"#g_id","objective":"rw.sys"}},{"text":". Closed outer circuit: from 1 to 1 via [3]. Inner detour: via [4,3]."}]
return 1
