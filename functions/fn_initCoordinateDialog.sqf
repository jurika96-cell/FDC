disableSerialization;
private _display = findDisplay 9200;
if (isNull _display) exitWith {};
private _combo = _display displayCtrl 9210;
{ _combo lbAdd _x; } forEach ["Grid", "Polaris", "Ismert pont"];
_combo lbSetCurSel 0;
[] call FDC_fnc_coordinateModeChanged;
