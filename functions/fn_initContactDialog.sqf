disableSerialization;
params [["_display", displayNull, [displayNull]]];
if (isNull _display) exitWith { diag_log "[FDC FIX 20261006-B] initContact: missing display"; };
private _combo = _display displayCtrl 9110;
if (isNull _combo) exitWith { diag_log "[FDC FIX 20261006-B] initContact: missing combo 9110"; };
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
diag_log format ["[FDC FIX 20261006-B] initContact display=%1 instance=%2 size=%3 selected=%4 saved=%5", _display, _display getVariable ["FDC_debugInstance", -1], lbSize _combo, _combo lbText (lbCurSel _combo), _saved];
