disableSerialization;
params [["_display", displayNull, [displayNull]]];
if (isNull _display) exitWith { diag_log "[FDC] initMTO: missing display"; };

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
    _combo lbSetCurSel 0;
};

(_display displayCtrl 9414) ctrlSetText "-- s";

if (count _groups > 0) then {
    [_display] call FDC_fnc_updateMTO;
};
