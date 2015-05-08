#include "script_component.hpp"

if(!isNil QGVAR(pfh)) then {
    uiNameSpace setVariable [QGVAR(display),_this select 0];
    GVAR(pfh) = [FUNC(onDrawPFH), 0, []] call CBA_fnc_addPerFrameHandler;
};