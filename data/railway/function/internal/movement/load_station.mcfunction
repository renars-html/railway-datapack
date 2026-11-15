$execute unless data storage railway:scratch station_request{station:$(station),dwell:$(dwell)} run return 0
$execute unless data storage railway:stations stations.s$(station) run return 0
$execute store result score #station_profile rw.sys run data get storage railway:stations stations.s$(station).profile
execute unless score #station_profile rw.sys = #profile rw.sys run return 0
$execute store result score #sample rw.sys run data get storage railway:stations stations.s$(station).sample
return 1
