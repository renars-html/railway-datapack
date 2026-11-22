# Exactly one sample fetch; integer origins/slopes were compiled at development time.
$data modify storage railway:motion target set from storage railway:dev_path frames[$(frame)]
execute unless score #fraction rw.sys matches 0 run function railway:internal/movement/interpolate_axes with storage railway:motion target
function railway:dev/internal/apply with storage railway:motion target
