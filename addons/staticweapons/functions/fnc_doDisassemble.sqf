/*
 * Author: PabstMirror
 * Disassembles a static weapon, using native arma actions.
 *
 * Arguments:
 * 0: Target - a static weapon <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [mortar, player] call ace_staticWeapons_fnc_doDisassemble;
 *
 * Public: No
 */
#include "script_component.hpp"

PARAMS_2(_target,_player);

_player action ["Disassemble", _target];
