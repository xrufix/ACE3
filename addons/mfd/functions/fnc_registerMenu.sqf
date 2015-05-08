/*
 * Author: jaynus
 * Registers a menu type with the MFD
 *
 * Arguments:
 * 0: Menu Name <string> REQUIRED
 * 1: [ isAvailable, isInList ] [ <code>, <code> ] REQUIRED
 * 2: [ onEnter, onLeave, onButtonPress, onDraw ] [ <code>, <code>, <code>, <code>] REQUIRED
 * 3: Arguments <array> OPTIONAL
 * 4: SortPriority [0-999] OPTIONAL 
 * 
 * Return Value:
 * true if successful
 *
 * Example:
 * ["Balls", [ {true}, {true} ], [ {true}, {true}, {true}, {true} ], ["My balls itch"] ] call EFUNC(mfd,registerMenu);
 *
 * Public: No
 */
#include "script_component.hpp"
PARAMS_5(_menuName,_conditions,_callbacks,_args,_priority);

if(HASH_HASKEY(GVAR(menus),_name)) exitWith {
    diag_log text format["[ACE] - %1 Error: Menu name already exists", ADDON];
    false
};

// Verify all the arguments
{ if( !isNil "_x" && { (typeName _x) != "CODE"} ) exitWith {  false }; } forEach _conditions;
{ if( !isNil "_x" && { (typeName _x) != "CODE"} ) exitWith {  false }; } forEach _callbacks;

// Re-sort the priority list
[] call FUNC(sortMenuPriorityList);

HASH_SET(_menuName, _this);

true