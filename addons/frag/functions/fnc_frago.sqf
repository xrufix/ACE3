//fnc_frago.sqf
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

#define FRAG_VEC_VAR 0.004

#define MAX_FRAG_COUNT 50

if(!isServer) exitWith { };

BEGIN_COUNTER(frago);

params ["_shellType", "_lastPos", ["_gun", nil]];

private ["_i", "_target"];

private _fragTypes = [
            "ACE_frag_tiny", "ACE_frag_tiny", "ACE_frag_tiny",
            "ACE_frag_tiny_HD", "ACE_frag_tiny_HD", "ACE_frag_tiny_HD",
            "ACE_frag_small","ACE_frag_small","ACE_frag_small","ACE_frag_small",
            "ACE_frag_small_HD","ACE_frag_small_HD","ACE_frag_small_HD","ACE_frag_small_HD",
            "ACE_frag_medium_HD", "ACE_frag_medium_HD", "ACE_frag_medium_HD", "ACE_frag_medium_HD", "ACE_frag_medium_HD"
        ];

private _warn = false;
if(isArray (configFile >> "CfgAmmo" >> _shellType >> "ACE_frag_CLASSES")) then {
    _fragTypes = getArray (configFile >> "CfgAmmo" >> _shellType >> "ACE_frag_CLASSES");
} else {
    _warn = true;
};

private _posAGL = ASLtoAGL _lastPos;

private _isArmed = true;
if(!isNil "_gun") then {
    private _fuseDist = getNumber(configFile >> "CfgAmmo" >> _shellType >> "fuseDistance");
    _isArmed = ((getPosASL _gun) distance _lastPos > _fuseDist);
};

private _indirectHitRange = getNumber(configFile >> "CfgAmmo" >> _shellType >> "indirecthitrange");
private _fragRange = 20*_indirectHitRange*4;
// _c = 185; // grams of comp-b
// _m = 210; // grams of fragmentating metal
// _k = 3/5; // spherical K factor
// _gC = 2843; // Gurney constant of comp-b in /ms

// _c = 429; // grams of tritonal
// _m = 496; // grams of fragmentating metal
// _k = 1/2; // spherical K factor
// _gC = 2320; // Gurney constant of tritonal in /ms


private _c = getNumber(configFile >> "CfgAmmo" >> _shellType >> "ACE_frag_CHARGE");
if(_c == 0) then { _c = 1; _warn = true;};
private _m = getNumber(configFile >> "CfgAmmo" >> _shellType >> "ACE_frag_METAL");
if(_m == 0) then { _m = 2; _warn = true;};
private _k = getNumber(configFile >> "CfgAmmo" >> _shellType >> "ACE_frag_GURNEY_K");
if(_k == 0) then { _k = 1/2; _warn = true;};
private _gC = getNumber(configFile >> "CfgAmmo" >> _shellType >> "ACE_frag_GURNEY_C");
if(_gC == 0) then { _gC = 2440; _warn = true;};

if(_warn) then {
    ACE_LOGWARNING_1("Ammo class %1 lacks proper explosive properties definitions for frag!",_shellType); //TODO: turn this off when we get closer to release
};

private _fragPower = (((_m/_c)+_k)^-(1/2))*_gC;
_fragPower = _fragPower*0.8; // Gunery equation is for a non-fragmenting metal, imperical value of 80% represents fragmentation

private _fragPowerRandom = _fragPower*0.5;
if((_posAGL select 2) < 0.5) then {
    _lastPos set[2, (_lastPos select 2)+0.5];
};

private _objects = _posAGL nearEntities [["Car", "Motorcycle", "Tank", "StaticWeapon", "CAManBase", "Air", "Ship"], _fragRange];

// Target also people inside vehicles or manning weapons
private _crew = [];
{
    {
        _crew set [count _crew,_x]
    } forEach (crew _x);
} forEach _objects;

_objects = _objects - _crew;
_objects = _objects + _crew;

private _fragCount = 0;

private _fragArcs = [];
_fragArcs set[360, 0];

#ifdef DEBUG_MODE_FULL
    ACE_player sideChat format["_fragRange: %1", _fragRange];
    ACE_player sideChat format["_objects: %1", _objects];
