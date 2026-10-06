disableSerialization;
private _display = findDisplay 9200;
if (isNull _display) exitWith {};

private _missionType = missionNamespace getVariable ["FDC_missionType", "Beloves"];
private _labels = [9220,9221,9222,9223,9224,9225];
private _edits = [9230,9231,9232,9233,9234,9235];
private _lrCombo = _display displayCtrl 9240;
private _nfCombo = _display displayCtrl 9241;
_lrCombo ctrlShow false;
_nfCombo ctrlShow false;

private _texts = switch (_missionType) do {
    case "Beloves polarisan": { ["Figyelo Y koordinata:","Figyelo X koordinata:","Iranyszog (mils):","Tavolsag (m):","Magassag (m):",""] };
    case "Tuzathelyezes ismert pontrol": { ["Ismert pont Y:","Ismert pont X:","Magassag (m):","Oldaliranyu elteres (m):","Tavolsagi elteres (m):","Iranyszog (mils):"] };
    default { ["Y koordinata:","X koordinata:","Magassag (m):","Iranyszog (mils):","",""] };
};

// Reset positions every time the dialog is opened. Hidden combo controls share
// the same rows as edit controls, so stale positions/visibility must not leak
// between mission types.
for "_i" from 0 to 5 do {
    private _edit = _display displayCtrl (_edits select _i);
    _edit ctrlSetPosition [0.43, 0.30 + (0.06 * _i), 0.32, 0.045];
    _edit ctrlCommit 0;
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

// Apply the special split rows only for known-point shift.
if (_missionType isEqualTo "Tuzathelyezes ismert pontrol") then {
    _lrCombo ctrlShow true;
    _nfCombo ctrlShow true;
    (_display displayCtrl 9233) ctrlSetPosition [0.56,0.48,0.19,0.045]; (_display displayCtrl 9233) ctrlCommit 0;
    (_display displayCtrl 9234) ctrlSetPosition [0.56,0.54,0.19,0.045]; (_display displayCtrl 9234) ctrlCommit 0;
} else {
    (_display displayCtrl 9233) ctrlSetPosition [0.43,0.48,0.32,0.045]; (_display displayCtrl 9233) ctrlCommit 0;
    (_display displayCtrl 9234) ctrlSetPosition [0.43,0.54,0.32,0.045]; (_display displayCtrl 9234) ctrlCommit 0;
};
