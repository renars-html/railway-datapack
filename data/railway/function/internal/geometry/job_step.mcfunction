execute if data storage railway:geometry job{stage:"edges"} run return run function railway:internal/geometry/edge_step with storage railway:geometry active_job
execute if data storage railway:geometry job{stage:"frames"} run return run function railway:internal/geometry/frame_step with storage railway:geometry active_job
execute if data storage railway:geometry job{stage:"deltas"} run return run function railway:internal/geometry/delta_step with storage railway:geometry active_job
