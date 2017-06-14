@echo off

@echo Deleting old STL files.
del *.stl

@echo Building Right Battery STLs
"C:\Program Files\OpenSCAD\openscad.com" -o LargePrototypeBase-Right.stl -D "length=130;batteryCompartmentRight=true;batteryCompartmentLeft=false;includeAerialHolder=true;includeAerialPanel=false" LargePrototypeBase.scad
"C:\Program Files\OpenSCAD\openscad.com" -o LargePrototypeBase-Right-NoAerial.stl -D "length=117;batteryCompartmentRight=true;batteryCompartmentLeft=false;includeAerialSlot=false;includeAerialPanel=false" LargePrototypeBase.scad

@echo Building Left Battery STLs
"C:\Program Files\OpenSCAD\openscad.com" -o LargePrototypeBase-Left.stl -D "length=130;batteryCompartmentRight=false;batteryCompartmentLeft=true;includeAerialHolder=true;includeAerialPanel=false" LargePrototypeBase.scad
"C:\Program Files\OpenSCAD\openscad.com" -o LargePrototypeBase-Left-NoAerial.stl -D "length=117;batteryCompartmentRight=false;batteryCompartmentLeft=true;includeAerialSlot=false;includeAerialPanel=false" LargePrototypeBase.scad