# Final Drive

Unofficial preservation project for Gorillaz' Final Drive (aka Geep Simulator, 2001). Setup tools, documentation, and a GitHub Pages companion for the surviving Windows build.

This repo does **not** include the original game data or runtime binaries.

## What This Repo Is For

- Documenting the game and its historical context.
- Publishing a clean GitHub Pages landing page for the project.
- Sharing public-safe setup tools for people who already own a copy of the game data.
- Explaining the modern Windows compatibility fixes needed to run the original Director/Shockwave build.

## What This Repo Does Not Include

- The original `gorillaz_final_drive.exe` game binary.
- Macromedia/Adobe runtime DLLs or Xtras.
- Patched redistribution copies of proprietary game files.

If you own a copy from a legitimate source such as the original web release archive, the Phase One: Celebrity Take Down DVD-ROM, or another official disc release, this repo gives you the public notes and helper scripts around that copy.

## Quick Start

1. Start with your own copy of the original game files.
2. Place `Play Gorillaz.bat` beside `gorillaz_final_drive.exe`.
3. Run `tools/patch_iml32.ps1` against your local `IML32.dll`.
4. Use the GitHub Pages site for the full setup walkthrough, controls, and history notes.

## Included Public Files

- `Play Gorillaz.bat`: portable launcher for modern Windows.
- `tools/patch_iml32.ps1`: patches the Director 2 GB memory bug in a user-supplied `IML32.dll`.
- `tools/INSTALL.txt`: short offline setup notes.
- `docs/`: the GitHub Pages site.

## Historical Overview

Final Drive, better known by many fans as Geep Simulator, was a Phase 1 Gorillaz browser-era driving experiment built around Macromedia Director and Shockwave. It was developed by Zombie Flesh Eaters, designed by Matt Watkins, and released in 2001 as part of the wider promotion around 19-2000.

The game places the band in the Geep and lets the player drive through a limited open environment inspired by the 19-2000 video. On the original release screen, players could choose color depth, resolution, sound, and then launch the game. The package also circulated through official media such as the Gorillaz website and Phase One: Celebrity Take Down DVD-ROM.

## Controls

- Arrow keys: drive and steer.
- `R`: reset if the Geep gets stranded.
- `Space`: handbrake / jump-style stunt input depending on the situation.

## Known Issues

- This is still an old Shockwave 3D title, so minor physics oddities remain authentic to the original.
- Browser-native playback is not part of this repo. The current goal is preservation and Windows playback support.
- The public repo intentionally excludes original game binaries and proprietary runtime components.

## Repo Layout

- `docs/`: site files for GitHub Pages.
- `tools/`: helper scripts and offline instructions.
- `Play Gorillaz.bat`: launcher script.

## Publishing Notes

This repo is designed to publish from `docs/` on GitHub Pages.

Expected Pages URL:

- `https://ku-tadao.github.io/gorillaz-final-drive/`

## Legal Note

This is an unofficial preservation-oriented project. Gorillaz, Final Drive, Geep Simulator, and related art, audio, and software assets belong to their respective rights holders. This repository only publishes original site code, notes, and helper scripts.
