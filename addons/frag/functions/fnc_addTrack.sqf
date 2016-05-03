#include "script_component.hpp"
params ["_origin", "_obj", ["_color", [1, 0, 0, 1]]];
private ["_data", "_index", "_objSpd", "_origin", "_positions"];

if (GVAR(autoTrace)) then {
    [] call FUNC(startTracing);
};

// setAccTime 0.05;
_index = (count GVAR(traces));
_positions = [];
_objSpd = vectorMagnitude (velocity _obj);
_positions set[(count _positions), [(getPos _obj), _objSpd]];
_data = [_origin, typeOf _origin, typeOf _obj, _objSpd, _positions, _color];

GVAR(traces) set[_index, _data];
[DFUNC(trackTrace), 0, [_obj, _index, ACE_time]] call CBA_fnc_addPerFrameHandler;
