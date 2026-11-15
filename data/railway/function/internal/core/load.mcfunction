# Persistent registry; reload never resets IDs, membership or ownership.
execute unless data storage railway:state schema run function railway:internal/core/init
