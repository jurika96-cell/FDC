disableSerialization;
diag_log format ["[FDC DEBUG 20261006-A] fn_saveTarget enter namespace=%1 mission=%2",currentNamespace,missionNamespace getVariable ["FDC_missionType","<unset>"]];
private _display = findDisplay 9300;
if (isNull _display) exitWith { diag_log "[FDC DEBUG 20261006-A] fn_saveTarget EXIT displayNull"; };
private _data = [];
{ _data pushBack ctrlText (_display displayCtrl _x); } forEach [9310,9311,9312,9313,9314,9315];
{
    private _ctrl = _display displayCtrl _x;
    _data pushBack (_ctrl lbText (lbCurSel _ctrl));
} forEach [9316,9317,9318];
missionNamespace setVariable ["FDC_targetData", _data];

diag_log format ["[FDC DEBUG 20261006-A] fn_saveTarget done display=%1 instance=%2 mission=%3 values=%4",_display,_display getVariable ["FDC_debugInstance",-1],missionNamespace getVariable ["FDC_missionType","<unset>"],missionNamespace getVariable ["FDC_locationValues",[]]];
