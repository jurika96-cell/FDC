/*
    Refresh MTO information for the selected automatically detected firing subunit.
    Uses the Arma artillery computer API so compatible modded guns work without
    hard-coded class names.
*/
disableSerialization;
params [["_display", displayNull, [displayNull]]];
if (isNull _display) exitWith {false};

private _combo = _display displayCtrl 9410;
private _sel = lbCurSel _combo;
if (_sel < 0) exitWith {false};

private _groupIndex = parseNumber (_combo lbData _sel);
private _groups = missionNamespace getVariable ["FDC_artilleryGroups", []];
if (_groupIndex < 0 || {_groupIndex >= count _groups}) exitWith {
    (_display displayCtrl 9414) ctrlSetText "-- s";
    false
};

private _group = _groups select _groupIndex;
private _guns = (_group getOrDefault ["guns", []]) select {alive _x};
if (count _guns == 0) exitWith {
    (_display displayCtrl 9414) ctrlSetText "-- s";
    false
};

private _gunsCtrl = _display displayCtrl 9412;
private _requested = floor parseNumber (ctrlText _gunsCtrl);
if (_requested < 1) then {
    _requested = count _guns;
    _gunsCtrl ctrlSetText str _requested;
};
_requested = _requested min (count _guns);
_gunsCtrl ctrlSetText str _requested;

private _roundsCtrl = _display displayCtrl 9413;
private _rounds = floor parseNumber (ctrlText _roundsCtrl);
if (_rounds < 1) then {
    _rounds = 1;
    _roundsCtrl ctrlSetText "1";
};

private _targetNo = _display displayCtrl 9411;
if (ctrlText _targetNo isEqualTo "") then {
    private _seq = missionNamespace getVariable ["FDC_targetSequence", 1];
    _targetNo ctrlSetText format ["%1", _seq];
};

private _target = call FDC_fnc_resolveTargetPosition;
if (count _target < 3) exitWith {
    (_display displayCtrl 9414) ctrlSetText "-- s";
    false
};

private _selectedGuns = _guns select [0, _requested];
private _solutions = [];
private _minETA = 1e10;

{
    private _gun = _x;
    private _bestETA = 1e10;
    private _bestMag = "";

    {
        private _eta = _gun getArtilleryETA [_target, _x];
        if (_eta >= 0 && {_eta < _bestETA}) then {
            _bestETA = _eta;
            _bestMag = _x;
        };
    } forEach (getArtilleryAmmo [_gun]);

    if (_bestMag isNotEqualTo "") then {
        _solutions pushBack [_gun, _bestMag, _bestETA];
        if (_bestETA < _minETA) then {_minETA = _bestETA;};
    };
} forEach _selectedGuns;

missionNamespace setVariable ["FDC_MTOSelectedGroup", _groupIndex];
missionNamespace setVariable ["FDC_MTOSelectedGroupName", _combo lbText _sel];
missionNamespace setVariable ["FDC_MTOTargetPosition", _target];
missionNamespace setVariable ["FDC_MTOGunSolutions", _solutions];

private _tofCtrl = _display displayCtrl 9414;
if (count _solutions == 0) then {
    _tofCtrl ctrlSetText "Nincs tuzmegoldas";
} else {
    _tofCtrl ctrlSetText format ["%1 s", round _minETA];
};

count _solutions > 0
