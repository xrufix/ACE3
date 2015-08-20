// by esteldunedain
#include "script_component.hpp"

if !(hasInterface) exitWith {};

// Add keybinds
["ACE3 Vehicles", QGVAR(speedLimiter), localize LSTRING(SpeedLimiter),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, ["isnotinside"]] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if !(ACE_player == driver vehicle ACE_player &&
    {vehicle ACE_player isKindOf 'Car' ||
        {vehicle ACE_player isKindOf 'Tank'}}) exitWith {false};

    // Statement
    [ACE_player, vehicle ACE_player] call FUNC(speedLimiter);
    true
},
{false},
[211, [false, false, false]], false] call cba_fnc_addKeybind; //DELETE Key


["playerVehicleChanged", {[0, _this] call FUNC(playerChangePositionInVehicle)}] call EFUNC(common,addEventhandler);
["playerTurretChanged", {[1, _this] call FUNC(playerChangePositionInVehicle)}] call EFUNC(common,addEventhandler);


[QGVAR(dropBackpack), {
    params ["_unit", "_item"];
    _unit action ["DropBag", _item];
}] call EFUNC(common,addEventhandler);

[QGVAR(dropWeapon), {
    params ["_unit", "_weapon"];
    _unit action ["DropWeapon", _item];
}] call EFUNC(common,addEventhandler);

GVAR(ProgressIsRunning) = false;
