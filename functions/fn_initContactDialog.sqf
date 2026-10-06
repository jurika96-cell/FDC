disableSerialization;
diag_log format ["[FDC DEBUG 20261006-A] fn_initContactDialog enter namespace=%1 mission=%2",currentNamespace,missionNamespace getVariable ["FDC_missionType","<unset>"]];
private _display = findDisplay 9100;
if (isNull _display) exitWith { diag_log "[FDC DEBUG 20261006-A] fn_initContactDialog EXIT displayNull"; };
private _combo = _display displayCtrl 9110;
lbClear _combo;
{
    _combo lbAdd _x;
} forEach [
    "Beloves",
    "Hatastuz",
    "Azonnali lefogas",
    "Azonnali kodosites",
    "Beloves polarisan",
    "Tuzathelyezes ismert pontrol"
];
private _saved = missionNamespace getVariable ["FDC_missionType", "Beloves"];
private _idx = 0;
for "_i" from 0 to ((lbSize _combo) - 1) do {
    if ((_combo lbText _i) isEqualTo _saved) exitWith { _idx = _i; };
};
_combo lbSetCurSel _idx;

diag_log format ["[FDC DEBUG 20261006-A] fn_initContactDialog done display=%1 instance=%2 mission=%3 values=%4",_display,_display getVariable ["FDC_debugInstance",-1],missionNamespace getVariable ["FDC_missionType","<unset>"],missionNamespace getVariable ["FDC_locationValues",[]]];
diag_log format ["[FDC DEBUG 20261006-A] initContact combo=%1 size=%2 sel=%3 text=%4",_combo,lbSize _combo,lbCurSel _combo,_combo lbText (lbCurSel _combo)];
