// Overall box dimensions
x = 50; // m
y = 100;  // mm
z =20;   // mm
th = 2;  // mm
ex = 0.1; // mm extra length to add make sure subtractions work ok.

// 9V battery clip
batt_w = 15; // mm  battery size
batt_d = 20; // mm  battery size
batt_x = 0;  // mm  battery position
batt_y = 0;  // mm  battery position
clip_w = 20; // mm  battery clip
clip_th = 1; // mm 
clip_tab = 1; // mm

// Slot for SD Card
sd_z = 10+th;     // sd card slot location z
sd_w = 20;     //width of sd card slot
sd_h = 5;      // depth of sd card slot
sd_x = 0;      // sd card slot location x
sd_y = y-sd_w-10;     // sd card slot location y


module boardClip(h) {
	board_th = 1.6; //mm
	boardClip_th = 1.0;  // mm
	boardClip_tab = 1;  // mm
	rotate([90,0,0]) {
		linear_extrude(height=boardClip_th)
			polygon(points=[
								[0,0], 
								[0,h+board_th+boardClip_tab],
								[boardClip_th+boardClip_tab,h+board_th+boardClip_tab],
								[boardClip_th,h+board_th],
								[boardClip_th,h],
								[boardClip_th+boardClip_tab,h],
								[boardClip_th,h-boardClip_tab],
								[boardClip_th,0]
			]);
	}
}


difference() {
	union() {
		// base and walls.
		color("red") cube([x,y,th]);
		color("blue") translate([0,0,0]) cube([x,th,z]);
		color("blue") translate([0,y-th,0]) cube([x,th,z]);
		color("yellow") translate([0,0,0]) cube([th,y,z]);
		color("yellow") translate([x-th,0,0]) cube([th,y,z]);
		// battery clip
		color("green") translate([x/2-clip_w/2,batt_y+th+batt_d,th]) cube([clip_w,clip_th,batt_w]);
		color("green") translate([x/2-clip_w/2,batt_y+batt_d+clip_th,clip_th+batt_w]) cube([clip_w,clip_tab+clip_th,clip_th]);
		translate([10,50,th]) boardClip(5);
		translate([10,80,th]) boardClip(5);
		translate([40,50,th]) rotate([0,0,180]) boardClip(5);
		translate([40,80,th]) rotate([0,0,180]) boardClip(5);
	}
	//cut-outs
	union() {
		// sd card slot.
		color("blue") translate([sd_x-ex,sd_y,sd_z]) cube([th+2*ex,sd_w,sd_h]);
	}
}