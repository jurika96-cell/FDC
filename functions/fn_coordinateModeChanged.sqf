disableSerialization;
private _display = findDisplay 9200;
if (isNull _display) exitWith {};
private _mode = lbCurSel (_display displayCtrl 9210);
private _labels = [9220,9221,9222,9223,9224,9225];
private _edits = [9230,9231,9232,9233,9234,9235];
{ (_display displayCtrl _x) ctrlShow true; } forEach (_labels + _edits);
private _texts = switch (_mode) do {
    case 1: { ["Tavolsag (m):","Iranyszog (mils):","Magassag (m):","","",""] };
    case 2: { ["Ismert pont Y:","Ismert pont X:","Jobbra/Balra (m):","Noveld/Csokkentsd (m):","Magassag (m):","Iranyszog (mils):"] };
    default { ["Y koordinata:","X koordinata:","Magassag (m):","Iranyszog (mils):","",""] };
};
for "_i" from 0 to 5 do {
    (_display displayCtrl (_labels select _i)) ctrlSetText (_texts select _i);
    private _show = (_texts select _i) != "";
    (_display displayCtrl (_labels select _i)) ctrlShow _show;
    (_display displayCtrl (_edits select _i)) ctrlShow _show;
};
