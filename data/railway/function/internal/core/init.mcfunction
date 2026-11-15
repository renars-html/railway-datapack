scoreboard objectives add rw.sys dummy
scoreboard objectives add rw.train dummy
scoreboard objectives add rw.car dummy
data modify storage railway:state next_train set value 0
data modify storage railway:state trains set value {}
data modify storage railway:state schema set value 1
