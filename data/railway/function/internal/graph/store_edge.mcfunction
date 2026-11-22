$data modify storage railway:graph graphs.g$(graph).edges.e$(edge) set value {id:$(edge),from:$(from),to:$(to),cost:$(cost)}
$data modify storage railway:graph graphs.g$(graph).nodes.n$(from).outgoing append value $(edge)
$execute store result storage railway:graph graphs.g$(graph).next_edge int 1 run scoreboard players get #g_edge rw.sys
data modify storage railway:api result set value {ok:1b}
return 1
