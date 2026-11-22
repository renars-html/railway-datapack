scoreboard players set #external rw.sys 0
$execute store success score #external rw.sys run forceload query $(x) $(z)
$data modify storage railway:scratch ticket set value {x:$(x),z:$(z),owned:0b}
execute if score #external rw.sys matches 0 run data modify storage railway:scratch ticket.owned set value 1b
# Record ownership before mutation so even a partial/failed lease can be released.
data modify storage railway:loading lease.chunks append from storage railway:scratch ticket
$execute if score #external rw.sys matches 0 store success score #added rw.sys run forceload add $(x) $(z)
execute if score #external rw.sys matches 0 unless score #added rw.sys matches 1 run scoreboard players set #load_failed rw.sys 1
