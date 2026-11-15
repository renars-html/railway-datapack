# Railway datapack

A datapack in development for **Minecraft Java Edition 26.3**, using datapack
format **121.0**. The first implementation is an opt-in movement test fixture,
not yet a survival train system. See [TESTING.md](TESTING.md) for this test cycle.

## Structure

```text
pack.mcmeta                    Pack metadata and supported format
data/minecraft/tags/function/  Load/tick entry points
data/railway/function/         Runtime and operator-only movement fixture
ROADMAP.md                     Backend plan (ignored by Minecraft)
TESTING.md                     Current test cycle (ignored by Minecraft)
```

Use singular directory names such as `function`, `recipe`, and `advancement`.
Markdown documentation and `.gitkeep` files are ignored by Minecraft.

## Install

1. Copy this repository folder into your world's `datapacks` directory, for
   example `.minecraft/saves/<world>/datapacks/railway-datapack/`.
2. Ensure `pack.mcmeta` is directly inside that folder.
3. Open the world in Java Edition 26.3 and run `/reload` (requires cheats or
   operator permissions).
4. Run `/datapack list enabled` and check that the pack is listed.

A ZIP also works: place `pack.mcmeta` and `data/` at the ZIP root, without an
extra containing directory, then put the ZIP in the world's `datapacks` folder.

## Development

See [the backend roadmap](ROADMAP.md) for implementation milestones, the proposed
train and route architecture, performance constraints, and acceptance gates.
Milestone 0 has passed player tests at the initial speeds. The movement fixture
now defaults to about 7.5 blocks/s and caps at about 20 blocks/s. Persistent train
registration now drives a 20-cart movement prototype awaiting the tests in
TESTING.md. Automatic
route discovery, reservations and survival interactions are not implemented.

No dependencies, build step, or background services are required to run the pack.
The load function initializes registry objectives, the `rw.dev` scoreboard and a fixed test path in
storage. Without a fixture, each tick only checks whether the fixture is enabled.
Only explicitly tagged test entities are controlled. Existing minecarts are not
registered or modified. Reloading pauses a registered fixture while keeping its
position; `/function railway:dev/start` resumes it.

The fixture is a single global Overworld test rig. It requires a Creative player
to create it. Setup replaces a 16×16×6 volume at the player's feet, so use a
disposable test world. Cleanup removes its carts and test inventory, and leaves
the platform and rails in place. This is a test harness, not the final chunk
loading or multiplayer recovery implementation.

Validate the metadata locally with:

```sh
python3 -m json.tool pack.mcmeta
```

Final loading and command validation requires Minecraft Java Edition 26.3.

Version reference: [Minecraft version metadata](https://github.com/misode/mcmeta/blob/summary/versions/data.json)
(entry `26.3`, datapack version `121.0`).

The registered 20-cart movement test uses `railway:dev/long_train {train:ID}`
and per-train `railway:api/train/start`, `stop`, `fast`, and `slow` controls.
Follow TESTING.md before binding; it replaces the original fixture controls.

Registered trains now use fractional progress and configurable linear acceleration/
deceleration. `api/train/stop` requests service braking; `emergency_stop` latches an
immediate hold, and `release_emergency` releases the latch without starting.
Use `configure_motion {train:ID,accel:2.5,decel:5.0}` for rates in blocks/s².
