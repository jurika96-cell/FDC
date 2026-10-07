/*
    Resolve the current Call for Fire target to an ATL position.
    Supports the three currently implemented second-transmission modes.
*/
private _mode = missionNamespace getVariable ["FDC_locationMode", "Koordinata"];
private _v = missionNamespace getVariable ["FDC_locationValues", []];
if (count _v < 6) exitWith {[]};

private _number = {
    params ["_text"];
    parseNumber _text
};
private _milsToDeg = {
    params ["_text"];
    private _m = parseNumber _text;
    (_m / 6400) * 360
};

private _pos = [];

switch (_mode) do {
    case "Koordinata": {
        private _y = [_v select 0] call _number;
        private _x = [_v select 1] call _number;
        private _h = [_v select 2] call _number;
        _pos = [_y, _x, _h];
    };

    case "Polaris": {
        private _obsY = [_v select 0] call _number;
        private _obsX = [_v select 1] call _number;
        private _az = [_v select 2] call _milsToDeg;
        private _distance = [_v select 3] call _number;
        private _height = [_v select 4] call _number;
        _pos = [_obsY, _obsX, 0] getPos [_distance, _az];
        _pos set [2, _height];
    };

    case "Ismert pont": {
        private _knownY = [_v select 0] call _number;
        private _knownX = [_v select 1] call _number;
        private _height = [_v select 2] call _number;
        private _lateral = [_v select 3] call _number;
        private _range = [_v select 4] call _number;
        private _az = [_v select 5] call _milsToDeg;
        private _dirs = missionNamespace getVariable ["FDC_shiftDirections", ["Jobbra","Kozelebb"]];

        private _rangeBearing = if ((_dirs select 1) isEqualTo "Tavolabb") then {_az} else {_az + 180};
        private _lateralBearing = if ((_dirs select 0) isEqualTo "Jobbra") then {_az + 90} else {_az - 90};

        _pos = [_knownY, _knownX, _height] getPos [_range, _rangeBearing];
        _pos = _pos getPos [_lateral, _lateralBearing];
        _pos set [2, _height];
    };
};

_pos
