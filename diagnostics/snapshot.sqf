// Paste into the Eden/mission debug console and run locally with the FDC UI open.
// Read-only snapshot: does not populate controls or change mission data.
disableSerialization;
diag_log "[FDC DEBUG 20261006-A] SNAPSHOT BEGIN";
diag_log format ["[FDC DEBUG 20261006-A] snapshot mission=%1 mode=%2 values=%3 directions=%4", missionNamespace getVariable ["FDC_missionType","<unset>"], missionNamespace getVariable ["FDC_locationMode","<unset>"], missionNamespace getVariable ["FDC_locationValues",[]], missionNamespace getVariable ["FDC_shiftDirections",[]]];
{
    private _name = _x;
    diag_log format ["[FDC DEBUG 20261006-A] function=%1 exists=%2 type=%3",_name,!(isNil {missionNamespace getVariable _name}),typeName (missionNamespace getVariable [_name,0])];
} forEach ["FDC_fnc_initContactDialog","FDC_fnc_initCoordinateDialog","FDC_fnc_coordinateModeChanged","FDC_fnc_saveContact","FDC_fnc_saveCoordinate"];
{
    _x params ["_class","_idd","_idcs"];
    private _display = findDisplay _idd;
    diag_log format ["[FDC DEBUG 20261006-A] snapshot class=%1 display=%2 instance=%3 loadedOnLoad=%4 missionOverride=%5",_class,_display,_display getVariable ["FDC_debugInstance",-1],getText (configFile >> _class >> "onLoad"),isClass (missionConfigFile >> _class)];
    if (!isNull _display) then {
        {
            private _control = _display displayCtrl _x;
            diag_log format ["[FDC DEBUG 20261006-A] snapshot idc=%1 null=%2 type=%3 shown=%4 enabled=%5 position=%6 text=%7",_x,isNull _control,ctrlType _control,ctrlShown _control,ctrlEnabled _control,ctrlPosition _control,ctrlText _control];
            if (ctrlType _control in [4,5]) then {
                private _items = [];
                for "_i" from 0 to ((lbSize _control) - 1) do { _items pushBack (_control lbText _i); };
                diag_log format ["[FDC DEBUG 20261006-A] snapshot list idc=%1 size=%2 sel=%3 items=%4",_x,lbSize _control,lbCurSel _control,_items];
            };
        } forEach _idcs;
    };
} forEach [
    ["FDC_ContactDialog",9100,[9110]],
    ["FDC_CoordinateDialog",9200,[9210,9220,9221,9222,9223,9224,9225,9230,9231,9232,9233,9234,9235,9240,9241]],
    ["FDC_TargetTypeDialog",9300,[9316,9317,9318]],
    ["FDC_MTODialog",9400,[9410]]
];
diag_log "[FDC DEBUG 20261006-A] SNAPSHOT END";
systemChat "FDC DEBUG: snapshot written to RPT.";
