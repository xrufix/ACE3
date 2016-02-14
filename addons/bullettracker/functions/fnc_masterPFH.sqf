/*
 * Author: jaynus, esteldunedain
 *
 * Master single PFH abstraction for all rounds being tracked
 *
 * Arguments:
 *
 *
 * Return Value:
 * None
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

private _iter = 0;
private _numTracks = count GVAR(tracks);
private _maxIter = GVAR(MaxTrackPerFrame) min _numTracks;
while {_iter < _maxIter} do {
    if(GVAR(lastIterationIndex) >= _numTracks) then {
        GVAR(lastIterationIndex) = 0;
        // We are about to start iterating from the begginig. Clean up the
        // elements that were nulled during the last pass
        GVAR(tracks) = GVAR(tracks) - [objNull, objNull];
    };

    private _track = GVAR(tracks) select GVAR(lastIterationIndex);
    _track params ["_projectile", "_namespace"];

    if(!isNil "_projectile" && (alive _projectile)) then {
        private _posASL = getPosASL _projectile
        private _vel = velocity _projectile;
        _namespace setVariable ["pos", _posASL];
        _namespace setVariable ["vel", _vel];
        {
            // The tracker codes don't get parameters for performance reasons,
            // but they get to use the variables existing in this context:
            // _projectile, _namespace, _posASL, _vel
            call _x;
        } forEach _namespace getVariable QGVAR(codes);
    } else {
        // Raise the events, but only if more than one frame has passed since
        // the bullet was created
        if (diag_frameno - (_namespace getVariable QGVAR(createdFrameNo)) > 1) then {
            {
                // The event handlers don't get parameters for performance reason,
                // but they get to use the variables existing in this context:
                // _namespace
                [_x, []] call EFUNC(common,localEvent);
            } forEach _namespace getVariable QGVAR(events);
        };
        _track set [0, objNull];
        _track set [1, objNull];
        [_namespace] call CBA_fnc_deleteNamespace;
    };
    _iter = _iter + 1;
    GVAR(lastIterationIndex) = GVAR(lastIterationIndex) + 1;
};

