/*
 * Author: nou, PabstMirror, esteldunedain
 *
 * This function determines if an ammo should frag
 *
 * Arguments:
 * 0: Ammo <STRING>
 *
 * Return Value:
 * <BOOL>
 *
 *
 * Public: No
 */
// #define DEBUG_ENABLED_FRAG
#include "script_component.hpp"

params ["_ammo"];

private _shouldFrag = GVAR(cacheRoundsTypesToFrag) getVariable _ammo;
if (isNil "_shouldFrag") then {
    //Read configs and test if it would actually cause a frag
    private _ammoCfg = configFile >> "CfgAmmo" >> _ammo;
    private _skip = getNumber (_ammoCfg >> QGVAR(skip));
    private _explosive = getNumber (_ammoCfg >> "explosive");
    private _indirectRange = getNumber (_ammoCfg >> "indirectHitRange");
    private _force = getNumber (_ammoCfg >> QGVAR(force));
    private _fragPower = getNumber(_ammoCfg >> "indirecthit") * (sqrt((getNumber (_ammoCfg >> "indirectHitRange"))));

    _shouldFrag = (_skip == 0) && {(_force == 1) || {_explosive > 0.5 && {_indirectRange >= 4.5} && {_fragPower >= 35}}};
    GVAR(cacheRoundsTypesToFrag) setVariable [_ammo, _shouldFrag];
};
_shouldFrag
