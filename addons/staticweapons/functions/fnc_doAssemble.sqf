/*
 * Author: PabstMirror
 *
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 *
 *
 * Example:
 *
 *
 * Public: No
 */
#include "script_component.hpp"

PARAMS_2(_target,_player);

_player action ["Assemble", (firstBackpack _target)];