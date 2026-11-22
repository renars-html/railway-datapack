$data modify storage railway:path_work ctx.node set from storage railway:graph jobs.j$(path).current_from
function railway:internal/path/set_source with storage railway:path_work ctx
$data modify storage railway:graph jobs.j$(path).cursor set value 0
$data modify storage railway:graph jobs.j$(path).best set value 0
$data modify storage railway:graph jobs.j$(path).best_distance set value 1000000000
$data modify storage railway:graph jobs.j$(path).stage set value "select"
