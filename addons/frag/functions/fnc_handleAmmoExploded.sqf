/*
 * Author: esteldunedain
 *
 * Handle an explosion, decide if frags should be produced. Only runs on the
 * server
 *
 * Arguments:
 * 0: Ammo <STRING>
 * 1: PositionAGL <ARRAY>
 *
 * Return Value:
 * None
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_ammo","_posAGL"];

if !([_ammo] call FUNC(ammoShouldFrag)) exitWith {};

[QGVAR(frag_eh), [_ammo, AGLtoASL _posAGL]] call EFUNC(common,localEvent);
