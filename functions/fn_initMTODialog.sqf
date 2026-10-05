disableSerialization;
private _display = findDisplay 9400;
if (isNull _display) exitWith {};
private _combo = _display displayCtrl 9410;
_combo lbAdd "Nincs felismert alegyseg";
_combo lbSetCurSel 0;
(_display displayCtrl 9414) ctrlSetText "-- s";
