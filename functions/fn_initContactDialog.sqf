disableSerialization;
private _display = findDisplay 9100;
if (isNull _display) exitWith {};
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
