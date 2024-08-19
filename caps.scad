// Cherry MX standard (OEM) measurements
// Measurements and key sizes collected from:
// http://blog.maxkeyboard.com/dwkb/keycap-profile-size-information/
// https://support.wasdkeyboards.com/hc/en-us/articles/115009701328-Keycap-Size-Compatibility
// http://i.imgur.com/K5kui2s.jpg
// Visual information of key text collected from:
// https://www.keychatter.com/wp-content/uploads/2014/07/filco-standard-layout.png
// row number - front and back heights
r1_f = 10.1;
r1_b = 7.9;
r2_f = 9.3;
r2_b = 8;
r3_f = 9.3;
r3_b = 9;
r4_f = 10.8;
r4_b = 11.4;

// width measurement
x1_00 = 18;
x1_25 = 22.8;
x1_50 = 27.5;
x1_75 = 32.3;
x2_00 = 37.1;
x2_25 = 41.8;
x2_75 = 51.4;
space = 118.1;

// spacing measurement
normalSpacing = 12;
spacebarSpacing = 50; // default x6_25
spacebarX6Spacing = 49;
spacebarX6_5Spacing =  52.5;

// other measurements
rounding = 0.0001;
postDiam = 5.54;
crossLong = 4.1;
crossWide = 1.35;

// unspecified details
insetX = 5;
insetYfront = 3;
insetYback = 0.6;
wallThick = 1;
postBottomGap = 2;
topCurveDip = 1;

$fn = 36;

// This function borrowed from OpenSCAD Snippet Pad:
// https://openscadsnippetpad.blogspot.com/2017/05/circle-defined-by-three-points.html
// Finding the Center of a Circle from Three Points.
// Points must not be equal or collinear, - lie on a single straight line 
function circle_by_three_points(A, B, C) =
let (
  yD_b = C.y - B.y,  xD_b = C.x - B.x,  yD_a = B.y - A.y,
  xD_a = B.x - A.x,  aS = yD_a / xD_a,  bS = yD_b / xD_b,
  cex = (aS * bS * (A.y - C.y) + 
  bS * (A.x + B.x) -    aS * (B.x + C.x)) / (2 * (bS - aS)),
  cey = -1 * (cex - (A.x + B.x) / 2) / aS + (A.y + B.y) / 2
)
[cex, cey];


