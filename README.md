# Scads_4_Ur_Eyes

Public OpenSCAD files, printable STL exports, and project notes for practical 3D-printing designs.

This repo is mostly a place for cleaned-up CAD projects that are ready to share publicly. Each project folder should include its own source files, printable exports, images, and notes for printing or regeneration.

## Projects

### PackoutMini8430Insert

Starlink Mini insert for the Milwaukee Packout 48-22-8430 organizer.

Includes:

- OpenSCAD source
- Printable STL sections
- Reference fit files
- Product images
- PowerShell export script
- Project-specific README

Folder:

[`PackoutMini8430Insert`](./PackoutMini8430Insert)

## Requirements

Most projects use:

- [OpenSCAD](https://openscad.org/)
- A slicer such as Bambu Studio, OrcaSlicer, PrusaSlicer, or Cura
- A 3D printer with a bed size large enough for the exported sections

Some projects may include PowerShell scripts for regenerating STL files from SCAD source.

## Using The Files

1. Open the project folder you want.
2. Read that project’s `README.md`.
3. Use the provided STL files for printing, or regenerate them from the SCAD source.
4. Check dimensions against your real-world parts before running long prints.

These are hobby CAD files, so fitment can vary depending on printer calibration, material shrinkage, slicer settings, and product manufacturing tolerances.

## Recommended Print Settings

Unless a project says otherwise:

- Material: PETG, ASA, PLA Pro, or another material appropriate for the use case
- Walls: 4+
- Infill: 20-30%
- Pattern: gyroid or similar
- Dry fit parts before committing to final prints
- Use supports only where the project notes call for them

## Affiliate Links

Some project READMEs may include Amazon affiliate links for products, tools, printers, filament, or hardware used in the build. These links help support the work at no extra cost to you.

## Contributing

Issues and pull requests are welcome.

Good contributions include:

- Fitment feedback
- Cleaner export scripts
- Better documentation
- Photos of successful prints
- Bug fixes to SCAD source
- Alternate versions for different printers or hardware




## License

This repository is licensed under the GPL-3.0 license unless a specific project folder states otherwise.

See [`LICENSE`](./LICENSE).
