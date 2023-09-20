include <vars.scad>;
include <BOSL2/std.scad>;
use <BOSL2/shapes2d.scad>;
use <BOSL2/transforms.scad>;


// Calculated var for hanger
faucetY=hangerBottomPadding +faucetD/2;
module hanger() {
    scaleX = (faucetD + 2*hangerTopPadding )/faucetD;
    scaleY = (faucetY + faucetD/2 + hangerTopPadding)/(faucetY + faucetD/2);
    linear_extrude(hangerBaseHeight) difference() {
        xscale(scaleX) yscale(scaleY) hangerInner2Dcrave();
        hangerInner2Dcrave();
    };
    right(entreConnectors/2) connect();
    left(entreConnectors/2) connect();

}

module hangerInner2Dcrave() {
    union() {
        rect([faucetD, faucetY], anchor=[0,-1]);
        back(faucetY) circle(d=faucetD);
    }
}

module connect() {
    intersection() {
        cube([hangerTopPadding-1,wallThick*2,100], anchor=[0,1,-1]);
        union() {
            up(1) yrot(45) cube([hangerTopPadding/sqrt(2), connectY, hangerTopPadding/sqrt(2)], anchor=[0,1,0]);
            up(hangerBaseHeight-2) fwd(connectY) yrot(45) cube([hangerTopPadding/sqrt(2), connectY, hangerTopPadding/sqrt(2)], anchor=[0,1,0]);
            fwd(connectY) cube([hangerTopPadding, wallThick*2-connectY, hangerBaseHeight-2], anchor=[0,1,-1]);
        }
    }
}

hanger();
