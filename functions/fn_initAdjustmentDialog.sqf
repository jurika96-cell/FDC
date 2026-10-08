disableSerialization;
params [["_display", displayNull, [displayNull]]];
if (isNull _display) exitWith {};

private _lr = _display displayCtrl 9511;
private _nf = _display displayCtrl 9513;
lbClear _lr; { _lr lbAdd _x; } forEach ["Jobbra","Balra"];
lbClear _nf; { _nf lbAdd _x; } forEach ["Tavolabb","Kozelebb"];
_lr lbSetCurSel 0;
_nf lbSetCurSel 0;

private _az = missionNamespace getVariable ["FDC_adjustmentObserverAzimuth", -1];
if (_az < 0) then {
    private _mode = missionNamespace getVariable ["FDC_locationMode", ""];
    private _v = missionNamespace getVariable ["FDC_locationValues", []];
    if (_mode isEqualTo "Koordinata" && {count _v > 3}) then {_az = parseNumber (_v select 3);};
    if (_mode isEqualTo "Polaris" && {count _v > 2}) then {_az = parseNumber (_v select 2);};
    if (_mode isEqualTo "Ismert pont" && {count _v > 5}) then {_az = parseNumber (_v select 5);};
};
if (_az >= 0) then {(_display displayCtrl 9510) ctrlSetText str (round _az);};
(_display displayCtrl 9512) ctrlSetText "0";
(_display displayCtrl 9514) ctrlSetText "0";
