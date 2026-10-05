disableSerialization;
private _display = findDisplay 9200;
if (isNull _display) exitWith {};

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
[] call FDC_fnc_coordinateModeChanged;
