disableSerialization;
diag_log format ["[FDC DEBUG 20261006-A] fn_saveMTO enter namespace=%1 mission=%2",currentNamespace,missionNamespace getVariable ["FDC_missionType","<unset>"]];
private _display = findDisplay 9400;
if (isNull _display) exitWith { diag_log "[FDC DEBUG 20261006-A] fn_saveMTO EXIT displayNull"; };
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

diag_log format ["[FDC DEBUG 20261006-A] fn_saveMTO done display=%1 instance=%2 mission=%3 values=%4",_display,_display getVariable ["FDC_debugInstance",-1],missionNamespace getVariable ["FDC_missionType","<unset>"],missionNamespace getVariable ["FDC_locationValues",[]]];
