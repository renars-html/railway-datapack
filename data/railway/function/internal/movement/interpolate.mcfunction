# Exactly one sample fetch; integer origins/slopes were compiled at development time.
execute if score #train_geometry rw.sys matches 0 run function railway:internal/geometry/sample_base with storage railway:motion sample
execute if score #train_geometry rw.sys matches 1.. run function railway:internal/geometry/sample_path with storage railway:motion sample
execute unless score #fraction rw.sys matches 0 run function railway:internal/movement/interpolate_axes with storage railway:motion target
function railway:dev/internal/apply with storage railway:motion target
