disableSerialization;
params [["_display", displayNull, [displayNull]]];
if (isNull _display) exitWith {false};
private _combo = _display displayCtrl 9210;
private _values = [];
{ _values pushBack ctrlText (_display displayCtrl _x); } forEach [9230,9231,9232,9233,9234,9235];
missionNamespace setVariable ["FDC_locationMode", _combo lbText (lbCurSel _combo)];
missionNamespace setVariable ["FDC_locationValues", _values];
private _number = toUpper (ctrlText (_display displayCtrl 9250));
private _chars = toArray _number;
private _valid = (count _chars == 6);
if (_valid) then {
    for "_i" from 0 to 5 do {
        private _n = _chars select _i;
        if (_i < 2) then {if (_n < 65 || {_n > 90}) then {_valid = false;};}
        else {if (_n < 48 || {_n > 57}) then {_valid = false;};};
    };
};
if (_number isNotEqualTo "" && {!_valid}) exitWith {hint "Celszam formatum: QB1001"; false};
missionNamespace setVariable ["FDC_targetNumber",_number];
// A newly saved second transmission starts a fresh target solution.
missionNamespace setVariable ["FDC_adjustedTargetPosition", []];

if ((missionNamespace getVariable ["FDC_missionType", ""]) isEqualTo "Tuzathelyezes ismert pontrol") then {
    private _lr = _display displayCtrl 9240;
    private _nf = _display displayCtrl 9241;
    missionNamespace setVariable ["FDC_shiftDirections", [
        _lr lbText (lbCurSel _lr),
        _nf lbText (lbCurSel _nf)
    ]];
};

// Saving must not initialize another display. Its own onLoad handles that.
diag_log format ["[FDC FIX 20261006-B] saveCoordinate mission=%1 values=%2", missionNamespace getVariable ["FDC_missionType", "<unset>"], _values];
true
