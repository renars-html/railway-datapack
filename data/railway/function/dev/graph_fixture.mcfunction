execute if data storage railway:graph_fixture graph run return run function railway:api/graph/inspect with storage railway:graph_fixture
execute store result score #g_created rw.sys run function railway:api/graph/create
execute unless score #g_created rw.sys matches 1 run return 0
execute store result storage railway:graph_fixture graph int 1 run scoreboard players get #g_id rw.sys
data modify storage railway:graph_fixture node set value 1
function railway:api/graph/add_node with storage railway:graph_fixture
data modify storage railway:graph_fixture node set value 2
function railway:api/graph/add_node with storage railway:graph_fixture
data modify storage railway:graph_fixture node set value 3
function railway:api/graph/add_node with storage railway:graph_fixture
data modify storage railway:graph_fixture node set value 4
function railway:api/graph/add_node with storage railway:graph_fixture
data modify storage railway:graph_fixture node set value 5
function railway:api/graph/add_node with storage railway:graph_fixture
data modify storage railway:graph_fixture node set value 6
function railway:api/graph/add_node with storage railway:graph_fixture
data modify storage railway:graph_fixture node set value 7
function railway:api/graph/add_node with storage railway:graph_fixture
data modify storage railway:graph_fixture node set value 8
function railway:api/graph/add_node with storage railway:graph_fixture
data modify storage railway:graph_fixture node set value 9
function railway:api/graph/add_node with storage railway:graph_fixture
data modify storage railway:graph_fixture from set value 1
data modify storage railway:graph_fixture to set value 2
data modify storage railway:graph_fixture cost set value 10
function railway:api/graph/add_edge with storage railway:graph_fixture
data modify storage railway:graph_fixture from set value 2
data modify storage railway:graph_fixture to set value 3
data modify storage railway:graph_fixture cost set value 10
function railway:api/graph/add_edge with storage railway:graph_fixture
data modify storage railway:graph_fixture from set value 3
data modify storage railway:graph_fixture to set value 6
data modify storage railway:graph_fixture cost set value 10
function railway:api/graph/add_edge with storage railway:graph_fixture
data modify storage railway:graph_fixture from set value 2
data modify storage railway:graph_fixture to set value 4
data modify storage railway:graph_fixture cost set value 5
function railway:api/graph/add_edge with storage railway:graph_fixture
data modify storage railway:graph_fixture from set value 4
data modify storage railway:graph_fixture to set value 5
data modify storage railway:graph_fixture cost set value 5
function railway:api/graph/add_edge with storage railway:graph_fixture
data modify storage railway:graph_fixture from set value 5
data modify storage railway:graph_fixture to set value 6
data modify storage railway:graph_fixture cost set value 5
function railway:api/graph/add_edge with storage railway:graph_fixture
data modify storage railway:graph_fixture from set value 1
data modify storage railway:graph_fixture to set value 7
data modify storage railway:graph_fixture cost set value 50
function railway:api/graph/add_edge with storage railway:graph_fixture
data modify storage railway:graph_fixture from set value 7
data modify storage railway:graph_fixture to set value 6
data modify storage railway:graph_fixture cost set value 5
function railway:api/graph/add_edge with storage railway:graph_fixture
data modify storage railway:graph_fixture from set value 6
data modify storage railway:graph_fixture to set value 1
data modify storage railway:graph_fixture cost set value 20
function railway:api/graph/add_edge with storage railway:graph_fixture
data modify storage railway:graph_fixture from set value 6
data modify storage railway:graph_fixture to set value 8
data modify storage railway:graph_fixture cost set value 7
function railway:api/graph/add_edge with storage railway:graph_fixture
function railway:api/graph/seal with storage railway:graph_fixture
return run function railway:api/graph/inspect with storage railway:graph_fixture
