$execute unless data storage railway:graph paths.p$(path).edges[$(edge_index)] run return 0
$data modify storage railway:geometry_work source.edge set from storage railway:graph paths.p$(path).edges[$(edge_index)]
function railway:internal/geometry/source_edge_count with storage railway:geometry_work source
scoreboard players set #geo_source_ok rw.sys 1