// front and back are heights, defined by row number
// deep and wide are measurements defined by keysize multiples
// keyText1 and keyText2 are the literal lines of text to be displayed on top of the key
// spacing is the measure from center to center of middle and offset stems, if applicable
// spaceAlign specifies the orientation for support posts, "vertical" for num+ and numEnter
module makeKey(front, back, deep, wide, keyText1, keyText2="", spacing=0, spaceAlign="horizontal")
{
    // find the lower height to base the inside roof on
    lowerHeight = (front < back ? front : back);
    union()
    {
        difference()
        {
            // outter shell
            hull()
            {
              // bottom
               // right
                // back
                translate([ (wide/2 - rounding/2),  (deep/2 - rounding/2), 0])
                    cylinder(h=0.001, d=rounding);
                // front
                translate([ (wide/2 - rounding/2), -(deep/2 - rounding/2), 0])
                    cylinder(h=0.001, d=rounding);
               // left
                // back
                translate([-(wide/2 - rounding/2),  (deep/2 - rounding/2), 0])
                    cylinder(h=0.001, d=rounding);
                // front
                translate([-(wide/2 - rounding/2), -(deep/2 - rounding/2), 0])
                    cylinder(h=0.001, d=rounding);
              // top
               // right
                // back
                translate([ (wide/2 - rounding/2 - insetX/2),  (deep/2 - rounding/2 - insetYback), back - rounding/2])
                    sphere(d=rounding);
                // front
                translate([ (wide/2 - rounding/2 - insetX/2), -(deep/2 - rounding/2 - insetYfront), front - rounding/2])
                    sphere(d=rounding);
               // left
                // back
                translate([-(wide/2 - rounding/2 - insetX/2),  (deep/2 - rounding/2 - insetYback), back - rounding/2])
                    sphere(d=rounding);
                // front
                translate([-(wide/2 - rounding/2 - insetX/2), -(deep/2 - rounding/2 - insetYfront), front - rounding/2])
                    sphere(d=rounding);
            } // end hull
            
            // inner cavity
            hull()
            {
              // bottom
               // right
                // back
                translate([ (wide/2 - rounding/2 - wallThick),  (deep/2 - rounding/2 - wallThick), -0.001])
                    cylinder(h=0.001, d=rounding);
                // front
                translate([ (wide/2 - rounding/2 - wallThick), -(deep/2 - rounding/2 - wallThick), -0.001])
                    cylinder(h=0.001, d=rounding);
               // left
                // back
                translate([-(wide/2 - rounding/2 - wallThick),  (deep/2 - rounding/2 - wallThick), -0.001])
                    cylinder(h=0.001, d=rounding);
                // front
                translate([-(wide/2 - rounding/2 - wallThick), -(deep/2 - rounding/2 - wallThick), -0.001])
                    cylinder(h=0.001, d=rounding);
              // top
               // right
                // back
                translate([ (wide/2 - rounding/2 - insetX/2 - wallThick),  (deep/2 - rounding/2 - insetYback - wallThick), lowerHeight - wallThick - rounding/2])
                    sphere(d=rounding);
                // front
                translate([ (wide/2 - rounding/2 - insetX/2 - wallThick), -(deep/2 - rounding/2 - insetYfront - wallThick), lowerHeight - wallThick - rounding/2])
                    sphere(d=rounding);
               // left
                // back
                translate([-(wide/2 - rounding/2 - insetX/2 - wallThick),  (deep/2 - rounding/2 - insetYback - wallThick), lowerHeight - wallThick - rounding/2])
                    sphere(d=rounding);
                // front
                translate([-(wide/2 - rounding/2 - insetX/2 - wallThick), -(deep/2 - rounding/2 - insetYfront - wallThick), lowerHeight - wallThick - rounding/2])
                    sphere(d=rounding);
            } // end hull
            
            // if only one line of text
            if (keyText2 == "")
            {
                translate([-wide/2 + insetX/2 + rounding*0.75, 0, lowerHeight - wallThick/2])
                    linear_extrude(abs(front - back) + wallThick/2)
                        text(text=keyText1, size=2.5, font="Arial", halign="left", valign="center");
            }
            // if two lines of text
            else
            {
                translate([-wide/2 + insetX/2 + rounding*0.75, 2, lowerHeight - wallThick/2])
                    linear_extrude(abs(front - back) + wallThick/2)
                        text(text=keyText1, size=2.5, font="Arial", halign="left", valign="center");
                translate([-wide/2 + insetX/2 + rounding*0.75, -1.5, lowerHeight - wallThick/2])
                    linear_extrude(abs(front - back) + wallThick/2)
                        text(text=keyText2, size=2.5, font="Arial", halign="left", valign="center");
            }
        } // end difference
        
        // center post
        
        center_post_shift = -1.0 * (0.5 * x1_75 - 0.5 * x1_50);
        difference()
        {
            translate([center_post_shift, 0, postBottomGap])
                cylinder(h=lowerHeight - wallThick - postBottomGap, d=postDiam);
            translate([center_post_shift, 0, 0]){
                cube([crossWide, crossLong, (lowerHeight - wallThick)*2], center=true);
                cube([crossLong, crossWide, (lowerHeight - wallThick)*2], center=true);
            }
        } // end difference
        
        // if this key has extra support posts
        if (spacing != 0)
        {
            translate([spaceAlign == "horizontal" ? spacing : 0, spaceAlign == "vertical" ? spacing : 0, 0])
                difference()
                {
                    translate([0, 0, postBottomGap])
                        cylinder(h=lowerHeight - wallThick - postBottomGap, d=postDiam);
                    cube([crossWide, crossLong, (lowerHeight - wallThick)*2], center=true);
                    cube([crossLong, crossWide, (lowerHeight - wallThick)*2], center=true);
                } // end difference
            
            translate([spaceAlign == "horizontal" ? -spacing : 0, spaceAlign == "vertical" ? -spacing : 0, 0])
                difference()
                {
                    translate([0, 0, postBottomGap])
                        cylinder(h=lowerHeight - wallThick - postBottomGap, d=postDiam);
                    cube([crossWide, crossLong, (lowerHeight - wallThick)*2], center=true);
                    cube([crossLong, crossWide, (lowerHeight - wallThick)*2], center=true);
                } // end difference
        }
    } // end union
} // end makeKey

makeKey(r2_f, r2_b, x1_00, x1_75, "");


