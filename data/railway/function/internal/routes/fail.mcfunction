$data modify storage railway:routes routes.r$(route) set value {state:"failed",error:"Invalid station list or a station not saved on this route profile."}
$data remove storage railway:routes jobs.j$(route)
data remove storage railway:routes active_job
return 0
