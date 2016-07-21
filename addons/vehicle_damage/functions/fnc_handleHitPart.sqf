/*
 * Author: BaerMitUmlaut
 * Disables vanilla damage.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Shooter <OBJECT>
 * 2: Projectile <OBJECT>
 * 3: Hit position (ASL) <ARRAY>
 * 4: Projectile velocity <ARRAY
 * 5: Selections <ARRAY>
 * 6: Ammo info <ARRAY>
 * 7: Surface normal <ARRAY>
 * 8: Radius <NUMBER>
 * 9: Surface type <STRING>
 * 10: Direct hit <BOOL>
 *
 * Return Value:
 * Nothing
 */
#include "script_component.hpp"
(_this select 0) params [
    "_vehicle", "_shooter", "_projectile", "_hitPos", "_projectileVelocity",
    "_selections", "_ammoInfo", "_surfaceNormal", "_radius", "_surfaceType",
    "_directHit"
];
_ammoInfo params [
    "_hitValue", "_indirectHitValue", "_indirectHitRange", "_explosiveDamage",
    ["_ammoClassname", ""]
];

private _nl = toString [13, 10];
private _msg = "";
{
    _msg = _msg + _nl + _x + " = " + str ((_this select 0) select _forEachIndex);
} forEach [
    "_vehicle", "_shooter", "_projectile", "_hitPos", "_projectileVelocity",
    "_selections", "_ammoInfo", "_surfaceNormal", "_radius", "_surfaceType",
    "_directHit"
];
diag_log _msg;

// Let's just ignore explosive damage for now, focus on KE stuff
// This should still be handled later for satchel charges etc,
// probably simply ignore low hit values (grenades etc.)
if (!_directHit) exitWith {};

// PhysX damage? TODO check this
if (isNull _projectile || {_ammoClassname == ""}) exitWith {};

// [hit value, indirect hit value, indirect hit range, explosive damage, ammo class name]
// OR, if there is no shot object: [impulse value on object collided with,0,0,0]
