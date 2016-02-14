#include "script_component.hpp"

GVAR(lastIterationIndex) = 0;
GVAR(tracks) = [];
GVAR(lastAddedTrack) = [objNull, objNull];

[FUNC(masterPFH), 0, []] call CBA_fnc_addPerFrameHandler;
