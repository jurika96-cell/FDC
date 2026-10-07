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

{
    _x params ["_gun", "_magazine", "_eta"];
    if (alive _gun && {_magazine isNotEqualTo ""}) then {
        _gun doArtilleryFire [_target, _magazine, _rounds];
    };
} forEach _fireSolutions;

private _label = if (toUpper _mode isEqualTo "BELOVES") then {
    "Beloves kiadva: 1 loveg, 1 granat"
} else {
    format ["Hatastuz kiadva: %1 loveg x %2 granat", count _fireSolutions, _rounds]
};
hint _label;
true
