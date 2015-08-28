#include "script_component.hpp"
/*
 * Author: joko // Jonas
 * apply a texture to a hiddenselection from a Crate
 *
 * Arguments:
 * 0: Logic <OBJECT>
 * 1: Units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_ladder] call ace_crate_fnc_moduleCrate;
 *
 * Public: No
 */
 private ["_texture", "_selection"];
params ["_logic", "_units", "_activated"]


if !(isServer) exitWith {};
if !(_activated) exitWith {};

_texture = _logic getVariable ["texturePath", ""];
_selection = _logic getVariable ["selection", 0];

{
    _x setObjectTextureGlobal [_selection, _texture];
} forEach _units;
