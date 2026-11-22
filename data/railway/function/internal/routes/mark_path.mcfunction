$data modify storage railway:routes jobs.j$(route).draft.geometry set value $(geometry)
$data modify storage railway:routes jobs.j$(route).draft.cache set value "p$(profile)_g$(geometry)_v$(cruise)_b$(brake)"
