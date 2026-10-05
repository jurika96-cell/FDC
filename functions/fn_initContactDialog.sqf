disableSerialization;
private _display = findDisplay 9100;
if (isNull _display) exitWith {};
private _combo = _display displayCtrl 9110;
{
    _combo lbAdd _x;
} forEach ["Beloves", "Hatastuz", "Azonnali lefogas", "Azonnali kodosites"];
_combo lbSetCurSel 0;
