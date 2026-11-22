$data modify storage railway:graph paths.p$(path) set value {state:"compiling",graph:$(graph),from:$(from),to:$(to)}
$data modify storage railway:graph jobs.j$(path) set value {path:$(path),graph:$(graph),from:$(from),to:$(to),stage:"targets",cursor:0,target_index:0,current_from:$(from),total_cost:0,nodes:[],edges:[],targets:[]}
$data modify storage railway:graph jobs.j$(path).via set from storage railway:graph_work via
$data modify storage railway:graph active_job set value {path:$(path),graph:$(graph)}
data modify storage railway:api result set value {ok:1b}
execute store result storage railway:api result.path int 1 run scoreboard players get #pf_id rw.sys
tellraw @s [{"text":"[Railway] Path "},{"score":{"name":"#pf_id","objective":"rw.sys"}},{"text":" queued for waypoint-aware Dijkstra compilation."}]
return 1
