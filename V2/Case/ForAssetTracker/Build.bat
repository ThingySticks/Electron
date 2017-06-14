@echo off

@echo Deleting old STL files.
del *.stl

@echo Building Asset Tracker STLs

@echo Building Asset Tracker With Right Battery STLs
"C:\Program Files\OpenSCAD\openscad.com" -o BaseWithAssetTracker-V2-Right.stl -D "assetTrackerVersion=2;batteryCompartmentRight=true;batteryCompartmentLeft=false;includeAerialSlot=true;includeAerialPanel=false" LargePrototypeBaseWithAssetTracker.scad
"C:\Program Files\OpenSCAD\openscad.com" -o BaseWithAssetTracker-V1-Right.stl -D "assetTrackerVersion=1;batteryCompartmentRight=true;batteryCompartmentLeft=false;includeAerialSlot=true;includeAerialPanel=false" LargePrototypeBaseWithAssetTracker.scad

@echo Building Asset Tracker With Left Battery STLs
"C:\Program Files\OpenSCAD\openscad.com" -o BaseWithAssetTracker-V2-Left.stl -D "assetTrackerVersion=2;batteryCompartmentRight=false;batteryCompartmentLeft=true;includeAerialSlot=true;includeAerialPanel=false" LargePrototypeBaseWithAssetTracker.scad
"C:\Program Files\OpenSCAD\openscad.com" -o BaseWithAssetTracker-V1-Left.stl -D "assetTrackerVersion=1;batteryCompartmentRight=false;batteryCompartmentLeft=true;includeAerialSlot=true;includeAerialPanel=false" LargePrototypeBaseWithAssetTracker.scad