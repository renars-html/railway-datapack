$execute unless data storage railway:graph_work raw{graph:$(graph),node:$(node)} run return 0
$execute unless data storage railway:graph graphs.g$(graph){state:"draft"} run return 0
$execute if data storage railway:graph graphs.g$(graph).nodes.n$(node) run return 0
$data modify storage railway:graph graphs.g$(graph).nodes.n$(node) set value {id:$(node),outgoing:[]}
$data modify storage railway:graph graphs.g$(graph).node_ids append value $(node)
data modify storage railway:api result set value {ok:1b}
return 1
