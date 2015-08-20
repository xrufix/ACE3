/*
 * Author: joko // Jonas
 * Drop Gear if player get in a Vehicle with a to Large Weapon/a Backpack
 *
 * Arguments:
 *
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[_unit, Weapon]] call ace_vehicles_fnc_dropGear
 *
 * Public: No
 */
#include "script_component.hpp"

if (GVAR(ProgressIsRunning)) exitWith {};

private ["_fnc_dropCondition", "_fnc_dropFail", "_fnc_dropFinish"];

_fnc_dropCondition = {
    params ["_unit"];
    GVAR(ProgressIsRunning) = true;
    _unit != vehicle _unit
};
_fnc_dropFail = {
    params ["_unit"];
    _unit action ["getOut", vehicle _unit];
    GVAR(ProgressIsRunning) = false;
};
_fnc_dropFinish = {
    {
        private "_event";
        params ["_unit", "_item", "_kindOf"];
        _event = switch _kindOf do {
            case 0: {QGVAR(dropWeapon)};
            case 1: {QGVAR(dropBackpack)};
            default {""};
        };
        if (_event == "") exitWith {};
        [_event, [_unit, _item]] call EFUNC(common,localEvent);
    } count _this;
    GVAR(ProgressIsRunning) = false;
};

GVAR(ProgressIsRunning) = true;

[10, _this, _fnc_dropFinish, _fnc_dropFail, "GetInVehicle", _fnc_dropCondition] call ace_common_fnc_progressBar
