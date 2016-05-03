//fnc_handleLaserOff.sqf
#include "script_component.hpp"

params ["_uuid"];
if(HASH_HASKEY(GVAR(laserEmitters), _uuid)) then {
    HASH_REM(GVAR(laserEmitters), _uuid);
};
