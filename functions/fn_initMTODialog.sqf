disableSerialization;
params [["_display", displayNull, [displayNull]]];
if (isNull _display) exitWith { diag_log "[FDC] initMTO: missing display"; };

private _savedMTO = missionNamespace getVariable ["FDC_MTOData", []];
private _combo = _display displayCtrl 9410;
lbClear _combo;

private _guns = call FDC_fnc_scanArtillery;
private _groups = [_guns] call FDC_fnc_groupArtillery;

if (count _groups == 0) then {
    _combo lbAdd "Nincs felismert alegyseg";
    _combo lbSetCurSel 0;
} else {
    {
        private _id = _x getOrDefault ["id", format ["ALEGYSEG-%1", _forEachIndex + 1]];
        private _count = _x getOrDefault ["gunCount", 0];
        private _row = _combo lbAdd format ["%1 (%2 loveg)", _id, _count];
        _combo lbSetData [_row, str _forEachIndex];
    } forEach _groups;
    private _savedName = if (count _savedMTO > 0) then {_savedMTO select 0} else {""};
    private _savedIndex = -1;
    for "_i" from 0 to ((lbSize _combo) - 1) do {
        if ((_combo lbText _i) isEqualTo _savedName) exitWith {_savedIndex = _i;};
    };
    _combo lbSetCurSel (_savedIndex max 0);
};

if (count _savedMTO >= 4) then {
    (_display displayCtrl 9411) ctrlSetText (_savedMTO select 1);
    (_display displayCtrl 9412) ctrlSetText (_savedMTO select 2);
    (_display displayCtrl 9413) ctrlSetText (_savedMTO select 3);
};

if (count _savedMTO < 4) then {
    private _number = missionNamespace getVariable ["FDC_targetNumber",""];
    if (_number isNotEqualTo "") then {(_display displayCtrl 9411) ctrlSetText _number;};
};
(_display displayCtrl 9414) ctrlSetText "-- s";

if (count _groups > 0) then {
    [_display] call FDC_fnc_updateMTO;
};
