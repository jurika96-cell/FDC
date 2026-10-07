/*
    Execute an MTO fire command.
    BELoves: one control/center gun fires one round.
    HATASTUZ: exactly the number of guns entered in the MTO fire,
    each firing the entered rounds-per-gun value.
*/
params [["_mode", "BELOVES", [""]]];

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

private _label = if (toUpper _mode isEqualTo "BELOVES") then {
    "Beloves kiadva: 1 loveg, 1 granat"
} else {
    format ["Hatastuz kiadva: %1 loveg x %2 granat", count _fireSolutions, _rounds]
};
hint _label;
true
