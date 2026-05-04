$ErrorActionPreference = 'Stop'

$openscad = 'C:\Program Files (x86)\OpenSCAD\openscad.exe'
$source = Join-Path $PSScriptRoot 'source\starlink_mini_8430_insert_v2.scad'
$outDir = Join-Path $PSScriptRoot 'stl'

New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$sections = @(
    @{ id = 1; name = 'left_front' },
    @{ id = 2; name = 'left_back' },
    @{ id = 3; name = 'center_front' },
    @{ id = 4; name = 'center_back' },
    @{ id = 5; name = 'right_front' },
    @{ id = 6; name = 'right_back' }
)

foreach ($section in $sections) {
    $output = Join-Path $outDir ("starlink_packout_8430_{0}.stl" -f $section.name)
    & $openscad -o $output `
        -D ("render_section_id={0}" -f $section.id) `
        -D 'show_starlink_preview=false' `
        -D 'show_8430_template_overlay=false' `
        $source
}
