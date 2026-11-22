$execute store success score #still_forced rw.sys run forceload query $(x) $(z)
$execute if score #still_forced rw.sys matches 1 store success score #removed rw.sys run forceload remove $(x) $(z)
execute if score #still_forced rw.sys matches 1 unless score #removed rw.sys matches 1 run scoreboard players set #release_failed rw.sys 1
