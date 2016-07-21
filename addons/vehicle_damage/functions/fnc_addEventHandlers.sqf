/*
 * Author: BaerMitUmlaut
 * Adds event handlers to vehicles.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Nothing
 */
#include "script_component.hpp"
params ["_vehicle"];

_vehicle addEventHandler ["HandleDamage", FUNC(handleDamage)];
_vehicle addEventHandler ["HitPart", FUNC(handleHitPart)];
