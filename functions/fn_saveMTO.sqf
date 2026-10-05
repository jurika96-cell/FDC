disableSerialization;
private _display = findDisplay 9400;
if (isNull _display) exitWith {};
private _combo = _display displayCtrl 9410;
private _data = [
    _combo lbText (lbCurSel _combo),
    ctrlText (_display displayCtrl 9411),
    ctrlText (_display displayCtrl 9412),
    ctrlText (_display displayCtrl 9413),
    ctrlText (_display displayCtrl 9414)
];
missionNamespace setVariable ["FDC_MTOData", _data];
hint "MTO rogzitve";
