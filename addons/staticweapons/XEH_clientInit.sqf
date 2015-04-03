#include "script_component.hpp"

if (!hasInterface) exitWith {};

_assembleAction = [QGVAR(assemble), "Assemble", "", {_this call FUNC(doAssemble)}, {_this call FUNC(canAssemble)}, {}, [], [0,0,0], 3] call EFUNC(interact_menu,createAction);
["GroundWeaponHolder", 0, [], _assembleAction] call EFUNC(interact_menu,addActionToClass);
