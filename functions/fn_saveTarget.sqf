disableSerialization;
private _display = findDisplay 9300;
if (isNull _display) exitWith {};
private _data = [];
{ _data pushBack ctrlText (_display displayCtrl _x); } forEach [9310,9311,9312,9313,9314,9315];
{
    private _ctrl = _display displayCtrl _x;
    _data pushBack (_ctrl lbText (lbCurSel _ctrl));
} forEach [9316,9317,9318];
missionNamespace setVariable ["FDC_targetData", _data];
