disableSerialization;
params [["_display", displayNull, [displayNull]]];
if (isNull _display) exitWith { diag_log "[FDC FIX 20261006-B] initCoordinate: missing display"; };

private _combo = _display displayCtrl 9210;
private _missionType = missionNamespace getVariable ["FDC_missionType", "Beloves"];
lbClear _combo;
private _mode = switch (_missionType) do {
    case "Beloves polarisan": { "Polaris" };
    case "Tuzathelyezes ismert pontrol": { "Ismert pont" };
    default { "Koordinata" };
};
_combo lbAdd _mode;
_combo lbSetCurSel 0;
_combo ctrlEnable false;
missionNamespace setVariable ["FDC_locationMode", _mode];

// Populate direction combos before applying visibility/layout.
if (_missionType isEqualTo "Tuzathelyezes ismert pontrol") then {
    private _lr = _display displayCtrl 9240;
    private _nf = _display displayCtrl 9241;
    lbClear _lr; { _lr lbAdd _x; } forEach ["Jobbra", "Balra"];
    lbClear _nf; { _nf lbAdd _x; } forEach ["Kozelebb", "Tavolabb"];
    private _dirs = missionNamespace getVariable ["FDC_shiftDirections", ["Jobbra","Kozelebb"]];
    _lr lbSetCurSel ((["Jobbra","Balra"] find (_dirs select 0)) max 0);
    _nf lbSetCurSel ((["Kozelebb","Tavolabb"] find (_dirs select 1)) max 0);
};

// Apply labels and show only controls required by the selected mission type.
[_display] call FDC_fnc_coordinateModeChanged;

(_display displayCtrl 9250) ctrlSetText (missionNamespace getVariable ["FDC_targetNumber",""]);
private _saved = missionNamespace getVariable ["FDC_locationValues", []];
if ((count _saved) >= 6) then {
    for "_i" from 0 to 5 do {
        (_display displayCtrl (9230 + _i)) ctrlSetText (_saved select _i);
    };
};
diag_log format ["[FDC FIX 20261006-B] initCoordinate display=%1 instance=%2 mission=%3 mode=%4 values=%5", _display, _display getVariable ["FDC_debugInstance", -1], _missionType, _mode, _saved];
