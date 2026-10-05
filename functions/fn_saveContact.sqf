disableSerialization;
private _display = findDisplay 9100;
if (isNull _display) exitWith {};
private _combo = _display displayCtrl 9110;
private _sel = lbCurSel _combo;
if (_sel >= 0) then {
    private _value = _combo lbText _sel;
    if (_value != "") then {
        missionNamespace setVariable ["FDC_missionType", _value];
    };
};
