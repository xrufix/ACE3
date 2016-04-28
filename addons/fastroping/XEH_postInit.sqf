#include "script_component.hpp"

[QGVAR(deployRopes), {
    _this call FUNC(deployRopes);
}] call EFUNC(common,addEventHandler);

[QGVAR(startFastRope), {
    [FUNC(fastRopeServerPFH), 0, _this] call CBA_fnc_addPerFrameHandler;
}] call EFUNC(common,addEventHandler);

[QGVAR(debugMessage), {
    params ["_player", "_message"];
    _player sideChat _message;
}] call EFUNC(common,addEventHandler);
