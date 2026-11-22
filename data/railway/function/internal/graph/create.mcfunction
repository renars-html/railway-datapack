$data modify storage railway:graph graphs.g$(graph) set value {id:$(graph),revision:1,state:"draft",node_ids:[],nodes:{},edges:{},next_edge:0}
data modify storage railway:api result set value {ok:1b}
execute store result storage railway:api result.graph int 1 run scoreboard players get #g_id rw.sys
