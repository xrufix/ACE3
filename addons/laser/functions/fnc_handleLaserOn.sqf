//fnc_handleLaserOn.sqf
#include "script_component.hpp"
params ["_uuid", "_args"];
HASH_SET(GVAR(laserEmitters), _uuid, _args);
