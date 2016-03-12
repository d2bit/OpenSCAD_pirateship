MIDDLE_TO_BACK = -1;
SIZE = 60;
th = 0.6;
fn=64;

ship();

module ship()
{
  sails();
  hull();
  rudder();
  bowsprit();
  % translate([0,0,SIZE/4]) cube(SIZE, center=true);
}

module rudder()
{
  intersection()
  {
    translate([0,SIZE*-25/64,SIZE*-10/64])
      cube([th,SIZE*5/32,SIZE*13/64], center=true);

    translate([0,SIZE*-33/64,SIZE*-1/64])
      rotate([0,90,0])
        cylinder(r=SIZE*8/32,h=th,$fn=fn);
  }
}

module bowsprit()
{
  translate([0,SIZE*37/64,SIZE*3/64])
    rotate([290,0,0])
      intersection()
      {
        scale([0.5,1,1])
          cylinder(r1=SIZE*8/64,r2=th,h=SIZE/3,$fn=fn/4,center=true);

        translate([0,SIZE/2,0])
          cube(SIZE,center=true);
      }
}

module underwater_hull()
{
  scale([0.7, 2.1, 1])
    translate([0, 0, -SIZE / 12])
      cylinder(r1=SIZE/6, r2=SIZE/4, h=SIZE/6, $fn=fn, center=true);
}

module stern_castle()
{
  translate([0 , SIZE * -13 / 32, SIZE / 32])
    cube([SIZE, SIZE / 4, SIZE / 4], center=true);

  translate([0, SIZE * -12 / 32, SIZE * -2 / 32])
    cube([SIZE, SIZE / 4, SIZE / 4], center=true);
}

module fore_castle()
{
  translate([0, SIZE * 14 / 32, SIZE * -2 / 32])
    cube([SIZE, SIZE / 4, SIZE / 4], center=true);
}

module deck()
{
  difference()
  {
    scale([0.7,2.1,1])
      translate([0,0,SIZE/12])
        cylinder(r=SIZE/4, h=SIZE/6, $fn=fn,center=true);
    difference()
    {
      scale([0.7,2.1,1])
        translate([0,0,SIZE/12+th/4])
          cylinder(r=(SIZE/4) -th, h=SIZE/6, $fn=fn,center=true);

      stern_castle();
      fore_castle();

      translate([0,-SIZE*15/32,SIZE/32])
        cube([SIZE,SIZE/8,SIZE/2],center=true);
    }
    translate([0,SIZE/4.5,SIZE/1.7])
      cube(SIZE, center=true);
    translate([0,SIZE*1/32,SIZE*9/32])
      cube(SIZE/2, center=true);
  }
}

module hull_stern()
{
  translate([0, SIZE * -17 / 32, SIZE / 32])
    cube([SIZE, SIZE / 8, SIZE / 2], center=true);
}


module hull()
{
  position = [0, SIZE * -1 / 32, SIZE * -3 / 32];

  difference()
  {
    translate(position)
      union()
      {
        underwater_hull();
        deck();
      }
      hull_stern();
  }
}

module fore_mast()
{
  x_position = SIZE / 4;
  heigh_resizer = 5 / 6;
  translate([0, x_position, 0])
    rigging(SIZE * heigh_resizer);
}

module main_mast()
{
  crews_nest();
  rigging(SIZE);
}

module mizzen_mast()
{
  x_position = SIZE / 5 * MIDDLE_TO_BACK;
  heigh_resizer = 4 / 6;
  translate([0, x_position, 0])
    rigging(SIZE * heigh_resizer);
}

module crews_nest()
{
  z_position = SIZE * 28 / 32;
  nest_base_radius = SIZE * 2 / 64;
  nest_top_radius = SIZE * 2.5 / 64;
  nest_height = SIZE * 3 / 64;
  translate([0, 0, z_position])
    cylinder(r1=nest_base_radius, r2=nest_top_radius, h=nest_height, $fn=fn/4, center=true);
}

module bowsprit_sail()
{
  translate([0,SIZE*15/32,SIZE*8/32])
    rotate([205,0,0])
      scale([1,1,2])
        rotate([0,90,0])
          cylinder(r=SIZE/5,h=th,$fn=3,center=true);
}

module sails()
{
  translate([0,0,SIZE*-4/62])
  {
    fore_mast();
    main_mast();
    mizzen_mast();

    bowsprit_sail();

    translate([0,SIZE*-1/32,-SIZE*1/32])
      cube([th,SIZE*14/16,SIZE/8],center=true);
  }
}

module rigging(mh=30)
{
  cylinder(r=th*2/3,h=mh*11/12,$fn=fn/4);
  rotate([0,-90,0])
    translate([mh/2,0,0]) union()
    {
      translate([0,-mh/64,0]) intersection()
      {
        difference()
        {
          scale([1,0.67,1]) translate([-mh/6,0,0])
            cylinder(r=mh/1.5,h=th,$fn=3,center=true);
          translate([0,-mh*5/6,0]) rotate([0,0,27.5]) scale([2,1,1])
            cylinder(r=mh/1.5,h=th+1,$fn=fn,center=true);
        }
        translate([0,-mh*1/1.9,0]) rotate([0,0,-27.5]) scale([2,1,1])
          cylinder(r=mh/1.5,h=th+1,$fn=fn,center=true);
      }
      translate([0,mh/16,0]) mast(mh);
    }
}

module mast(mh=30)
{
  translate([-mh/4,0,0]) sail(mh/4);
  translate([mh/8,-th*1.5,0]) sail(mh/8);
  translate([mh*5/16,-th*2,0]) sail(mh/16);
}

module sail(size)
{
  intersection()
  {
    scale([1.5,1,1]) translate([0,-size,0]) difference()
    {
      cylinder(r=size, h=size*5/2,$fn=fn,center=true);
      cylinder(r=size-th, h=size*5/2+1,$fn=fn,center=true);
    }
    cube(size*2,center=true);
    * translate([size*2,0,0]) scale([2,1,1])
      rotate([0,45,0]) cube(size*3,center=true);
    translate([size/3,0,0]) scale([2,1,1]) rotate([90,0,0])
      cylinder(r=size*1,h=size*2,$fn=fn,center=true);
  }
}
