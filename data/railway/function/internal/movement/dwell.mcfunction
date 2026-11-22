# Manual/recovery holds freeze remaining dwell; a blocked signal may outlast dwell but still blocks departure.
execute if score @s rw.run matches 1 if score @s rw.recover matches 0 if score @s rw.wait matches 1.. run scoreboard players remove @s rw.wait 1
execute if score @s rw.wait matches 0 run scoreboard players set @s rw.station 0
