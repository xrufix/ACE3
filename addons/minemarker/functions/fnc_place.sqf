/*
 * Author: Jonpas
 * Places a mine marker.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Marker Item Type <STRING>
 * 2: Marker Object Type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "ace_minemarker_Item_Flag"] call ace_minemarker_fnc_place
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_player", "_itemType", "_objectType"];

_player removeItem _itemType;

private _pos = (eyePos _player) vectorAdd (positionCameraToWorld [0, 0, 0.6]) vectorDiff (positionCameraToWorld [0, 0, 0]);
private _marker = createVehicle [_objectType, [_pos select 0, _pos select 1, 0], [], 0, "CAN_COLLIDE"];
_marker setDir (getDir _player);

_player reveal _marker;
