/*
 * Author: PabstMirror
 *
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 *
 *
 * Example:
 *
 *
 * Public: No
 */
#include "script_component.hpp"

PARAMS_2(_target,_player);

if (!([_player, _target, []] call EFUNC(common,canInteractWith))) exitWith {false};

// systemChat format ["canDis - %1", time];

_cfgPath =  configfile >> "CfgVehicles" >> (typeOf _target) >> "assembleInfo" >> "dissasembleTo";

(isArray _cfgPath) && {(count (getArray _cfgPath)) > 0}