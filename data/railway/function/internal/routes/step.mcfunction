$execute if data storage railway:routes jobs.j$(route){stage:"stops"} run return run function railway:internal/routes/read_stop with storage railway:routes active_job
$execute if data storage railway:routes jobs.j$(route){stage:"cache"} run return run function railway:internal/routes/cache_batch with storage railway:routes active_job
$execute if data storage railway:routes jobs.j$(route){stage:"publish"} run return run function railway:internal/routes/publish with storage railway:routes active_job
