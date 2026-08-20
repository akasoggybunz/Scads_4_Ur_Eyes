# TODO

## Repository

- [ ] Decide whether generated STL exports should be refreshed only on release or with every source geometry change.
- [ ] Add a short release checklist for publishing new CAD exports, screenshots, and README updates.
- [ ] Consider adding project-level attribution files if more third-party reference meshes are added.

## HexTrack

- [ ] Verify the current STL publish set against `HexTrack/source/` and mark stale exports if any source has moved ahead.
- [ ] Add regeneration commands for the main HexTrack STL exports, similar to the Packout export script.
- [ ] Confirm Customizer preset JSON files still match the current OpenSCAD parameter names.
- [ ] Add print photos or slicer screenshots for the half-tile joiner fit once a validated print set exists.
- [ ] Test print or slicer-check `HexTrack/source/DCCEXElectronicsMountain.scad` with the actual DCC-EX board, power supply, and wire bend radius.

## PackoutMini8430Insert

- [ ] Confirm the six exported sections match `source/starlink_mini_8430_insert_v2.scad` and the README command list.
- [ ] Add measured fit notes after the next dry fit in a real Milwaukee Packout 48-22-8430 organizer.
- [ ] Replace or supplement the screenshot image with final render/export images if cleaner public images are available.
- [ ] Note any slicer-specific support or brim recommendations after a validated print run.
