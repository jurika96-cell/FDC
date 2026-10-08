disableSerialization;
params [["_display", displayNull, [displayNull]]];
if (isNull _display) exitWith {false};

private _azMils = parseNumber ctrlText (_display displayCtrl 9510);
private _lateral = abs parseNumber ctrlText (_display displayCtrl 9512);
private _range = abs parseNumber ctrlText (_display displayCtrl 9514);
private _lr = (_display displayCtrl 9511) lbText (lbCurSel (_display displayCtrl 9511));
private _nf = (_display displayCtrl 9513) lbText (lbCurSel (_display displayCtrl 9513));

if (_azMils < 0 || {_azMils >= 6400}) exitWith {hint "A figyelovonal iranyszoge 0000-6399 mils legyen."; false};

// Always start from the last corrected point, including consecutive adjustments.
private _base = missionNamespace getVariable ["FDC_adjustedTargetPosition", []];
if (count _base < 3) then {_base = missionNamespace getVariable ["FDC_MTOTargetPosition", []];};
if (count _base < 3) then {_base = call FDC_fnc_resolveTargetPosition;};
if (count _base < 3) exitWith {hint "Nincs ervenyes celpont."; false};

private _az = (_azMils / 6400) * 360;
private _new = +_base;

// Tavolabb/kozelebb is ALWAYS along the observer-target line.
if (_range > 0) then {
    private _bearing = if (_nf isEqualTo "Tavolabb") then {_az} else {_az + 180};
    _new = _new getPos [_range, _bearing];
};
// Jobbra/balra is perpendicular to the observer-target line.
if (_lateral > 0) then {
    private _bearing = if (_lr isEqualTo "Jobbra") then {_az + 90} else {_az - 90};
    _new = _new getPos [_lateral, _bearing];
};
_new set [2, _base select 2];

missionNamespace setVariable ["FDC_adjustmentObserverAzimuth", _azMils];
missionNamespace setVariable ["FDC_adjustedTargetPosition", _new];
missionNamespace setVariable ["FDC_MTOTargetPosition", _new];

// Recalculate valid gun solutions/TOF against the corrected target on the existing MTO.
private _mto = findDisplay 9400;
if (!isNull _mto) then {[_mto] call FDC_fnc_updateMTO;};
closeDialog 0;
hint "Javitas rogzitve. Uj tuzmegoldas kiszamitva.";
true
