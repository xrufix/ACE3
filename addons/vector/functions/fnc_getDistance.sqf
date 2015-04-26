// by commy2
#include "script_component.hpp"

#define MIN_DISTANCE 25
#define MAX_DISTANCE 5500

private ["_dlgVector", "_distance", "_errorCoef"];

disableSerialization;
_dlgVector = GETUVAR(ACE_dlgVector,displayNull);

_distance = ctrlText (_dlgVector displayCtrl 151);

if (_distance == "----") exitWith {-1000};

_distance = parseNumber _distance;

if (_distance * overcast ^ 2 > 2000) exitWith {-1000};
if (_distance * rain ^ 2 > 400) exitWith {-1000};
if (_distance * fog ^ 2 > 80) exitWith {-1000};

// Rangefinder accuracy
_errorCoef = 1.0 + (_distance / MAX_DISTANCE);
_distance = _distance + (1 - random 2) * 5 * _errorCoef ^ 3; // +- 5 m * _errorCoef ^ 3

if (_distance > MAX_DISTANCE) exitWith {-1000};
if (_distance < MIN_DISTANCE) exitWith {-1000};

if (GVAR(useFeet)) then {
    _distance = 3.28084 * _distance;
};

round(_distance)
