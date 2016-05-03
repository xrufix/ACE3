/*
 * Author: Glowbal
 * Apply a tourniquet to the patient
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 * 2: SelectionName <STRING>
 * 3: Treatment classname <STRING>
 *
 *
 * Return Value:
 * Succesful treatment started <BOOL>
 *
 * Public: No
 */

#include "script_component.hpp"
params ["_caller", "_target", "_selectionName", "_className", "_items"];
private ["_part", "_removeItem", "_tourniquets", "_output"];

if (count _items == 0) exitWith {false};

_part = [_selectionName] call FUNC(selectionNameToNumber);
if (_part == 0 || _part == 1) exitWith {
    // ["displayTextStructured", [_caller], ["You cannot apply a CAT on this body part!"]] call EFUNC(common,targetEvent);
    false;
};

_tourniquets = _target getVariable [QGVAR(tourniquets), [0,0,0,0,0,0]];
if ((_tourniquets select _part) > 0) exitWith {
   _output = "There is already a tourniquet on this body part!"; // TODO localization
   ["displayTextStructured", [_caller], [_output, 1.5, _caller]] call EFUNC(common,targetEvent);
    false;
};

_removeItem = _items select 0;
if (local _target) then {
    ["treatmentTourniquetLocal", [_target, _removeItem, _selectionName]] call EFUNC(common,localEvent);
} else {
    ["treatmentTourniquetLocal", _target, [_target, _removeItem, _selectionName]] call EFUNC(common,targetEvent);
};

[_target, _removeItem] call FUNC(addToTriageCard);
[_target, "activity", LSTRING(Activity_appliedTourniquet), [[_caller, false, true] call EFUNC(common,getName)]] call FUNC(addToLog);
[_target, "activity_view", LSTRING(Activity_appliedTourniquet), [[_caller, false, true] call EFUNC(common,getName)]] call FUNC(addToLog); // TODO expand message


true
