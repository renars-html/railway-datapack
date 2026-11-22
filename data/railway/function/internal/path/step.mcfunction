$execute if data storage railway:graph jobs.j$(path){stage:"targets"} run return run function railway:internal/path/target_step with storage railway:graph active_job
$execute if data storage railway:graph jobs.j$(path){stage:"init"} run return run function railway:internal/path/init_step with storage railway:graph active_job
$execute if data storage railway:graph jobs.j$(path){stage:"select"} run return run function railway:internal/path/select_step with storage railway:graph active_job
$execute if data storage railway:graph jobs.j$(path){stage:"relax"} run return run function railway:internal/path/relax_step with storage railway:graph active_job
$execute if data storage railway:graph jobs.j$(path){stage:"backtrack"} run return run function railway:internal/path/backtrack_step with storage railway:graph active_job
