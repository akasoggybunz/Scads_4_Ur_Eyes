# Starlink Mini Packout 48-22-8430 Insert

Printable OpenSCAD insert for carrying a Starlink Mini and accessories in a Milwaukee Packout 48-22-8430 organizer.

## Generator Script

The SCAD script used for these files is:

`source/starlink_mini_8430_insert_v2.scad`

The earlier `starlink_mini_packout_insert.scad` was an older tiled version. A later `v3/V3_8430_StarlinkminiInsert.scad` file in the working folder is empty, so it was not the generator.

## Printable Files

The current publish set is in `stl/`:

- `starlink_packout_8430_left_front.stl`
- `starlink_packout_8430_left_back.stl`
- `starlink_packout_8430_center_front.stl`
- `starlink_packout_8430_center_back.stl`
- `starlink_packout_8430_right_front.stl`
- `starlink_packout_8430_right_back.stl`

## Source Dependencies

The SCAD uses local reference STLs for the Packout fit body:

- `source/48228430/Left.stl`
- `source/repaired/Center_repaired.stl`
- `source/48228430/Right.stl`

The older four-quadrant 8430 template files are also included under `source/mini/files/` for overlay/reference modes.

The Starlink Mini reference mesh is not included in this public cleanup folder. The copied SCAD has `show_starlink_preview = false` so exports do not require that private/reference mesh.

## Regenerate STLs

Use OpenSCAD from PowerShell:

```powershell
.\export_stls.ps1
```

Or run individual exports from the repository root:

```powershell
& 'C:\Program Files (x86)\OpenSCAD\openscad.exe' -o .\stl\starlink_packout_8430_left_front.stl   -D render_section_id=1 .\source\starlink_mini_8430_insert_v2.scad
& 'C:\Program Files (x86)\OpenSCAD\openscad.exe' -o .\stl\starlink_packout_8430_left_back.stl    -D render_section_id=2 .\source\starlink_mini_8430_insert_v2.scad
& 'C:\Program Files (x86)\OpenSCAD\openscad.exe' -o .\stl\starlink_packout_8430_center_front.stl -D render_section_id=3 .\source\starlink_mini_8430_insert_v2.scad
& 'C:\Program Files (x86)\OpenSCAD\openscad.exe' -o .\stl\starlink_packout_8430_center_back.stl  -D render_section_id=4 .\source\starlink_mini_8430_insert_v2.scad
& 'C:\Program Files (x86)\OpenSCAD\openscad.exe' -o .\stl\starlink_packout_8430_right_front.stl  -D render_section_id=5 .\source\starlink_mini_8430_insert_v2.scad
& 'C:\Program Files (x86)\OpenSCAD\openscad.exe' -o .\stl\starlink_packout_8430_right_back.stl   -D render_section_id=6 .\source\starlink_mini_8430_insert_v2.scad
```

## Print Notes

- Material: PETG or ASA recommended for heat and travel use.
- Print flat as exported.
- Use 4+ walls and 20-30% gyroid or similar infill.
- Dry fit before committing to long prints.

## Products Used

Some links below may be Amazon affiliate links.

- Filament: [Polymaker PolyLite PLA Pro](https://amzn.to/4cZmBHp)
- Printer: [3D printer used for this project](https://amzn.to/3OEwXog)
- Organizer: [Milwaukee Packout 48-22-8430](https://amzn.to/42duHYc)

  ## Build Video

Watch the project video on YouTube:

[Starlink Mini Packout Insert Build](https://youtu.be/A22Ygl0FSNs)
