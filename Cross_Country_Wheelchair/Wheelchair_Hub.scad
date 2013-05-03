// Cross Country Wheelchair Hub, with spigott for chain drive sprocket.
//
// Notes:
// z=0 is non-drive end (wheel spoke slots)
//
// Graham Jones, April 2013

h_h = 25.5; // Hub height in mm.
h_od = 69.5; // Hub outer diameter in mm.
h_id = 21.5; // Hub inner diameter (axle hole) in mm.

b_od = 28.7;  // outer diameter of wheel bearing in mm.
b_th = 9.0;   // thickness of wheel bearing in mm.

r_id = 28.7;     // wheel hub rebate inner diameter in mm;
r_od = 51.4;		// wheel hub rebate outer diameter in mm
r_th = 7.3;     // wheel hub rebate thickness (depth) in mm.

nSpokes = 10;  // Number of spokes in wheel.
s_od = 2.8;    // diameter of spokes (or really width of slots) in mm.
s_len = 50;    // length of spokes in mm.

nBrakeHoles = 20;  // Number of holes for the handbrake
bh_od = 5.7;   // diameter of brake holes in mm.
bh_h  = 8.4;   // depth of brake holes in mm.
bh_pcd = 50.0; // Pitch circle diameter of brake holes in mm.

g_h = 5;      // height of spiggot
g_od= 32.3;	  // diameter of the main spiggot.
g_d = 1;       // depth of spiggott splines in mm.
nSplines = 9;  // number of splines on the spiggott.

tol = 0.1;   // tolerance in mm.

rotate(180,[1,0,0]) {
	union() {
		spiggot();
		hub();
	}
}

module spiggot() {
		// spiggott
		translate([0,0,h_h])
			union() {
				for (sn = [1:nSplines-1]) {
					assign(ang = 2*sn*360/(2*nSplines)) {
						rotate(ang,[0,0,1])
							color("red") 
								arc( g_d+tol, g_h, g_d+g_od/2-tol, 360/(2*nSplines) );
					}
				}
				color("green")
					difference() { 
						cylinder(r=g_od/2,h=g_h);
						translate([0,0,-1*tol])
							cylinder(r=b_od/2,h=g_h+2*tol);
					}
			}
}

module hub() {
difference() {
	union() {
		// main cylinder
		cylinder(r=h_od/2,h=h_h);
	}
	// axle hole
	translate([0,0,-1*tol])
		cylinder(r=h_id/2, h=h_h+2*tol);
	// Bearing hole
	translate([0,0,h_h-b_th])
		color("red") cylinder(r=b_od/2,h=b_th+g_h+tol);
	// Wheel hub rebate
	translate([0,0,-1*tol]) difference() {
		color("blue") cylinder(r=r_od/2,h=r_th+tol);
		translate([0,0,-1*tol]) color("blue") cylinder(r=r_id/2,h=r_th+2*tol);
	}

	// Slots for wheel spokes
	for (sn = [0:nSpokes-1]) {
		assign(ang = sn*360/nSpokes) {
			rotate(ang,[0,0,1])
				translate([s_od/2,r_id/2,-1*tol])
					rotate(270,[0,1,0])
						cube([h_h/2+tol,s_len,s_od]);
						//cylinder(r=s_od/2,h=s_len);
		}
	}
	for (bh = [0:nBrakeHoles-1]) {
		assign(ang = bh*360/nBrakeHoles) {
			rotate(ang,[0,0,1])
				translate([bh_pcd/2,0,h_h-bh_h])
					color("blue") cylinder(r=bh_od/2,h=bh_h+tol);
		}
	}

}
}


/* 
 * Excerpt from... 
 * 
 * Parametric Encoder Wheel 
 *
 * by Alex Franke (codecreations), March 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
*/
 
module arc( height, depth, radius, degrees ) {
    // This dies a horible death if it's not rendered here 
    // -- sucks up all memory and spins out of control 
    render() {
        difference() {
            // Outer ring
            rotate_extrude($fn = 100)
                translate([radius - height, 0, 0])
                    square([height,depth]);
         
            // Cut half off
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
            // Cover the other half as necessary
            rotate([0,0,180-degrees])
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
        }
    }
}