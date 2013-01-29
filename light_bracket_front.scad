// Bracket to attach to wheelchair strut to mount bike light.

strut_dia = 20;	// mm:  diameter of the strut the bracket clamps to.
hbar_dia = 20;   // mm:  diameter of the stub of 'handle bar' for the light.
hbar_len = 50;   // mm:  the length of the stub of 'handlebar'
bracket_th = 2;	//mm
bracket_h  = 30;	//mm
bracket_w = 10;	//mm
clamp_th = 5;	//mm
cutout_th = 1;	//mm
overlap = 5;	//mm (how much  bigger to make objects than
			//       target object when subtracting.

// First we make the object solid, then subtract the cut-outs at the
// end - makes the code much simpler than doing cut outs as we go.
difference() {
	union() {
		// Wrap around bit
		cylinder(r=strut_dia/2+bracket_th,h=bracket_h);		
		// Clamp
		translate([-0.5*clamp_th,strut_dia/2,0])
			cube([clamp_th,bracket_w,bracket_h]);
		// make the handlebar stub
		translate([0,0,bracket_h/2]) rotate(90,[0,1,0])
			cylinder(r=hbar_dia/2,h=hbar_len+strut_dia/2);
	}
	cylinder(r=strut_dia/2,h=bracket_h);
	// cut out
	translate([-1*cutout_th/2,0,0]) {
		cube([cutout_th,bracket_w+2*overlap,bracket_h+2*overlap]);
	}
}