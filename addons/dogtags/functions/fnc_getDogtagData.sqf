/*
 * Author: esteldunedain
 * Get unit dogtag data
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_target"];

// Check if the data was already created
private _dogTagData = _target getVariable QGVAR(dogtagData);
if (!isNil "_dogTagData") exitWith {_dogTagData};

// Create dog tag data once for the unit: nickname, code (eg. 135-13-900) and blood type
private _targetName = [_target, false, true] call EFUNC(common,getName);

private _dogTagData = [
    _targetName,
    str(floor random 10) + str(floor random 10) + str(floor random 10) + "-" +
        str(floor random 10) + str(floor random 10) + "-" +
        str(floor random 10) + str(floor random 10) + str(floor random 10),
    _targetName call FUNC(bloodType)
];
// Store it
_target setVariable [QGVAR(dogtagData), _dogTagData, true];
_dogTagData
