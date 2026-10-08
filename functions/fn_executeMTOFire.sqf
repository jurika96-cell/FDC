/*
    Execute an MTO fire command.
    BELoves: one control/center gun fires one round.
    HATASTUZ: exactly the number of guns entered in the MTO fire,
    each firing the entered rounds-per-gun value.
*/
params [["_mode", "BELOVES", [""]]];

private _modeKey = toUpper _mode;
private _cooldownKey = format ["FDC_fireCooldown_%1",_modeKey];
if (diag_tickTime < (missionNamespace getVariable [_cooldownKey,0])) exitWith {false};
private _groupIndex = missionNamespace getVariable ["FDC_MTOSelectedGroup", -1];
private _target = missionNamespace getVariable ["FDC_MTOTargetPosition", []];
private _solutions = missionNamespace getVariable ["FDC_MTOGunSolutions", []];
private _mto = missionNamespace getVariable ["FDC_MTOData", []];


if (_groupIndex < 0 || {count _target < 3} || {count _solutions == 0}) exitWith {
    hint "Nincs ervenyes tuzmegoldas. Elobb rogzitd az MTO-t.";
    false
};

private _requestedGuns = if (count _mto > 2) then {floor parseNumber (_mto select 2)} else {1};
private _roundsPerGun = if (count _mto > 3) then {floor parseNumber (_mto select 3)} else {1};
_requestedGuns = _requestedGuns max 1 min (count _solutions);
_roundsPerGun = _roundsPerGun max 1;

private _fireSolutions = [];
private _rounds = 1;

if (toUpper _mode isEqualTo "BELOVES") then {
    // The first solution is the deterministic control gun for adjustment fire.
    _fireSolutions = [_solutions select 0];
    _rounds = 1;
} else {
    _fireSolutions = _solutions select [0, _requestedGuns];
    _rounds = _roundsPerGun;
};

missionNamespace setVariable ["FDC_expectedFiringGuns", count _fireSolutions];
missionNamespace setVariable [format ["FDC_fired_%1", toUpper _mode], 0];

{
    _x params ["_gun", "_magazine", "_eta"];
    if (alive _gun && {_magazine isNotEqualTo ""}) then {
        // Capture ammunition BEFORE issuing the command so the acknowledgement
        // can detect the first actually fired round.
        private _before = _gun ammo (currentWeapon _gun);
        // Attach before issuing fire: the countdown starts on the actual shot.
        // A fresh handler is installed per fire order and removed after the volley window.
        private _eh = _gun addEventHandler ["Fired", {
            params ["_unit", "_weapon", "_muzzle", "_fireMode", "_ammo", "_firedMagazine", "_projectile"];
            private _watch = _unit getVariable ["FDC_impactWatch", []];
            if (count _watch < 2) exitWith {};
            _watch params ["_expectedMagazine", "_flightTime"];
            if (_firedMagazine isNotEqualTo _expectedMagazine) exitWith {};
            [_flightTime] spawn {
                params ["_flightTime"];
                sleep ((_flightTime - 5) max 0);
                systemChat "FDC: BECSAPODAS - 5 masodperc!";
                hintSilent "BECSAPODAS - 5 masodperc!";
            };
        }];
        _gun setVariable ["FDC_impactWatch", [_magazine, _eta]];
        [_gun, _eh] spawn {
            params ["_gun", "_eh"];
            sleep 120;
            if (!isNull _gun) then {_gun removeEventHandler ["Fired", _eh];};
        };
        _gun doArtilleryFire [_target, _magazine, _rounds];

        [_gun, _mode, _before] spawn {
            params ["_gun", "_mode", "_before"];
            private _deadline = time + 20;
            waitUntil {
                sleep 0.1;
                !alive _gun || {time > _deadline} || {(_gun ammo (currentWeapon _gun)) < _before}
            };
            if (alive _gun && {(_gun ammo (currentWeapon _gun)) < _before}) then {
                private _key = format ["FDC_fired_%1", toUpper _mode];
                private _count = (missionNamespace getVariable [_key, 0]) + 1;
                missionNamespace setVariable [_key, _count];
                systemChat format [
                    "FDC: %1/%2 loveg tuzelt (%3)",
                    _count,
                    missionNamespace getVariable ["FDC_expectedFiringGuns", 1],
                    toUpper _mode
                ];
            };
        };
    };
} forEach _fireSolutions;

// Five-second UI cooldown after a valid fire order, independent of actual gun reload.
private _until = diag_tickTime + 5;
missionNamespace setVariable [_cooldownKey,_until];
disableSerialization;
private _mtoDisplay = findDisplay 9400;
private _buttonIdc = if (_modeKey isEqualTo "BELOVES") then {9422} else {9423};
if (!isNull _mtoDisplay) then {(_mtoDisplay displayCtrl _buttonIdc) ctrlShow false;};
[_buttonIdc,_cooldownKey,_until] spawn {
    params ["_idc","_key","_until"];
    uiSleep 5;
    if (diag_tickTime >= (missionNamespace getVariable [_key,0])) then {
        disableSerialization;
        private _d = findDisplay 9400;
        if (!isNull _d) then {(_d displayCtrl _idc) ctrlShow true;};
    };
};
private _label = if (toUpper _mode isEqualTo "BELOVES") then {
    "Beloves kiadva: 1 loveg, 1 granat"
} else {
    format ["Hatastuz kiadva: %1 loveg x %2 granat", count _fireSolutions, _rounds]
};
hint _label;
true
