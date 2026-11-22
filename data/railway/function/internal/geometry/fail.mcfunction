$data modify storage railway:geometry paths.p$(path).state set value "failed"
$data modify storage railway:geometry paths.p$(path).error set value "Unsupported mixed switch modes, invalid source geometry, or circuit exceeds 8192 samples. No partial geometry assignable."
data remove storage railway:geometry job
data remove storage railway:geometry active_job
$tellraw @a {"text":"[Railway] Geometry for path $(path) failed. Inspect geometry_status for details.","color":"red"}
return 0
