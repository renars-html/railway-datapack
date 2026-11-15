# Railway datapack

Minecraft Java **26.3**, data pack format **121.0**. This is an operator-driven
backend prototype. See [ROADMAP.md](ROADMAP.md) and [TESTING.md](TESTING.md).

## Install

Replace the pack folder in your world's `datapacks` directory, with `pack.mcmeta`
directly inside it. `/reload`, then `/datapack list enabled` to check loading.
Replacing the folder removes obsolete functions when APIs change. A ZIP with
`pack.mcmeta` and `data/` at its root also works. No build step or dependencies.

## Current backend

Persistent train IDs, owner/controller/cart UUID records, ordered membership,
count-based compositions of 1–64 normal/chest carts, and a 20-cart movement test.
The existing ~40-block test loop fits 1–24 carts; it supports fractional movement,
configurable physical speed/acceleration/deceleration, service and emergency
stops, planned station braking/dwell, and independent signal holds. Singleplayer
reload and quit/reopen behavior has passed earlier cycles. New station behavior
awaits player tests; dedicated-server/disconnect recovery remains unverified.

Public operations are in `api/train/`; test fixtures are in `dev/`; implementation
functions are in `internal/`. Existing ordinary minecarts are untouched unless
explicitly registered. Owner UUIDs are stored, but these remain operator APIs;
survival interaction and access enforcement are future work. No force loading or
automatic cargo/cart respawning is used.

`configure_motion {train:ID,speed:7.5,accel:2.5,decel:2.5}` configures blocks/s and
blocks/s². Use `start`, `stop`, `emergency_stop`, `inspect`, `station_stop` and
`set_signal` with the arguments in TESTING.md. `start` resumes an emergency stop;
there is no separate release API. `fast` and `slow` are removed.

The original `dev/setup` replaces a 16×16×6 volume at the Creative caller's feet;
use a disposable world. `dev/long_train` binds a registered train to that loop and
parks the two original carts. Composition rebuilds preserve surviving cargo in a
separate parked grid. No function restores overwritten terrain.

Only actual runtime content uses `.mcfunction`, resource `.json`, or `pack.mcmeta`.
Documentation uses `.md`, which Minecraft ignores. Runtime folders use singular
names (`function`, `tags/function`). Automatic track discovery, physical stations/
signals, reservations, and the survival interface are not implemented yet.

Version reference: [official Java 26.3 release notes](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-3).
