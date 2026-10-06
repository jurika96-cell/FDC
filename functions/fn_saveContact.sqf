disableSerialization;
diag_log format ["[FDC DEBUG 20261006-A] fn_saveContact enter namespace=%1 mission=%2",currentNamespace,missionNamespace getVariable ["FDC_missionType","<unset>"]];
private _display = findDisplay 9100;
if (isNull _display) exitWith { diag_log "[FDC DEBUG 20261006-A] fn_saveContact EXIT displayNull"; };
private _combo = _display displayCtrl 9110;
private _sel = lbCurSel _combo;
diag_log format ["[FDC DEBUG 20261006-A] saveContact combo=%1 size=%2 sel=%3 text=%4",_combo,lbSize _combo,_sel,_combo lbText _sel];
if (_sel >= 0) then {
    private _value = _combo lbText _sel;
    if (_value != "") then {
        missionNamespace setVariable ["FDC_missionType", _value];
    };
};

diag_log format ["[FDC DEBUG 20261006-A] fn_saveContact done display=%1 instance=%2 mission=%3 values=%4",_display,_display getVariable ["FDC_debugInstance",-1],missionNamespace getVariable ["FDC_missionType","<unset>"],missionNamespace getVariable ["FDC_locationValues",[]]];
