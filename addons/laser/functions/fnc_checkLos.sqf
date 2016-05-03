#include "script_component.hpp"
params ["_pos1", "_pos2", "_designator", "_seeker", ["_spacing", 100]];
private ["_vectorTo", "_distance", "_count", "_return", "_alt", "_pos"];

_return = true;
_vectorTo = [_pos2, _pos1] call BIS_fnc_vectorFromXToY;
_vectorTo params ["_x", "_y", "_z"];
_x = _x * 0.25;
_y = _y * 0.25;
_z = _z * 0.25;

_pos2 = _pos2 vectorAdd [_x, _y, _z];

// TODO lineIntersectsSurfaces
// player sideChat format["new los check"];
if(terrainIntersect [_pos2, _pos1]) then {
    _return = false;
} else {
    if(lineIntersects [_pos2, _pos1]) then {    // should take as arguments and add to this command objects to exclude - target and observer
        // player sideChat format["with: %1", lineIntersectsWith [_pos1, _pos2]];
        _return = false;
    };
};
_return;
