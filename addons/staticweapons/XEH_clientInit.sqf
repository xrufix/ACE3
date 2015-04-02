#include "script_component.hpp"

if (!hasInterface) exitWith {};
[] spawn {sleep 1;
    ["GroundWeaponHolder", 0, [], _assembleAction] call EFUNC(interact_menu,addActionToClass);
};
