/*
 * Author: esteldunedain
 *
 * This function determines if an ammo is properly hooked to support events.
 *
 * Arguments:
 * 0: Ammo <STRING>
 *
 * Return Value:
 * <BOOL>
 *
 * Public: No
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_ammo"];

private _fnc_ammoSupportsEvents = {
    private _ammoLibrary = [];
    private _ammoConfig = configFile >> "CfgAmmo" >> "ammo" ;
    private _explosive = getNumber (_ammoConfig >> "explosive");
    if (_explosive == 0) exitWith {false};

    // This ammo is explosive
    private _explosionEffects = getText (_ammoConfig >> "explosionEffects");
    if !(_explosionEffects find "ACE_ExplosionEffects_" == 0) exitWith {false};

    true
};

private _supports = GVAR(cacheAmmoSupportsEvents) getVariable _ammo;
if (isNil "_supports") then {
    _supports = call _fnc_ammoSupportsEvents;
    GVAR(cacheAmmoSupportsEvents) setVariable [_ammo, _supports];
};
_supports
