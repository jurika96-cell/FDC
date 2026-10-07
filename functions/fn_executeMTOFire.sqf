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

// If the MTO dialog is still open, use the current field values too. This prevents
// an earlier recorded value from overriding a later edit (e.g. 3 guns changed after recording).
private _display = findDisplay 9400;
if (!isNull _display) then {
    private _currentGuns = floor parseNumber (ctrlText (_display displayCtrl 9412));
    private _currentRounds = floor parseNumber (ctrlText (_display displayCtrl 9413));
    if (_currentGuns > 0) then {
        if (count _mto < 5) then {_mto resize 5;};
        _mto set [2, str _currentGuns];
    };
    if (_currentRounds > 0) then {
        if (count _mto < 5) then {_mto resize 5;};
        _mto set [3, str _currentRounds];
    };
    missionNamespace setVariable ["FDC_MTOData", _mto];
};

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

        // Positive acknowledgement: report when this gun actually expends ammunition,
        // rather than when the fire command is merely issued.
        [_gun, _magazine, _rounds, _mode] spawn {
            params ["_gun", "_magazine", "_expectedRounds", "_mode"];
            private _before = _gun magazineTurretAmmo [_magazine, [0]];
            private _deadline = time + 20;
            waitUntil {
                sleep 0.1;
                !alive _gun || {time > _deadline} || {(_gun magazineTurretAmmo [_magazine, [0]]) < _before}
            };
            if (alive _gun && {(_gun magazineTurretAmmo [_magazine, [0]]) < _before}) then {
                systemChat format ["FDC: %1 TUZELT (%2)", vehicleVarName _gun, toUpper _mode];
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
