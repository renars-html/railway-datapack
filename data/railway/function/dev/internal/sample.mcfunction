# Executor is the cart; command position remains the marker origin.
$data modify storage railway:dev target set from storage railway:dev_path frames[$(frame)]
function railway:dev/internal/apply with storage railway:dev target
