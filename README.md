[English](README.md) | [Deutsch](README_DE.md)

# ClassQoL Talent Warning

**Version 0.1.1 · World of Warcraft WotLK 3.3.5a · MIT**

A lightweight client addon for servers running `mod-class-qol` 0.2.3 with all
37 selected talent grants enabled. It adds a red border to these talent nodes
in your own Blizzard talent window and appends a short tooltip note.

Repository: [theprinceofbucket/ClassQoLTalentWarning](https://github.com/theprinceofbucket/ClassQoLTalentWarning).

## Features

- Covers all 37 selected talent nodes across the ten playable classes.
- Marks only your class's talents; pet and inspect talent windows are excluded.
- German client (`deDE`): **ClassQoL: Wird serverseitig auf maximalem Rang gewährt.**
- Every other client language: **ClassQoL: Granted by the server at maximum rank.**
- Keeps normal talent ranks, prerequisites, point allocation and clicks intact.
- One runtime Lua file, no libraries, settings files, server messages or polling.
  It refreshes after Blizzard updates the talent window and when a talent tooltip is set.

## Requirements

- The original WoW WotLK **3.3.5a** client (addon interface `30300`).
- The original Blizzard talent window.
- A server using the matching `mod-class-qol` talent selection with all grants enabled.

This version is not designed for Retail or modern WoW Classic clients.

## Installation and updates

1. Download **ClassQoLTalentWarning.zip** from the project's release assets.
   While publication is pending, use the locally supplied ZIP with that name.
2. Close WoW and extract the archive into `World of Warcraft/Interface/AddOns`.
3. Check that this file exists without an extra nested folder:
   `Interface/AddOns/ClassQoLTalentWarning/ClassQoLTalentWarning.toc`.
4. Enable **ClassQoL Talent Warning** in the character-selection addon list and log in.

For updates, replace the existing `ClassQoLTalentWarning` folder with the new one.
The addon stores no settings. No server SQL, client DBC changes or compilation are required.

## Use

Open your talent window with its normal key binding (default: **N**), select a
talent tree and hover over a marked talent. The red border remains independent
of how many points you have invested. There are no commands or options to configure.

The note describes the server module's grant. It is not an instruction to spend
points and does not remove the need to satisfy normal talent-tree prerequisites.

## Limitations and test status

The addon does not read server configuration or verify active auras. It assumes
all selected talent grants are enabled. Required base abilities and conditional
effects still follow the server module's rules; a border does not prove that
every effect is currently active. Paladin and other class-specific exceptions
are resolved by the server, not by this display addon.

Custom client talent layouts, replacement talent windows and different module
selections may need adjustments. This addon adds no warnings to glyphs, spells
or separate QoL features such as Free Shouts.

The project owner reported satisfaction with the initial in-game implementation.
Local checks cover the 37 DBC talent coordinates and class assignments, Lua syntax,
package structure and version consistency. The owner successfully tested German
and English in 0.1.1 by changing the language in the game settings and restarting
the game for each language. Comprehensive all-class, dual-spec and addon
compatibility tests are also open. See [testing](docs/TESTING.md).

## Source and release packaging

The TOC and Lua file can be used directly. To validate and create the release ZIP,
run from this repository folder with **Python 3.9 or newer**:

```sh
python tools/build_release.py
```

On Windows you can also use `py -3 tools/build_release.py`. Python is needed only
for development packaging, not to play. Outputs are `dist/ClassQoLTalentWarning.zip`
and `dist/SHA256SUMS.txt`. The script uses a fixed file list and verifies the
archive contents. It does not upload anything. Read the
[v0.1.1 release notes](docs/releases/v0.1.1.md) and
[updater integration notes](docs/UPDATER.md).

## Credits and license

Created by **theprinceofbucket with assistance from OpenAI ChatGPT/Codex** in
planning, programming, debugging, checks and documentation. The project owner
provided decisions, practical tests and feedback. This is an independent community
project, not an official OpenAI or Blizzard product.

This addon's source code is available under the [MIT License](LICENSE). That
license applies to this addon, not to AzerothCore, the server module, the WoW
client or other addons. No Blizzard UI source, DBC data or external libraries
are distributed in this repository. See [CHANGELOG.md](CHANGELOG.md).
