// PS3Eye Pan and Tilt Mount
// Tiago Serra, Joel Belouet, Catarina Mota
// serratiago@gmail.com, joel.belouet@neuf.fr, catarinamfmota@gmail.com, 
// Creative Commons Attribution Share Alike
// 20100620

//camBox
camBoxWall=3;
camBoxHeight=80+camBoxWall*2;
camBoxWidth=60+camBoxWall*2;
camBoxDepth=20+camBoxWall;
camBoxRad=10; //radius of cam lens hole

//camPole
poleSide=10;
poleLength=80;

//camAttach
boltHeadHeigh=4;
poleFriction=2;
poleSupportWidth=5;

//bolt
boltRad=1.5;

//----------------------

//camBox();
//camLid();
camAttach();
//camPole();

//----------------------

module camAttach() {
	rotation= sqrt(pow(poleSide/2,2)+pow(poleSide/2,2));
	echo(rotation);
	sideHeight=boltHeadHeigh+rotation*2+poleFriction;
	baseLength=poleSide+poleFriction+poleSupportWidth*2;

	difference(){
		union(){
			translate([0,0,camBoxWall/2]) box(poleSide+poleFriction+poleSupportWidth*2,poleSide+camBoxWall*4,camBoxWall);
			translate([-baseLength/2+poleSupportWidth/2,0,sideHeight/2+camBoxWall]) box(poleSupportWidth,poleSide+camBoxWall*4,sideHeight);
			translate([baseLength/2-poleSupportWidth/2,0,sideHeight/2+camBoxWall]) box(poleSupportWidth,poleSide+camBoxWall*4,sideHeight);
		}
		translate([0,0,-sideHeight/2]) cylinder(sideHeight,boltRad,boltRad);
		#translate([-baseLength,0,boltHeadHeigh+rotation+2+camBoxWall]) rotate([0,90,0]) cylinder(baseLength*2,boltRad,boltRad);
	}
}

module camPole() {
	difference(){
		box(poleLength,poleSide, poleSide);
		translate([-poleLength/2+poleSide/2,0,-poleSide]) cylinder(poleSide*2,boltRad, boltRad);
		rotate([90,0,0]) translate([poleLength/2-poleSide/2,0,-poleSide]) cylinder(poleSide*2,boltRad, boltRad);		
	}
}


module camBox() {
	difference(){
		box(camBoxWidth,camBoxHeight,camBoxDepth);
			translate([0,0,camBoxWall/2]){
				box(camBoxWidth-camBoxWall*2,camBoxHeight-camBoxWall*2,camBoxDepth);
			}
			#translate([0,0,-camBoxDepth]) cylinder(camBoxDepth, camBoxRad, camBoxRad);
	}
}

module camLid() {
	difference(){
		union(){
			translate([0,0,camBoxWall/2]) box(camBoxWidth,camBoxHeight,camBoxWall);
			translate([0,0,camBoxWall*1.5]) box(camBoxWidth-camBoxWall*2,camBoxHeight-camBoxWall*2,camBoxWall*3);
		}
		#translate([0,0,-camBoxDepth/2]) cylinder(camBoxDepth, camBoxRad, camBoxRad);
	}
}


//----------------------
//box(width, height, depth);
//hollowBox(w,h,d,wall);
//roundedBox(width, height, depth, factor);
//cone(height, radius);
//oval(width, height, depth);
//tube(height, radius, wall);
//ovalTube(width, height, depth, wall);
//tearDrop(diam);
//hexagon(height, depth);
//octagon(height, depth);
//dodecagon(height, depth);
//hexagram(height, depth);
//rightTriangle(adjacent, opposite, depth);
//equiTriangle(side, depth);
//12ptStar(height, depth);

//----------------------

module box(w,h,d) {
	scale ([w,h,d]) cube(1, true);
}

module hollowBox(w,h,d,wall){
	difference(){
		box(w,h,d);
		box(w-wall*2,h-wall*2,d);
	}
}

module roundedBox(w,h,d,f){
	difference(){
		box(w,h,d);
		translate([-w/2,h/2,0]) cube(w/(f/2),true);
		translate([w/2,h/2,0]) cube(w/(f/2),true);
		translate([-w/2,-h/2,0]) cube(w/(f/2),true);
		translate([w/2,-h/2,0]) cube(w/(f/2),true);
	}
	translate([-w/2+w/f,h/2-w/f,-d/2]) cylinder(d,w/f, w/f);
	translate([w/2-w/f,h/2-w/f,-d/2]) cylinder(d,w/f, w/f);
	translate([-w/2+w/f,-h/2+w/f,-d/2]) cylinder(d,w/f, w/f);
	translate([w/2-w/f,-h/2+w/f,-d/2]) cylinder(d,w/f, w/f);
}

module cone(height, radius) {
		cylinder(height, radius, 0);
}

module oval(w,h,d) {
	scale ([w/100, h/100, 1]) cylinder(d, 50, 50);
}

module tube(height, radius, wall) {
	difference(){
		cylinder(height, radius, radius);
		cylinder(height, radius-wall, radius-wall);
	}
}

module ovalTube(w,h,d,wall) {
	difference(){
		scale ([w/100, h/100, 1]) cylinder(d, 50, 50);
		scale ([w/100, h/100, 1]) cylinder(d, 50-wall, 50-wall);
	}
}


module tearDrop(diam) {
	f=0.52;
	union(){
		translate([0,diam*0.70,depth/2]) rotate([0,0,135]) rightTriangle(diam*f,diam*f, depth);
		cylinder(depth,diam/2,diam/2);
	}
}

module hexagon(height, depth) {
	boxWidth=height/1.75;
		union(){
			box(boxWidth, height, depth);
			rotate([0,0,60]) box(boxWidth, height, depth);
			rotate([0,0,-60]) box(boxWidth, height, depth);
		}
}

module octagon(height, depth) {
	intersection(){
		box(height, height, depth);
		rotate([0,0,45]) box(height, height, depth);
	}
}

module dodecagon(height, depth) {
	intersection(){
		hexagon(height, depth);
		rotate([0,0,90]) hexagon(height, depth);
	}
}

module hexagram(height, depth) {
	boxWidth=height/1.75;
	intersection(){
		box(height, boxWidth, depth);
		rotate([0,0,60]) box(height, boxWidth, depth);
	}
	intersection(){
		box(height, boxWidth, depth);
		rotate([0,0,-60]) box(height, boxWidth, depth);
	}
	intersection(){
		rotate([0,0,60]) box(height, boxWidth, depth);
		rotate([0,0,-60]) box(height, boxWidth, depth);
	}
}

module rightTriangle(adjacent, opposite, depth) {
	difference(){
		translate([-adjacent/2,opposite/2,0]) box(adjacent, opposite, depth);
		translate([-adjacent,0,0]){
			rotate([0,0,atan(opposite/adjacent)]) dislocateBox(adjacent*2, opposite, depth);
		}
	}
}

module equiTriangle(side, depth) {
	difference(){
		translate([-side/2,side/2,0]) box(side, side, depth);
		rotate([0,0,30]) dislocateBox(side*2, side, depth);
		translate([-side,0,0]){
			rotate([0,0,60]) dislocateBox(side*2, side, depth);
		}
	}
}

module 12ptStar(height, depth) {
	starNum=3;
	starAngle=360/starNum;
	for (s=[1:starNum]){
		rotate([0, 0, s*starAngle]) box(height, height, depth);
	}
}







