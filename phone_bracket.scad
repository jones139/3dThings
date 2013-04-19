// Mobile Phone mount for wheelchair.

use <../MCAD/nuts_and_bolts.scad>

phone_h = 110;    // mm; height of phone
phone_w = 50;     // mm: width of phone
phone_d = 6;      // mm: depth of phone.
clip_oh = 2; // mm: overhang of clip over front of phone.
clip_th = 2;       // mm: thickness of clip
screw_dia = 3;
tol = 0.1;        // mm  (how much  bigger to make objects than


module bracket_leg(c_th,c_oh,p_h,p_d) {
	x0 = 0 + c_th+c_oh;  		y0 = c_th+p_d;
	x1 = x0;							y1 = y0+c_th;
	x2 = x0 - c_th-c_oh; 		y2 = y1;
	x3 = x2;							y3 = y1 - 2*c_th - p_d;
	x4 = x3+p_h+2*c_th; y4 = y3;
	x5 = x4;							y5 = y3+2*c_th+p_d;
	x6 = x5 - c_th - c_oh; y6 = y5;
	x7 = x6;							y7 = y6 - c_th;
	x8 = x7 + c_oh;				y8 = y7;
	x9 = x8;							y9 = y8 - p_d;
	x10 = x9 - p_h;				y10 = y9;
	x11 = x10;						y11 = y10 + p_d;
	linear_extrude(height=c_th)
	polygon([
		[x0,y0],[x1,y1],[x2,y2],[x3,y3],[x4,y4],[x5,y5],
		[x6,y6],[x7,y7],[x8,y8],[x9,y9],[x10,y10],[x11,y11],
		[x0,y0]
	]);

}

// First we make the object solid, then subtract the cut-outs at the
// end - makes the code much simpler than doing cut outs as we go.
difference() {
	union() {
		// Phone
		//translate([clip_th,clip_th,0]) cube([phone_h,phone_d,phone_w]);
		// Clip Legs
		translate([0,0,phone_w/3])
			bracket_leg(clip_th,clip_oh,phone_h,phone_d);
		translate([0,0,phone_w*2/3])
			bracket_leg(clip_th,clip_oh,phone_h,phone_d);
		translate([phone_h/3,0,1*phone_w+clip_th])
			rotate(90,[0,1,0])
				bracket_leg(clip_th,clip_oh,phone_w,phone_d);
		translate([phone_h*2/3,0,1*phone_w+clip_th])
			rotate(90,[0,1,0])
				bracket_leg(clip_th,clip_oh,phone_w,phone_d);
		// Clip_Base
		translate([phone_h/3,0,phone_w/3])
			color("blue") cube([phone_h/3,clip_th,phone_w/3]);
		// Clip Base circular boss
		translate([clip_th+phone_h/2,-1*clip_th,phone_w/2+clip_th/2])
			rotate(270,[1,0,0]) cylinder(r=phone_w/6,h=clip_th);
		
	}
	// nut holes.
	translate([clip_th+phone_h/2,-1*tol,phone_w/2+clip_th/2]) 
		rotate(270,[1,0,0]) color("red") nutHole(screw_dia);
	translate([clip_th+phone_h/2,tol,phone_w/2+clip_th/2])
		rotate(90,[1,0,0])
			cylinder(r=0.1+screw_dia/2,h=3*clip_th+tol);
	
	
}
	
