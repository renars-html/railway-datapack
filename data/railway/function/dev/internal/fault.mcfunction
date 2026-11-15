execute if score #fault rw.dev matches 0 run tellraw @a[distance=..64] {"text":"[Railway test] Missing or duplicate test cart: paused. Do not respawn cargo as a repair. Inspect the fixture.","color":"red"}
scoreboard players set #run rw.dev 0
scoreboard players set #fault rw.dev 1
