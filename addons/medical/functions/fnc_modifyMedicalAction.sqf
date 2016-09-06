/*
 * Author: esteldunedain
 * Modify the visuals of a medical action point.
 * On Basic medical: modify the icon color based on damage on that body part.
 *
 * Arguments:
 * 0: The Patient Unit <OBJECT>
 * 1: The Diagnosing Unit <OBJECT>
 * 2: Selection Number <NUMBER>
 * 3: The action to modify <OBJECT>
 *
 * ReturnValue:
 * None
 *
 * Public: No
 */

#include "script_component.hpp"

params ["_target", "_player", "_partNumber", "_actionData"];

private _bloodLossOnSelection = 0;
// Add all bleeding from wounds on selection
{
    _x params ["", "", "_selectionX", "_amountOf", "_percentageOpen"];
    if (_selectionX == _partNumber) then {
        _bloodLossOnSelection = _bloodLossOnSelection + (_amountOf * _percentageOpen);
    };
} forEach (_target getvariable [QGVAR(openWounds), []]);

private _hasTourniquet = ((_target getVariable [QGVAR(tourniquets), [0,0,0,0,0,0]]) select _partNumber) > 0;

switch (true) do {
    case (_bloodLossOnSelection >= 0.15): {
        if (_hasTourniquet) then {
            _actionData set [2, QPATHTOF(UI\icons\medical_crossRed_t.paa)];
        } else {
            _actionData set [2, QPATHTOF(UI\icons\medical_crossRed.paa)];
        };
    };
    case (_bloodLossOnSelection > 0): {
        if (_hasTourniquet) then {
            _actionData set [2, QPATHTOF(UI\icons\medical_crossYellow_t.paa)];
        } else {
            _actionData set [2, QPATHTOF(UI\icons\medical_crossYellow.paa)];
        };
    };
    default {
        if (_hasTourniquet) then {
            _actionData set [2, QPATHTOF(UI\icons\medical_cross_t.paa)];
        };
    };
};
