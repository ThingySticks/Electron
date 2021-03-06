$fn=80;

// Width (Note pcb does not centre align).
width = 100;

// Without aerial
//length = 117;
// Stickon Aerial
//length = 130;
// Slotted aerial

// Overall length /mm (without aerial 117mm, With aerial 125mm)
length = 125;

// should be enough to hold the battery
// Height of the battery compartment
batteryCompartmentHeight =20;

// Battery compartment on the right
batteryCompartmentRight = true;

// Battery compartment on the left
batteryCompartmentLeft = false;

// Include a aerial panel (for the aerial to stick to).
includeAerialPanel = false;

// Include a slot for the aerial to drop into.
includeAerialSlot = true;

// Thickness of the base material.
baseHeight = 1.5;

// How height off the base the PCB wil lbe.
height = 8;

// Diameter of the screw hole for the PCB mounts. 4.4mm works well for M3 heatfits.
pcbMountScrewHoleDiameter = 4.4;

// Diameter of the pins used to locate the PCB instead of screw holes.
pcbMountPinDiameter = 2.8;

module roundedCube(width, height, depth, cornerDiameter) {
//cornerDiameter = 5;
cornerRadius = cornerDiameter/2;

    translate([cornerDiameter/2,0,0]) {
        cube([width-cornerDiameter, height, depth]);
    }
    
    translate([0,cornerDiameter/2,0]) {
        cube([width, height-cornerDiameter, depth]);
    }
    
    translate([cornerRadius,cornerRadius,0]) {
        cylinder(d=cornerDiameter, h=depth);
    }
    
    translate([width-cornerRadius,cornerRadius,0]) {
        cylinder(d=cornerDiameter, h=depth);
    }
    
    translate([cornerRadius,height-cornerRadius,0]) {
        cylinder(d=cornerDiameter, h=depth);
    }
    
    translate([width-cornerRadius,height-cornerRadius,0]) {
        cylinder(d=cornerDiameter, h=depth);
    }
}

module screw(x,y, height) {
    translate([x,y, 0]) {
        cylinder(d=6.5, h=2);
    }
    
    translate([x,y, -4]) {
        cylinder(d=3, h=6);
    }
}

module pcb() {
    roundedCube(100,100, 1.6, 8);
    screw(5,5, height, baseHeight);
    screw(5,95, height, baseHeight);
    screw(95,5, height, baseHeight);
    screw(95,95, height, baseHeight);
}

module electron() {
    cube([20,51,13]);
    
    // Battery
    translate([2.5, 45, 13]) {
        cube([8,5.5,6.2]);
    }
    
    // USB
    translate([2.5 + 8, 46, 13]) {
        cube([8,5.5,3]);
    }
    
    // USB Plug
    translate([2.5 + 8 - (3/2), 46 + 5.5, 10]) {
        cube([11,22,7]);
    }
    
    // Aerial connector
    translate([5.5, 0, 13]) {
        cube([8,4,2.5]);
    }
}

module battery() {
    cube([35,10,51]);
}

module pcbMount(x,y, height, baseHeight) {
    translate([x,y, baseHeight-0.1]) {
        difference() {
            cylinder(d=10, h=height);
            cylinder(d=pcbMountScrewHoleDiameter, h=height);
        }
    }
}

module pcbMountPin(x,y, height, baseHeight) {
    translate([x,y, baseHeight-0.1]) {
        union() {
            cylinder(d=10, h=height);
            cylinder(d=pcbMountPinDiameter, h=height + 3);
        }
    }
}

module batteryCompartment() {
wallWidth = 1.5;
 
    difference() {
        union() {
            roundedCube(34 + (wallWidth*2)+1,10 + (wallWidth*2)+1, batteryCompartmentHeight, 10);
            //cube([35 + (wallWidth*2),10 + (wallWidth*2),height]);
        }
        union() {
            translate([wallWidth, wallWidth+0.5, 0]) {
                #roundedCube(35,10, batteryCompartmentHeight+1, 4);
                //#cube([35,10,height+1]);
            }
        }
    }
}

module aerialPad() {
    
    // Extend the base out
    //roundedCube(100,20, 1.6, 8);
    
    // add a riser for the aerial
aerialWidth = 82;
xoffset = (width - aerialWidth)/2;
    
    translate([xoffset, length-2, baseHeight-0.1]) {
        cube([aerialWidth,2, 22.5]);
    }
}

module slottedAerialPad() {
    
    // Extend the base out
    //roundedCube(100,20, 1.6, 8);
    
    // add a riser for the aerial
aerialWidth = 82;
aerialHolderWidth = 82 + 4;// 2mm either side solid to help the aerial slot in.
xoffset = (width - aerialHolderWidth)/2;
    
    // Thick aerial pad with cutout to allow aerial to slot in
    
    translate([xoffset, length-5, baseHeight-0.1]) {
        difference() {
            union() {
                cube([aerialHolderWidth,5, 22.5]);
            }
            union() {
                translate([12,-0.1,0]) {
                    #cube([aerialWidth-20,3, 23]);
                }
                translate([2,2,0]) {
                    #cube([aerialWidth,1.25, 23]);
                }
            }
        }
    }
    
    translate([xoffset, length-5, 0]) {
        translate([0, 0, 0]) {
            cube([10,2, 22.5]);
        }
        
        translate([aerialWidth-10, 0, 0]) {
            cube([10,2, 22.5]);
        }
    }
}

module aerialText() {
    // Aerial text
    translate([90, length, 12]) {
        rotate([90,0,180]) {
            linear_extrude(1) {
                text("ThingySticks.com", size=7.5);
            }
        }
    }
}

module aerialPad2() {
    cube([2,80, 20]);
}

module base() {       

    roundedCube(width,length, baseHeight, 10);
    // Use pins on the end two to make it easier to 
    pcbMountPin(5,5, height, baseHeight);
    pcbMountPin(95,5, height, baseHeight);
    
    pcbMount(5,95, height, baseHeight);
    pcbMount(95,95, height, baseHeight);

    if (batteryCompartmentLeft) {
        // Left hand battery compartment
        translate([0,103,baseHeight]) {
            batteryCompartment();
        }
    }
    
    if (batteryCompartmentRight) {
        // Right hand battery compartment
        // Battery compartment is 40mm wide.
        translate([width - 38,103,baseHeight]) {
            batteryCompartment();
        }
    }
    
    if (includeAerialPanel) {
        aerialPad();
        aerialText();
    }
    
    if (includeAerialSlot) {
        slottedAerialPad();
        aerialText();
    }
    
    // Base text
    translate([18, 2, baseHeight]) {
        linear_extrude(1) {
            text("ThingySticks.com", size=6, font = "Liberation Sans");
            //text("Th", size=80, font = "Liberation Sans");
        }
    }
}

base();

/*
translate([0,0,baseHeight + height]) {
    %pcb();
}

translate([40, 100-51, baseHeight + height + 1.6]) {
    %electron();
}

translate([2,104,baseHeight]) {
    %battery();
}

*/