#endif
private _doRandom = true;
if(_isArmed && (count _objects) > 0) then {
    if (GVAR(ReflectionsEnabled)) then {
        [_lastPos, _shellType] call FUNC(doReflections);
    };
    {
        //if(random(1) > 0.5) then {
            private _target = _x;
            if(alive _target) then {
                private _boundingBox = boundingBox _target;
                private _targetPos = (getPosASL _target);
                private _distance = _targetPos distance _lastPos;
                private _add = (((_boundingBox select 1) select 2)/2)+((((_distance-(_fragpower/8)) max 0)/_fragPower)*10);
                private _bbX = (abs((_boundingBox select 0) select 0))+((_boundingBox select 1) select 0);
                private _bbY = (abs((_boundingBox select 0) select 1))+((_boundingBox select 1) select 1);
                private _bbZ = (abs((_boundingBox select 0) select 2))+((_boundingBox select 1) select 2);
                private _cubic = _bbX*_bbY*_bbZ;
                if(_cubic > 1) then {
                    _doRandom = true;

                    private _targetVel = (velocity _target);


                    _targetPos set[0, (_targetPos select 0)+((_targetVel select 0)*(_distance/_fragPower))];
                    _targetPos set[1, (_targetPos select 1)+((_targetVel select 1)*(_distance/_fragPower))];
                    _targetPos set[2, (_targetPos select 2)+_add];

                    private _baseVec = _lastPos vectorFromTo _targetPos;

                    private _dir = floor(_baseVec call CBA_fnc_vectDir);
                    private _currentCount = _fragArcs select _dir;
                    if(isNil "_currentCount") then {
                        _currentCount = 0;
                    };
                    if(_currentCount < 20) then {
                        private _count = ceil(random(sqrt(_m/1000)));
                        private _vecVar = FRAG_VEC_VAR;
                        if(!(_target isKindOf "Man")) then {
                            _vecVar = ((sqrt _cubic)/2000)+FRAG_VEC_VAR;
                            if((count (crew _target)) == 0 && _count > 0) then {
                                _count = 0 max (_count/2);
                            };
                        };
                        for "_i" from 1 to _count do {
                            private _vec = +_baseVec;

                            _vec set[0, (_vec select 0)-(_vecVar/2)+(random _vecVar)];
                            _vec set[1, (_vec select 1)-(_vecVar/2)+(random _vecVar)];
                            _vec set[2, (_vec select 2)-(_vecVar/2)+(random _vecVar)];

                            private _fp = (_fragPower-(random (_fragPowerRandom)));
                            private _vel = _vec vectorMultiply _fp;

                            private _fragType = round (random ((count _fragTypes)-1));
                            private _fragObj = (_fragTypes select _fragType) createVehicleLocal [0,0,10000];
                            // diag_log text format["fp: %1 %2", _fp, typeOf _fragObj];
                            _fragObj setPosASL _lastPos;
                            _fragObj setVectorDir _vec;
                            _fragObj setVelocity _vel;
                            if(GVAR(traceFrags)) then {
                                GVAR(TOTALFRAGS) = GVAR(TOTALFRAGS) + 1;
                                [ACE_player, _fragObj, [1,0,0,1]] call FUNC(addTrack);
                            };
                            _fragCount = _fragCount + 1;
                            _currentCount = _currentCount + 1;
                        };
                        _fragArcs set[_dir, _currentCount];
                    };
                };
            };
        //};
        if(_fragCount > MAX_FRAG_COUNT) exitWith {};
    } forEach _objects;
    if(_fragCount > MAX_FRAG_COUNT) exitWith {};
    private _randomCount = ((ceil((MAX_FRAG_COUNT-_fragCount)*0.1)) max 0)+20;
    private _sectorSize = 360 / (_randomCount max 1);
    // _doRandom = false;
    if(_doRandom) then {
        for "_i" from 1 to _randomCount do {
            // Distribute evenly
            private _sectorOffset = 360 * (_i - 1) / (_randomCount max 1);
            private _randomDir = random(_sectorSize);
            private _vec = [cos(_sectorOffset + _randomDir), sin(_sectorOffset + _randomDir), sin(30 - (random 45))];

            private _fp = (_fragPower-(random (_fragPowerRandom)));

            private _vel = _vec vectorMultiply _fp;

            private _fragType = round (random ((count _fragTypes)-1));
            private _fragObj = (_fragTypes select _fragType) createVehicleLocal [0,0,10000];
            _fragObj setPosASL _lastPos;
            _fragObj setVectorDir _vec;
            _fragObj setVelocity _vel;

            if(GVAR(traceFrags)) then {
                GVAR(TOTALFRAGS) = GVAR(TOTALFRAGS) + 1;
                [ACE_player, _fragObj, [1,0.5,0,1]] call FUNC(addTrack);
            };
            _fragCount = _fragCount + 1;
        };
    };

};
// #ifdef DEBUG_MODE_FULL
    // ACE_player sideChat format["total frags: %1", GVAR(TOTALFRAGS)];
    // ACE_player sideChat format["tracks: %1", (count GVAR(trackedObjects))];
// #endif
END_COUNTER(frago);
