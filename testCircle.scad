dia = 25; // mm
th  = 1;  // mm
h   = 5;
tol = 1; // mm

difference() {
	cylinder(r=dia/2,h=h);
	translate([0,0,-1*tol])
		cylinder(r=dia/2 - th,h=h+2*tol);
}