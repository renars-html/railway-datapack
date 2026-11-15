execute unless score #selected rw.sys matches 1..2147483646 run return 0
$execute unless data storage railway:scratch request{train:$(id)} run return 0
$execute unless data storage railway:state trains.t$(id) run return 0
return 1
