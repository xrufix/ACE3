/*
 * Author: esteldunedain, nou, jaynus
 * Handle a bullet that was destroyed and should frag.
 *
 * Arguments:
 * None. Parameters inherited from EFUNC(bullettracker,masterPFH)
 *
 * Return Value:
 * Nothing
 *
 * Public: No
 */
#include "script_component.hpp"

//IGNORE_PRIVATE_WARNING ["_namespace"];
TRACE_1("bulletDestroyedFragEH:",_namespace);

private _type = _namespace getVariable QGVAR(type);

private _arg = [_namespace getVariable QEGVAR(bullettracker,pos),
                _namespace getVariable QEGVAR(bullettracker,vel),
                _type,
                _namespace getVariable QGVAR(unit)];

[QGVAR(frag_eh), _arg] call EFUNC(common,serverEvent);
