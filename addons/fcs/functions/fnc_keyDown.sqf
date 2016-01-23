/*
 * Author: KoffeinFlummi
 * Starts watching the target for sideways correction.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Turret <ARRAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_vehicle", "_turret"];

private _turretConfig = [configFile >> "CfgVehicles" >> typeOf _vehicle, _turret] call EFUNC(common,getTurretConfigPath);

// Update display for infantry rangefinders
if (_vehicle == ACE_player) exitWith {[5,5500,25,true] call FUNC(getRange)};

private _distance = [
    getNumber (_turretConfig >> QGVAR(DistanceInterval)),
    getNumber (_turretConfig >> QGVAR(MaxDistance)),
    getNumber (_turretConfig >> QGVAR(MinDistance))
] call FUNC(getRange);

if !(!GVAR(enabled) && FUNC(canUseFCS)) exitWith {};

GVAR(Enabled) = true;
GVAR(time) = ACE_time;

private _weaponDirection = _vehicle weaponDirection (_vehicle currentWeaponTurret _turret);
if (_turret isEqualTo ([_vehicle] call EFUNC(common,getTurretCommander))) then {
    _weaponDirection = eyeDirection _vehicle;
};
if (_weaponDirection isEqualTo [0,0,0]) then {  // dummy value for non main turrets
    _weaponDirection = [1,0,0];
};

GVAR(Position) = (getPosASL _vehicle) vectorAdd (_weaponDirection vectorMultiply _distance);

_weaponDirection = (_weaponDirection select 0) atan2 (_weaponDirection select 1);
_weaponDirection = if (_weaponDirection < 0) then {_weaponDirection + 360} else {_weaponDirection};
GVAR(weapDir) = _weaponDirection;

// estimate time to target
// TODO: Cache this stuff
private _magazine       = _vehicle currentMagazineTurret _turret;
private _ammo           = getText   (configFile >> "CfgMagazines" >> _magazine >> "ammo");
private _initSpeed      = getNumber (configFile >> "CfgMagazines" >> _magazine >> "initSpeed");
private _airFriction    = getNumber (configFile >> "CfgAmmo" >> _ammo >> "airFriction");
private _timeToLive     = getNumber (configFile >> "CfgAmmo" >> _ammo >> "timeToLive");
private _simulationStep = getNumber (configFile >> "CfgAmmo" >> _ammo >> "simulationStep");
private _initSpeedCoef  = getNumber (configFile >> "CfgWeapons" >> _weapon >> "initSpeed");
private _simulationType = getText (configFile >> "CfgAmmo" >> _ammo >> "simulation");

if (_simulationType == "shotBullet") then {
    if (_initSpeedCoef < 0) then {
        _initSpeed = _initSpeed * - _initSpeedCoef;
    };

    if (_initSpeedCoef > 0) then {
        _initSpeed = _initSpeedCoef;
    };
};

private _timeToTarget = 0;

if (_simulationStep != 0) then {
    private _posX = 0;
    private _velocityX = _initSpeed;
    private _velocityY = 0;

    for "_i" from 1 to (floor (_timeToLive / _simulationStep) + 1) do {
        _posX = _posX + _velocityX * _simulationStep;

        if (_posX >= _distance) exitWith { // bullet passed the target
            _timeToTarget = _i * _simulationStep;
        };

        private _velocityMagnitude = sqrt (_velocityX ^ 2 + _velocityY ^ 2);

        _velocityX = _velocityX + _velocityX * _velocityMagnitude * _airFriction * _simulationStep;
        _velocityY = _velocityY + _velocityY * _velocityMagnitude * _airFriction * _simulationStep - 9.81 * _simulationStep;
    };
};

// TODO: Find new solution for vertical target angle
[_vehicle,_turret,_distance,0] call FUNC(calculateSolution);

GVAR(PFH) = [{
    (_this select 0) params ["_vehicle","_turret","_distance","_timeToTarget"];

    // TODO: Simplify and readd commander turret workaround
    private _weapDir = _vehicle weaponDirection (_vehicle currentWeaponTurret _turret);
    _weapDir = (_weapDir select 0) atan2 (_weapDir select 1);
    _weapDir = if (_weapDir < 0) then {_weapDir + 360} else {_weapDir};

    private _dWeapDir = DIFFANGLE(GVAR(weapDir),_weapDir);

    private _targetSpeed = _dWeapDir * _distance * FCS_INTERVAL;
    GVAR(speedARR) deleteAt 0;
    GVAR(speedARR) pushBack _targetSpeed;
    private _s = 0;
    {
        _s = _s + _x;
    } forEach GVAR(speedARR);
    private _targetSpeedAvg = _s / count GVAR(speedARR);

    private _fcsAngle = (_targetSpeedAvg * _timeToTarget) atan2 _distance;
    [_vehicle, format ["%1_%2", QGVAR(Azimuth), _turret], _fcsAngle] call EFUNC(common,setVariablePublic);

    if ((diag_tickTime mod 1) < 0.1) then {
        player sideChat format ["dA=%1; TS=%2; T=%3; OA=%3",_dWeapDir,_targetSpeedAvg,_fcsAngle];
    };

    GVAR(weapDir) = _weapDir;

}, FCS_INTERVAL, [_vehicle,_turret,_distance,_timeToTarget]] call CBA_fnc_addPerframeHandler;
