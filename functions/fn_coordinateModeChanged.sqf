disableSerialization;
private _display = findDisplay 9200;
if (isNull _display) exitWith {};

private _missionType = missionNamespace getVariable ["FDC_missionType", "Beloves"];
private _labels = [9220,9221,9222,9223,9224,9225];
private _edits = [9230,9231,9232,9233,9234,9235];

private _texts = switch (_missionType) do {
    case "Beloves polarisan": {
        ["Iranyszog (mils):","Tavolsag (m):","Magassag (m):","","",""]
    };
    case "Tuzathelyezes ismert pontrol": {
        ["Ismert pont Y:","Ismert pont X:","Magassag (m):","Jobbra/Balra (m):","Kozelebb/Tavolabb (m):",""]
    };
    default {
        ["Y koordinata:","X koordinata:","Magassag (m):","Iranyszog (mils):","",""]
    };
};

for "_i" from 0 to 5 do {
    private _label = _display displayCtrl (_labels select _i);
    private _edit = _display displayCtrl (_edits select _i);
    private _text = _texts select _i;
    _label ctrlSetText _text;
    private _show = _text != "";
    _label ctrlShow _show;
    _edit ctrlShow _show;
};
