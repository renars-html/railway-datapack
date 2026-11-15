# Report nominal path speed rounded to one decimal place; scratch values only.
scoreboard players operation #speed_tenths rw.dev = #speed rw.dev
scoreboard players operation #speed_tenths rw.dev *= #rate_unit rw.dev
scoreboard players add #speed_tenths rw.dev 50
scoreboard players operation #speed_tenths rw.dev /= #hundred rw.dev
scoreboard players operation #speed_whole rw.dev = #speed_tenths rw.dev
scoreboard players operation #speed_whole rw.dev /= #ten rw.dev
scoreboard players operation #speed_decimal rw.dev = #speed_tenths rw.dev
scoreboard players operation #speed_decimal rw.dev %= #ten rw.dev
tellraw @s [{"text":"[Railway test] Speed step "},{"score":{"name":"#speed","objective":"rw.dev"}},{"text":"/8: approximately "},{"score":{"name":"#speed_whole","objective":"rw.dev"}},{"text":"."},{"score":{"name":"#speed_decimal","objective":"rw.dev"}},{"text":" blocks/s at 20 TPS. Each step adds 0.125 blocks/tick (2.494 blocks/s)."}]
