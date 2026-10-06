disableSerialization;
params [["_display", displayNull, [displayNull]]];
if (isNull _display) exitWith { diag_log "[FDC FIX 20261006-B] initMTO: missing display"; };
private _combo = _display displayCtrl 9410;
lbClear _combo;
_combo lbAdd "Nincs felismert alegyseg";
_combo lbSetCurSel 0;
(_display displayCtrl 9414) ctrlSetText "-- s";
