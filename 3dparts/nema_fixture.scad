include <peristaltic.scad>
include <nutsnbolts/cyl_head_bolt.scad>

// smoothness
$fn=100;

// Nema 17 size specifications
nema_width = 42.3;
nema_screwholes_distance = 31;
nema_shaft_diameter = 5;
nema_innercircle_diameter = 24;
nema_innercircle_height = 2;

//translate([0,0,-3.5]) nema_frontplate(1.25*nema_width, 105, 3);
//translate([0,57,5]) screw_cylinder(15, 20, "M5x20", "M5", overlap=1.5);
//nutsnscrew_plate(14,2,20,14,3, "M5", 4.5);
//middle_plate(nema_width, 15, 20, 3);

//rotate(a=10, v=[0,0,1]) translate([0,0,45/2]) center_part(10,45);

module center_part(width, height) {
	difference() {
		cylinder(r=width/sqrt(3),h=height,center=true,$fn=6);
		cylinder(d=nema_shaft_diameter, h=height, center=true);
	}
}
module pump_base() {
translate([0,0,5]) cylinder(h=10, d=104, center=true);
for (i = [0:90:270]) {
	rotate(a=i, v=[0,0,1]) {
		hull() {
		translate([57,0,0]) cylinder(h=10, d=14);
		translate([30,-20,0]) cube([10,40,10]);
		}
	}
}
}

difference() {
	pump_base();
	translate([0,0,5]) cylinder(h=10, d=102, center=true);
	for (i = [0:90:270]) {
		rotate(a=i, v=[0,0,1]) translate([57.5,0,0]) cylinder(h=100, d=5.2, cemter=true);
	}
}

//translate([0,0,-3.5]) nema_fixture(90, 3);

module nema_fixture(width, thickness) {
	middle_plate(nema_width+2, 14, (width-nema_width-2)/2, thickness);
	for (i = [0:90:270] ) {
		rotate(a=i, v=[0,0,1]) translate([width/2+6,0,5.5]) nutsnscrew_plate(14, 4, 13, 14, 3, "M5", 5.2);
	}
}


module nema_screwholes(width, height, thickness) {
	cylinder(h=thickness, d=nema_innercircle_diameter, center=true);
	translate([-nema_screwholes_distance/2, -nema_screwholes_distance/2, 0]) 
		cylinder(h=thickness, d=3, center=true);
	translate([-nema_screwholes_distance/2, nema_screwholes_distance/2, 0]) 
		cylinder(h=thickness, d=3, center=true);
	translate([nema_screwholes_distance/2, -nema_screwholes_distance/2, 0]) 
		cylinder(h=thickness, d=3, center=true);
	translate([nema_screwholes_distance/2, nema_screwholes_distance/2, 0]) 
		cylinder(h=thickness, d=3, center=true);
}

module middle_plate(mwidth, awidth, alength, thickness) {
	difference() {
		for (i = [0:90:270]) {
			rotate(a=i, v=[0,0,1]) _middle_plate(mwidth, awidth, alength, thickness);
		}
		nema_screwholes(mwidth, mwidth, thickness);
	}	
}

module _middle_plate(mwidth, awidth, alength, thickness) {
	hull() {
		cube([mwidth, mwidth, thickness], center=true);
		translate([mwidth/2+alength/2, 0,0]) cube([alength, awidth, thickness], center=true);
	}
}

module nutsnscrew_plate(cyl_diam, cyl_height, width, length, thickness, nuts, screw_diam) {
	difference() {
	hull() {
		translate([width/2,0,-(cyl_height+thickness)/2]) cylinder(d=cyl_diam, h=cyl_height+thickness, center=true);
		translate([0,0,-thickness/2-cyl_height] ) cube([width,length,thickness], center=true);
	}
		translate([width/2,0,-(cyl_height)/2-1]) nut(nuts);
		translate([width/2,0,-(thickness+cyl_height)/2]) cylinder(d=screw_diam, h=cyl_height+thickness, center=true); 
	}

	translate([width/2,0,-(thickness+cyl_height)/2+0.5]) cylinder(d=screw_diam, h=0.2, center=true); 
}

module nutsnscrew_holes(height, screw, nut) {
	translate([0,0,height/2]) screw(screw);
	translate([0,0,-height/2]) nut(nut);
}

