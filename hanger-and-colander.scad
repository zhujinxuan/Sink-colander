include <BOSL2/std.scad>;
use <BOSL2/shapes2d.scad>;
use <BOSL2/transforms.scad>;

faucetD = 40;
hangerTopPadding = 8;
hangerBottomPadding = 16+7+2;
hangerBaseHeight = 5;
connectorY = wallThickness + 1;
wallThick = 4;


faucetY=hangerBottomPadding +faucetD/2;
module hangerMain() {
    scaleX = (faucetD + 2*hangerTopPadding )/faucetD;
    scaleY = (faucetY + faucetD/2 + hangerTopPadding)/(faucetY + faucetD/2);
    linear_extrude(hangerBaseHeight) difference() {
        xscale(scaleX) yscale(scaleY) hangerInner2Dcrave();
        hangerInner2Dcrave();
    }
    right(faucetD/2) hangerConnector();
    left(faucetD/2) hangerConnector();
}

module hangerInner2Dcrave() {
    union() {
        rect([faucetD, faucetY], anchor=[0,-1]);
        back(faucetY) circle(d=faucetD);
    }
}

module hangerConnector() {
    linear_extrude(hangerBaseHeight/2 )
        rect([connectorY,hangerTopPadding], anchor=[0,1]);
    linear_extrude(hangerBaseHeight)
        fwd(connectorY) rect([wallThick ,hangerTopPadding], anchor=[0,1]);
}

hangerMain();
