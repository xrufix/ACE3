//fnc_doReflections.sqf
#include "script_component.hpp"
params ["_pos", "_ammo", ["_depth", 1]];
private ["_depth", "_indirectHitRange", "_indirectHit", "_testParams"];

// TEST_ICONS pushBack [_pos, format["EXP!", _hit, _range, _hitFactor]];
if(_depth <= 2) then {
    _indirectHitRange = getNumber(configFile >> "CfgAmmo" >> _ammo >> "indirectHitRange");
    _indirectHit = getNumber(configFile >> "CfgAmmo" >> _ammo >> "indirectHit");
    _testParams = [_pos, [_indirectHitRange, _indirectHit], [], [], -4, _depth, 0];
    [DFUNC(findReflections), 0, _testParams] call CBA_fnc_addPerFrameHandler;
};
