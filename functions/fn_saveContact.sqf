disableSerialization;
private _display = findDisplay 9100;
if (isNull _display) exitWith {};
private _combo = _display displayCtrl 9110;
missionNamespace setVariable ["FDC_missionType", _combo lbText (lbCurSel _combo)];
