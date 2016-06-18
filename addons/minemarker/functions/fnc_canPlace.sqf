/*
 * Author: Jonpas
 * Check if the a mine marker can be placed.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Marker Item Type <STRING>
 *
 * Return Value:
 * Can Be Placed <BOOL>
 *
 * Example:
 * [player, "ace_minemarker_Item_Flag"] call ace_minemarker_fnc_canPlace
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_player", "_itemType"];

_itemType in (items _player)
