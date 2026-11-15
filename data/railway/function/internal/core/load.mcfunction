# Persistent registry; reload never resets IDs, membership or ownership.
execute unless data storage railway:state schema run function railway:internal/core/init
execute unless data storage railway:state movement_schema run function railway:internal/movement/init
scoreboard players add #epoch rw.sys 1
scoreboard players set #negative rw.sys -1
