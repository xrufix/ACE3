/*
 * Author: PabstMirror
 * Tests if a player can assemble their backpack and a backpack in a ground container.
 *
 * Arguments:
 * 0: Target - a ground weapon container <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [mortar, player] call ace_staticWeapons_fnc_doAssemble;
 *
 * Public: No
 */
#include "script_component.hpp"

PARAMS_2(_target,_player);

_player action ["Assemble", (firstBackpack _target)];