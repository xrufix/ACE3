#include "script_component.hpp"

if(!isNil QGVAR(pfh)) then {
    [GVAR(pfh)] call CBA_fnc_removePerFrameHandler;
    
    [] call FUNC(clear);
    
    uiNameSpace setVariable [QGVAR(display), nil];
};