/*
 * Author: BaerMitUmlaut
 * Disables vanilla damage.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1-4: Stuff <ANYTHING>
 * 5: Hit part index <NUMBER>
 *
 * Return Value:
 * Damage <NUMBER>
 */
#include "script_component.hpp"
params ["_vehicle", "", "", "", "", "_hitPartIndex"];

_vehicle getHitIndex _hitPartIndex
