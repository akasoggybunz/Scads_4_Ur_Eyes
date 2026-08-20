# Repository Agent Guide

This repository contains public OpenSCAD source, printable STL exports, images, and project notes for practical 3D-printing designs.

## Project Map

- `HexTrack/`: Modular N-scale Hex-Trak layout tiles, gluing jigs, clips, LegoHexTrak variants, TopoHexTrak variants, STL exports, Customizer presets, and reference material.
- `PackoutMini8430Insert/`: Starlink Mini insert for the Milwaukee Packout 48-22-8430 organizer, split STL exports, OpenSCAD source, fit-reference meshes, images, and export script.

## Working Rules

- Read the root `README.md` and the nearest project `README.md` before changing a project.
- Keep project edits scoped to the relevant project folder unless the task explicitly spans projects.
- Treat `.scad` files and JSON Customizer presets as source; treat `stl/`, `3mf`, and image files as generated or published assets.
- Do not regenerate or replace binary exports unless source geometry changed or the task explicitly asks for updated exports.
- Preserve existing file and parameter names where possible so OpenSCAD presets, README instructions, and published links remain valid.
- Use millimeters for CAD dimensions.
- Prefer narrow validation: parse JSON presets, run an OpenSCAD export/render for the changed source when OpenSCAD is available, and document any validation limits.
- For fit-sensitive changes, call out the physical print risk and recommend dry fitting before production prints.

## Documentation Expectations

- Update the relevant project README when source files, export names, print instructions, dimensions, dependencies, or public assets change.
- Keep affiliate-link notes intact where they already exist.
- Add attribution notes for imported or derived third-party assets.
- Keep TODO items in `todo.md` short, actionable, and grouped by project.

