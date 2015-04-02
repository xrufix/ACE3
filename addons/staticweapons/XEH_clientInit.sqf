#include "script_component.hpp"

if (!hasInterface) exitWith {};
[] spawn {sleep 1;
    _assembleAction = [QGVAR(assemble), "assemble", "", {_this call FUNC(doAssemble)}, {_this call FUNC(canAssemble)}, {}, [], [0,0,0], 3] call EFUNC(interact_menu,createAction);
    ["GroundWeaponHolder", 0, [], _assembleAction] call EFUNC(interact_menu,addActionToClass);
};