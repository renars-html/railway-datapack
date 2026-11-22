$data modify storage railway:path_work end set from storage railway:graph jobs.j$(path).to
$data modify storage railway:graph jobs.j$(path).targets append from storage railway:path_work end
$data modify storage railway:graph jobs.j$(path).stage set value "init"
$data modify storage railway:graph jobs.j$(path).cursor set value 0
