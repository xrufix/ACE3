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

systemChat format ["canAss - %1", time];

if (!([_player, _target, []] call EFUNC(common,canInteractWith))) exitWith {false};

//Get player backpack object:
if ((backpack _player) == "") exitWith {false};
_playerBackpack = unitBackpack _player;

//Get container backpack object:
_containerBackpack = firstBackpack _target;
if ((isNull _containerBackpack) || {!(_containerBackpack isKindOf "Bag_Base")}) exitWith {false};

//Either the player or ground backpack should have an assembleTo string
_assembleTo = getText (configfile >> "CfgVehicles" >> (typeOf _playerBackpack) >> "assembleInfo" >> "assembleTo");

if (_assembleTo == "") then {
    _assembleTo = getText (configfile >> "CfgVehicles" >> (typeOf _containerBackpack) >> "assembleInfo" >> "assembleTo");
};

if (_assembleTo == "") exitwith {false};

_assemblyArray = getArray (configfile >> "CfgVehicles" >> _assembleTo >> "assembleInfo" >> "dissasembleTo");

((typeOf _playerBackpack) in _assemblyArray) && {(typeOf _containerBackpack) in _assemblyArray}
