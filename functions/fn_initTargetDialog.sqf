disableSerialization;
diag_log format ["[FDC DEBUG 20261006-A] fn_initTargetDialog enter namespace=%1 mission=%2",currentNamespace,missionNamespace getVariable ["FDC_missionType","<unset>"]];
private _display = findDisplay 9300;
if (isNull _display) exitWith { diag_log "[FDC DEBUG 20261006-A] fn_initTargetDialog EXIT displayNull"; };
private _ammo = _display displayCtrl 9316;
private _fuze = _display displayCtrl 9317;
private _trajectory = _display displayCtrl 9318;
lbClear _ammo; lbClear _fuze; lbClear _trajectory;
{ _ammo lbAdd _x; } forEach ["HE", "Smoke", "Illumination"];
{ _fuze lbAdd _x; } forEach ["Impact", "Delay", "Proximity", "Height"];
{ _trajectory lbAdd _x; } forEach ["Lapos", "Ivelt", "Meredek"];
private _saved = missionNamespace getVariable ["FDC_targetData", []];
if ((count _saved) >= 9) then {
    for "_i" from 0 to 5 do { (_display displayCtrl (9310 + _i)) ctrlSetText (_saved select _i); };
    {
        private _ctrl = _display displayCtrl (_x select 0);
        private _wanted = _saved select (_x select 1);
        private _idx = 0;
        for "_j" from 0 to ((lbSize _ctrl) - 1) do { if ((_ctrl lbText _j) isEqualTo _wanted) exitWith { _idx = _j; }; };
        _ctrl lbSetCurSel _idx;
    } forEach [[9316,6],[9317,7],[9318,8]];
} else {
    _ammo lbSetCurSel 0; _fuze lbSetCurSel 0; _trajectory lbSetCurSel 0;
};

diag_log format ["[FDC DEBUG 20261006-A] fn_initTargetDialog done display=%1 instance=%2 mission=%3 values=%4",_display,_display getVariable ["FDC_debugInstance",-1],missionNamespace getVariable ["FDC_missionType","<unset>"],missionNamespace getVariable ["FDC_locationValues",[]]];
