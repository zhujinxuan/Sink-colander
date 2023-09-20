include <vars.scad>;
include <BOSL2/std.scad>;
use <BOSL2/shapes2d.scad>;
use <BOSL2/transforms.scad>;

module holeRect(size, holeD, gap, padding) {
    layerH = gap + holeD;
    paddingC = padding + holeD/2;

    difference() {
        rect(size, anchor=[0,-1]);
        for (h = [ paddingC: layerH: size.y - paddingC]) {
            for (x = [-size.x/2 + paddingC:layerH:size.x/2 - paddingC]) {
                right(x) back(h) square(holeD/sqrt(2), spin=45, anchor=CENTER);
            }
        }
        for (h = [paddingC + layerH/2 : layerH: size.y - paddingC]) {
            for (x = [-size.x/2 + paddingC + layerH/2:layerH:size.x/2 - paddingC]) {
                right(x) back(h) square(holeD/sqrt(2), spin=45, anchor=CENTER);
            }
        }
    };
}

module colander() {
    bottom();
    front();
    leftSide();
    rightSide();
    backSide();
}
module backSide() {
    connectHoleHeight = colanderDepth - 15;
    back(colanderLength) difference() {
        cube([colanderWidth, wallThick, colanderDepth], anchor=[0,1,-1]);
        right(entreConnectors/2) up(60) connectHole();
        left(entreConnectors/2) up(60) connectHole();
    }
}

module connectHole() {
    y = 100;
    cube([hangerTopPadding, y, hangerBaseHeight], anchor=CENTER);
    up(hangerBaseHeight/2) yrot(45) cube([hangerTopPadding/sqrt(2), y, hangerTopPadding/sqrt(2)], anchor=CENTER);
}


module leftSide() {
    up(colanderDepth/2) left(colanderWidth/2) yrot(90) linear_extrude(wallThick) holeRect(size= [colanderDepth, colanderLength],holeD=10, gap=2, padding=5);
}
module rightSide() {
    xflip() leftSide();
}

module bottom() {
    linear_extrude(wallThick) holeRect(size= [colanderWidth, colanderLength],holeD=10, gap=2, padding=5);
}
module front() {
    back(wallThick) xrot(90) linear_extrude(wallThick) holeRect(size= [colanderWidth, colanderLength],holeD=10, gap=2, padding=5);
}

colander();
