disableSerialization;
diag_log format ["[FDC DEBUG 20261006-A] fn_initMTODialog enter namespace=%1 mission=%2",currentNamespace,missionNamespace getVariable ["FDC_missionType","<unset>"]];
private _display = findDisplay 9400;
if (isNull _display) exitWith { diag_log "[FDC DEBUG 20261006-A] fn_initMTODialog EXIT displayNull"; };
private _combo = _display displayCtrl 9410;
_combo lbAdd "Nincs felismert alegyseg";
_combo lbSetCurSel 0;
(_display displayCtrl 9414) ctrlSetText "-- s";

diag_log format ["[FDC DEBUG 20261006-A] fn_initMTODialog done display=%1 instance=%2 mission=%3 values=%4",_display,_display getVariable ["FDC_debugInstance",-1],missionNamespace getVariable ["FDC_missionType","<unset>"],missionNamespace getVariable ["FDC_locationValues",[]]];
