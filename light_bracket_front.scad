// Bracket to attach to wheelchair strut to mount bike light.

use <../MCAD/nuts_and_bolts.scad>

strut_dia = 23.5;	// mm:  diameter of the strut the bracket clamps to.
hbar_dia = 22.5;   // mm:  diameter of the stub of 'handle bar' for the light.
hbar_len = 30;   // mm:  the length of the stub of 'handlebar'
bracket_th = 3.0;	//mm
bracket_h  = 30;	//mm
clamp_w = 10;	//mm
clamp_th = 10;	//mm
cutout_th = 1;	//mm
screw_dia  = 3;  // 3mm = M3
screw_csk = 2; // mm
tol = 0.1;        // mm  (how much  bigger to make objects than
			//       target object when subtracting.

// First we make the object solid, then subtract the cut-outs at the
// end - makes the code much simpler than doing cut outs as we go.
difference() {
	union() {
		// Wrap around bit
		cylinder(r=strut_dia/2+bracket_th,h=bracket_h);		
		// Clamp
		translate([-0.5*clamp_th,strut_dia/2,0])
			cube([clamp_th,clamp_w,bracket_h]);
		// make the handlebar stub
		translate([0,0,bracket_h/2]) rotate(90,[0,1,0])
			cylinder(r=hbar_dia/2,h=hbar_len+strut_dia/2);
	}
	// cut outs - hole in middle, and slot through clamp.
	translate([0,0,-1*tol]) cylinder(r=strut_dia/2,h=bracket_h+2*tol);
	translate([-1*cutout_th/2,strut_dia/2 - tol,0]) {
		cube([cutout_th,clamp_w+2*tol,bracket_h+2*tol]);
	}
	// nut holes.
	translate([0.5*clamp_th+tol,strut_dia/2+clamp_w/2,bracket_h/3]) 
		rotate(270,[0,1,0]) color("red") nutHole(screw_dia);
	translate([0.5*clamp_th+tol,strut_dia/2+clamp_w/2,2*bracket_h/3]) 
		rotate(270,[0,1,0]) color("red") nutHole(screw_dia);
	// bolt holes
	translate([0.5*clamp_th+tol,strut_dia/2+clamp_w/2,bracket_h/3]) 
		rotate(270,[0,1,0]) cylinder(r=screw_dia/2+2*tol,h=clamp_th+2*tol,$fs = 1);
	translate([0.5*clamp_th+tol,strut_dia/2+clamp_w/2,2*bracket_h/3]) 
		rotate(270,[0,1,0]) cylinder(r=screw_dia/2+2*tol,h=clamp_th+2*tol,$fs = 1);
	
}
	
//	$fs=1; translate([0,0,0]) boltHole(3,length=20);