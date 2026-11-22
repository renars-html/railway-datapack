$data modify storage railway:routes routes.r$(route) set value {state:"failed",error:"Invalid station list or a station not saved on this route profile/geometry."}
$data remove storage railway:routes jobs.j$(route)
data remove storage railway:routes active_job
$tellraw @a {"text":"[Railway] Route $(route) failed: invalid station list or mismatched geometry/profile.","color":"red"}
return 0
