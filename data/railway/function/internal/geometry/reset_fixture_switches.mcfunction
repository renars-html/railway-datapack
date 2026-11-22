scoreboard players set #switch_profile rw.sys -1
execute if data storage railway:branch_fixture profile store result score #switch_profile rw.sys run data get storage railway:branch_fixture profile
execute unless score #switch_profile rw.sys = #base_profile rw.sys run return 0
scoreboard players set #switch_mode rw.sys 0
function railway:internal/geometry/set_switches
