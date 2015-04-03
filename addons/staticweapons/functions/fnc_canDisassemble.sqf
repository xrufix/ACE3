/*
 * Author: PabstMirror
 * Tests if a player can disassemble a static weapon.
 *
 * Arguments:
 * 0: Target - a static weapon <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [mortar, player] call ace_staticWeapons_fnc_canDisAssemble;
 *
 * Public: No
 */
#include "script_component.hpp"

PARAMS_2(_target,_player);

if (!([_player, _target, []] call EFUNC(common,canInteractWith))) exitWith {false};
if ((count (crew _target)) != 0) exitWith {false};

_cfgPath =  configfile >> "CfgVehicles" >> (typeOf _target) >> "assembleInfo" >> "dissasembleTo";

(isArray _cfgPath) && {(count (getArray _cfgPath)) > 0}
