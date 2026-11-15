# Railway datapack

An empty datapack for **Minecraft Java Edition 26.3**, using datapack format
**121.0**. No commands run automatically and no gameplay behavior is included.

## Structure

```text
pack.mcmeta                    Pack metadata and supported format
data/railway/function/         Future .mcfunction files in the railway namespace
```

The `.gitkeep` file preserves the empty function directory in Git; Minecraft
ignores it. Use singular directory names such as `function`, `recipe`, and
`advancement` when adding content.

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

No dependencies, build step, or background services are required. Add functions
under `data/railway/function/`; a file named `example.mcfunction` can be invoked
with `/function railway:example` after `/reload`. No example function ships with
this empty pack.

Validate the metadata locally with:

```sh
python3 -m json.tool pack.mcmeta
```

Final loading and command validation requires Minecraft Java Edition 26.3.

Version reference: [Minecraft version metadata](https://github.com/misode/mcmeta/blob/summary/versions/data.json)
(entry `26.3`, datapack version `121.0`).
