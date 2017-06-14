$fn=80;

width = 100;
length = 157;

// should be enough to hold the battery
batteryCompartmentHeight =20;
batteryCompartmentRight = true;
batteryCompartmentLeft = false;

includeAerialPanel = false;
includeAerialSlot = true;

// more base thickness.
baseHeight = 1.5;
// height above the top of the base.
height = 15;

assetTrackerVersion = 2;

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

module showModels() {

    translate([0,0,baseHeight + height]) {
        %pcb();
        
        if (assetTrackerVersion == 2) {
            // from base of PCB to base of asset tracker
            translate([32,43.5,-11.5]) {
                %assetTracker();
            }
        }
        
        if (assetTrackerVersion == 1) {
            // from base of PCB to base of asset tracker
            translate([31,48,-11.5]) {
                %assetTrackerV1();
            }
        }
    }

    translate([40, 100-51, baseHeight + height + 1.6]) {
        %electron();
    }

    translate([12,111,baseHeight]) {
        rotate([0,0,90]) {
            %battery();
        }
    }

    translate([width-2,111,baseHeight]) {
        rotate([0,0,90]) {
            %battery();
        }
    }
}

module screw(x,y, height) {
    translate([x,y, 0]) {
        #cylinder(d=6.5, h=2);
    }
    
    translate([x,y, -4]) {
        #cylinder(d=3, h=6);
    }
}

// Model of the prototype PCB
module pcb() {
    roundedCube(100,100, 1.6, 8);
    screw(5,5, height, baseHeight);
    screw(5,95, height, baseHeight);
    screw(95,5, height, baseHeight);
    screw(95,95, height, baseHeight);
}

// Model of the Particle asset tracker PCB
module assetTracker() {
    cube([36, 103, 1.6]);
    screw(4,4, height, baseHeight);
    screw(36-4,4, height, baseHeight);
    screw(4,103-4, height, baseHeight);
    screw(36-4,103-4, height, baseHeight);
}

module assetTrackerV1() {
    cube([38, 95, 1.6]);
    screw(38/2,7.5, height, baseHeight);
    screw(38/2,87.6, height, baseHeight);
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
            cylinder(d=4.4, h=height);
        }
    }
}

module pcbMountPin(x,y, height, baseHeight) {
    translate([x,y, baseHeight-0.1]) {
        union() {
            cylinder(d=10, h=height);
            cylinder(d=2.8, h=height + 3);
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
xoffset = (width - aerialWidth)/2 - width;
    
    translate([xoffset, 8, 0]) {
        cube([aerialWidth,2, 22.5]);
    }
}

module slottedAerialPad() {
    
    // Extend the base out
    //roundedCube(100,20, 1.6, 8);
    
    // add a riser for the aerial
aerialWidth = 82;
aerialHolderWidth = 82 + 4;// 2mm either side solid to help the aerial slot in.
xoffset = (width - aerialHolderWidth)/2 -width;
    
    // Thick aerial pad with cutout to allow aerial to slot in
    
    translate([xoffset, 5, 0]) {
        difference() {
            union() {
                cube([aerialHolderWidth,5, 22.5]);
            }
            union() {
                translate([12,-0.1,0]) {
                    cube([aerialWidth-20,3, 23]);
                }
                translate([2,2,0]) {
                    cube([aerialWidth,1.25, 23]);
                }
            }
        }
    }
}

module aerialText() {
    // Aerial text
    translate([90 - width, 10, 12]) {
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

module assetTrackerPcbPins() {
// bottom of the asset tracker is 11.5mm below the bottom of the 
// prototype PCB.
assetTrackerPcbMountHeight = height - 11.5;
    
    if (assetTrackerVersion == 2) {
        translate([32,43.5,0]) {
            pcbMountPin(4,4, assetTrackerPcbMountHeight, baseHeight);
            pcbMountPin(36-4,4, assetTrackerPcbMountHeight, baseHeight);
            pcbMountPin(4,103-4, assetTrackerPcbMountHeight, baseHeight);
            pcbMountPin(36-4,103-4, assetTrackerPcbMountHeight, baseHeight);
        }
    }
    
    if (assetTrackerVersion == 1) {
        translate([31,48,0]) {
            pcbMountPin(38/2,7.5, assetTrackerPcbMountHeight, baseHeight);
            pcbMountPin(38/2,87.6, assetTrackerPcbMountHeight, baseHeight);
        }
    }
}

module base() {       

    // Main base
    // Extend back for the aerial pad.
    translate([0,-10,0]) {
        // +35 for the asset tracker overhang
        // we can probably narrow it at that poing.
        roundedCube(width, length, baseHeight, 10);
    }
    
    // PCB mounts for prototype PCB
    // Use pins on the end two to make it easier to 
    pcbMountPin(5,5, height, baseHeight);
    pcbMountPin(95,95, height, baseHeight);
    
    pcbMount(5,95, height, baseHeight);
    pcbMount(95,5, height, baseHeight);
    
    assetTrackerPcbPins();

    if (batteryCompartmentLeft) {
        // Left hand battery compartment
        translate([14,109,baseHeight]) {
            rotate([0,0,90]) {
                batteryCompartment();   
            }
        }
    }
    
    if (batteryCompartmentRight) {
        // Right hand battery compartment
        // Battery compartment is 40mm wide.
        translate([width,109,baseHeight]) {
            rotate([0,0,90]) {
                batteryCompartment();
            }
        }
    }
    
    if (includeAerialPanel) {
        rotate([0, 0, 180]) {
            aerialPad();
            aerialText();
        }
    }
    
    if (includeAerialSlot) {
        
        rotate([0, 0, 180]) {
            
                slottedAerialPad();
                aerialText();
            }
        
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