$data modify storage railway:graph paths.p$(path).state set value "failed"
$data modify storage railway:graph paths.p$(path).error set value "Invalid waypoint list or unreachable destination/waypoint. No partial path published."
$data remove storage railway:graph jobs.j$(path)
data remove storage railway:graph active_job
return 0
