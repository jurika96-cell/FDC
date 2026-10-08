disableSerialization;
params [["_display", displayNull, [displayNull]]];
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
(_display displayCtrl 9420) ctrlShow false;
(_display displayCtrl 9421) ctrlShow true;
// The MTO target number is authoritative once recorded.
missionNamespace setVariable ["FDC_targetNumber", _data select 1];
hint "MTO rogzitve";
