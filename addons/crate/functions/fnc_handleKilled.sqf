#include "script_component.hpp"
/*
 * Author: joko // Jonas
 * Handle that crate get deleted and not glitch throu the map
 *
 * Arguments:
 * 0: Unit
 *
 * Return Value:
 * None
 *
 * Example:
 * [_killedObj] call ace_crate_fnc_handleKilled;
 *
 * Public: No
 */
[{
    (_this select 0) deleteVehicle;
}, 5, _this] call EFUNC(common,waitAndExecute)
