/*
 * Author: nou, jaynus, PabstMirror
 * Called from the unified fired EH for all.
 * If spall is not enabled (default), then cache and only track those that will actually trigger fragmentation.
 *
 * Arguments:
 * None. Parameters inherited from EFUNC(common,firedEH)
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [clientFiredBIS-XEH] call ace_frag_fnc_fired
 *
 * Public: No
 */
// #define DEBUG_ENABLED_FRAG
#include "script_component.hpp"

//IGNORE_PRIVATE_WARNING ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle", "_gunner", "_turret"];
TRACE_10("firedEH:",_unit, _weapon, _muzzle, _mode, _ammo, _magazine, _projectile, _vehicle, _gunner, _turret);

// @todo: Review this check in relation to the unified fired EH
private _continue = false;
if (_unit == ACE_player) then {
    _continue = true;
} else {
    if((gunner _unit) == ACE_player) then {
        _continue = true;
    } else {
        if(local _unit && {!(isPlayer (gunner _unit))} && {!(isPlayer _unit)}) then {
            _continue = true;
        };
    };
};
if (!_continue) exitWith {};

if (_projectile in GVAR(blackList)) exitWith {
    GVAR(blackList) = GVAR(blackList) - [_projectile];
};

if ([_ammo] call FUNC(ammoShouldFrag)) then {
    if !([_ammo] call EFUNC(ammoevents,ammoSupportsEvents)) then {
        // If the projectile doesn't support events, track it
        TRACE_3("Running Frag Tracking: ",_unit,_ammo,_projectile);
        private _namespace = [_projectile, "bulletDestroyedFrag", nil] call EFUNC(bullettracker,addTrack);
        _namespace setVariable [QGVAR(type), _type];
        _namespace setVariable [QGVAR(unit), _unit];
    } else {
        TRACE_3("Running Frag through events: ",_unit,_ammo,_projectile);
    };
};

// @todo: check what calibers should spall on the first place
if (GVAR(SpallEnabled)) then {
    if(GVAR(spallIsTrackingCount) > 5) exitWith {};
    GVAR(spallIsTrackingCount) = GVAR(spallIsTrackingCount) + 1;

    TRACE_3("Running Spall Tracking: ",_unit,_ammo,_projectile);
    private _namespace = [_projectile, "bulletDestroyedSpall", DFUNC(spallTrack)] call EFUNC(bullettracker,addTrack);
    _namespace setVariable [QGVAR(type), _type];

};

if (GVAR(autoTrace)) then {
    // @todo: tracing
    //[ACE_player, _round, [1,0,0,1]] call FUNC(addTrack);
};
