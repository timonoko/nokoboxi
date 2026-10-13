include <roundedcube.scad>

$fn=80;
width=50;
length=70;
height=40;
radius=7;
thick=2;
lid_height=5;
lip_height=4;

module box () {
difference(){
  roundedcube([width,length,height+1],radius=radius);
  translate([thick,thick,thick])
  roundedcube([width-2*thick,length-2*thick,height-2*thick+1],radius=radius-thick);
  translate([0,0,height-lid_height]) cube([width,length,lid_height+1]);
}
}
module lid() {
  difference(){ union(){
      difference(){
	roundedcube([width,length,lid_height+radius],radius=radius);
	translate([0,0,lid_height]) cube([width,length,lid_height+5]);
      }
      difference(){
	translate([thick+0.3,thick+0.3,thick])
	  roundedcube([width-(2*thick)-0.6,length-2*thick-0.6,lid_height+lip_height+radius],radius=radius-thick);
	translate([0,0,lid_height+lip_height]) cube([width,length,lid_height+radius]);
      }
    }
    translate([2*thick,2*thick,thick])
      roundedcube([width-4*thick,length-4*thick,lid_height+lip_height+radius],radius=radius-2*thick);
  }
}
 
module reikia() {
  for (hoo = [11:9:height-12]) {
    for (i=[10:10:width-10]){
      translate([i,0,hoo]) rotate([-90,0,0]) cylinder(d=5,h=length+10);
    }
  }
}

module slots() {
  for (i=[15:10:length-10]){
     translate([0,i,-1/10]) rotate([0,0,-90]) cube([5,width+10,2.2]);
  }
}
module sluts() {
  for (i=[15:10:length-10]){
    translate([thick,i-0.5,5-lip_height]) rotate([90,0,0]) cylinder(d=2,h=4);
  }
  for (i=[15:10:length-10]){
     translate([width-thick,i-0.5,5-lip_height]) rotate([90,0,0]) cylinder(d=2,h=4);
  }
}
module lid_full(){
difference() {
  lid();
  translate([0,0,lid_height+lip_height-3])slots();
}
}
module box_full() {
  union() {
    difference(){
      box();
      reikia();
    }
    translate([0,0,height-lid_height-3]) sluts();
  }
}

module test(){
  difference(){
    union () {
      translate([width,0,40])rotate([0,180,0]) lid_full();
       box_full();
    }
    cube(40);
  }
}
//test();

box_full();translate([width+1,0,0]) lid_full();
