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
  bowsprit(SIZE);
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

module bowsprit(bs)
{
  translate([0,bs*37/64,bs*3/64]) rotate([290,0,0]) intersection()
  {
    scale([0.5,1,1]) cylinder(r1=bs*8/64,r2=th,h=bs/3,$fn=fn/4,center=true);
    translate([0,bs/2,0]) cube(bs,center=true);
  }
}

module underwater_hull(hl)
{
  scale([0.7, 2.1, 1])
    translate([0, 0, -hl / 12])
      cylinder(r1=hl/6, r2=hl/4, h=hl/6, $fn=fn, center=true);
}

module deck(hl)
{
  difference()
  {
    scale([0.7,2.1,1])
      translate([0,0,hl/12])
        cylinder(r=hl/4, h=hl/6, $fn=fn,center=true);
    difference()
    {
      scale([0.7,2.1,1])
        translate([0,0,hl/12+th/4])
          cylinder(r=(hl/4) -th, h=hl/6, $fn=fn,center=true);
      translate([0,-hl*13/32,hl/32])
        cube([hl,hl/4,hl/4],center=true);
      translate([0,-hl*12/32,-hl*2/32])
        cube([hl,hl/4,hl/4],center=true);
      translate([0,hl*14/32,-hl*2/32])
        cube([hl,hl/4,hl/4],center=true);
      translate([0,-hl*15/32,hl/32])
        cube([hl,hl/8,hl/2],center=true);
    }
    translate([0,hl/4.5,hl/1.7])
      cube(hl, center=true);
    translate([0,hl*1/32,hl*9/32])
      cube(hl/2, center=true);
  }
}

module hull_stern(hl)
{
  translate([0, hl * -17 / 32, hl / 32])
    cube([hl, hl / 8, hl / 2], center=true);
}


module hull()
{
  position = [0, SIZE * -1 / 32, SIZE * -3 / 32];

  difference()
  {
    translate(position)
      union()
      {
        underwater_hull(SIZE);
        deck(SIZE);
      }
      hull_stern(SIZE);
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
  crews_nest(SIZE);
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
