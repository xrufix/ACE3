/*
 * Author: esteldunedain
 *
 * Add a bullet to track. If different modules want to track the same bullet
 * the fnc_addTrack needs to be called consecutively. This is alright as
 * typically tracks are added from fired event handlers.
 *
 * Arguments:
 * 0: Projectile object <OBJECT>
 * 1: Event name to raise on destruction <STRING> or <NIL>
 * 2: Code to run on each step <CODE> or <NIL>
 *
 * Return Value:
 * Bullet Namespace to store parameters in. objNull if the bullet won't be
 * tracked.
 */
#include "script_component.hpp"

params ["_projectile", "_eventName", "_code"];

// If the bullet already is been tracked, only add tracker code if any is
// specified
if (_projectile isEqualTo (GVAR(lastAddedTrack) select 0)) exitWith {
    GVAR(lastAddedTrack) params ["", "_namespace"];
    if (!isNil "_code") then {
        private _codes = _namespace getVariable QGVAR(codes);
        _codes pushBack _code;
    };
    if (!isNil "_eventName") then {
        private _events = _namespace getVariable QGVAR(events);
        _events pushBack _eventName;
    };
    _namespace
};

// Otherwise, add the tracker from scratch

// CBA_fnc_createNamespace is fast (0.02ms)
private _namespace = call CBA_fnc_createNamespace;
private _codes = [];
private _events = [];
if (!isNil "_code") then {
    _codes pushBack _code;
};
if (!isNil "_eventName") then {
    _events pushBack _eventName;
};
_namespace setVariable [QGVAR(codes), _codes];
_namespace setVariable [QGVAR(events), _events];
_namespace setVariable [QGVAR(createdFrameNo), diag_frameno];
_namespace setVariable ["pos", getPosASL _projectile];
_namespace setVariable ["vel", velocity _projectile];

private _track = [_projectile, _namespace];
GVAR(lastAddedTrack) = _track;
GVAR(tracks) pushBack _track;
_namespace
