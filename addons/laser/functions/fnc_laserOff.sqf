/*
 * Author: Nou
 * Turn a laser designator off.
 *
 * Arguments:
 * 0: UUID (from laserOn) <string>
 *
 * Return value:
 * None
 */

#include "script_component.hpp"
params ["_uuid"];
["laser_laserOff", [_uuid]] call EFUNC(common,globalEvent);
