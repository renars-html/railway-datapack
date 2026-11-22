$data modify storage railway:graph paths.p$(path).nodes set from storage railway:graph jobs.j$(path).nodes
$data modify storage railway:graph paths.p$(path).edges set from storage railway:graph jobs.j$(path).edges
$data modify storage railway:graph paths.p$(path).cost set from storage railway:graph jobs.j$(path).total_cost
$data modify storage railway:graph paths.p$(path).via set from storage railway:graph jobs.j$(path).via
$data modify storage railway:graph paths.p$(path).state set value "ready"
$data remove storage railway:graph jobs.j$(path)
data remove storage railway:graph active_job
$tellraw @a {"text":"[Railway] Graph path $(path) compiled and ready.","color":"aqua"}
return 1
