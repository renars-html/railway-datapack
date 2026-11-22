$data modify storage railway:scratch ticket set from storage railway:loading lease.chunks[$(index)]
execute if data storage railway:scratch ticket{owned:1b} run function railway:internal/loading/remove with storage railway:scratch ticket
