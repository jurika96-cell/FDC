disableSerialization;
params [["_display", displayNull, [displayNull]]];
if (isNull _display) exitWith { false };
private _combo = _display displayCtrl 9110;
private _sel = lbCurSel _combo;
if (_sel < 0) exitWith {
    diag_log "[FDC FIX 20261006-B] saveContact: no selection, navigation blocked";
    hint "Valassz tuzfeladatot!";
    false
};
private _value = _combo lbText _sel;
if (_value isEqualTo "") exitWith { false };
missionNamespace setVariable ["FDC_missionType", _value];
diag_log format ["[FDC FIX 20261006-B] saveContact mission=%1", _value];
true
