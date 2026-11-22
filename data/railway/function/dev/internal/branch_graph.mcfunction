data modify storage railway:branch_fixture node set value 1
function railway:api/graph/add_node with storage railway:branch_fixture
data modify storage railway:branch_fixture node set value 2
function railway:api/graph/add_node with storage railway:branch_fixture
data modify storage railway:branch_fixture node set value 3
function railway:api/graph/add_node with storage railway:branch_fixture
data modify storage railway:branch_fixture node set value 4
function railway:api/graph/add_node with storage railway:branch_fixture
data modify storage railway:branch_fixture node set value 5
function railway:api/graph/add_node with storage railway:branch_fixture
data modify storage railway:branch_fixture from set value 1
data modify storage railway:branch_fixture to set value 2
data modify storage railway:branch_fixture cost set value 20000
function railway:api/graph/add_edge with storage railway:branch_fixture
data modify storage railway:branch_fixture from set value 2
data modify storage railway:branch_fixture to set value 3
data modify storage railway:branch_fixture cost set value 31000
function railway:api/graph/add_edge with storage railway:branch_fixture
data modify storage railway:branch_fixture from set value 3
data modify storage railway:branch_fixture to set value 1
data modify storage railway:branch_fixture cost set value 148657
function railway:api/graph/add_edge with storage railway:branch_fixture
data modify storage railway:branch_fixture from set value 2
data modify storage railway:branch_fixture to set value 4
data modify storage railway:branch_fixture cost set value 13707
function railway:api/graph/add_edge with storage railway:branch_fixture
data modify storage railway:branch_fixture from set value 4
data modify storage railway:branch_fixture to set value 5
data modify storage railway:branch_fixture cost set value 29707
function railway:api/graph/add_edge with storage railway:branch_fixture
data modify storage railway:branch_fixture from set value 5
data modify storage railway:branch_fixture to set value 3
data modify storage railway:branch_fixture cost set value 14414
function railway:api/graph/add_edge with storage railway:branch_fixture
return run function railway:api/graph/seal with storage railway:branch_fixture
