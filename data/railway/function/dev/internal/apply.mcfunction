$teleport @s ~$(x) ~$(y) ~$(z) $(yaw) 0
# This repeated write is part of the candidate backend under test.
data merge entity @s {Motion:[0.0d,0.0d,0.0d]}
