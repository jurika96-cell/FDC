/*
    Group artillery pieces into connected components.
    Guns linked through another gun within the grouping distance remain
    in the same firing subunit.
*/
params [
    ["_guns", [], [[]]],
    ["_maxDistance", missionNamespace getVariable ["FDC_gunGroupingDistance", 300], [0]]
];

private _remaining = +_guns;
private _groups = [];
private _index = 1;

while {count _remaining > 0} do {
    private _seed = _remaining deleteAt 0;
    private _members = [_seed];
    private _changed = true;

    while {_changed} do {
        _changed = false;
        for "_i" from ((count _remaining) - 1) to 0 step -1 do {
            private _candidate = _remaining select _i;
            if (_members findIf {_candidate distance2D _x <= _maxDistance} >= 0) then {
                _members pushBack _candidate;
                _remaining deleteAt _i;
                _changed = true;
            };
        };
    };

    private _sx = 0;
    private _sy = 0;
    private _sz = 0;
    {
        private _p = getPosATL _x;
        _sx = _sx + (_p select 0);
        _sy = _sy + (_p select 1);
        _sz = _sz + (_p select 2);
    } forEach _members;

    private _n = count _members;
    private _center = [_sx / _n, _sy / _n, _sz / _n];

    private _group = createHashMap;
    _group set ["id", format ["ALEGYSEG-%1", _index]];
    _group set ["guns", _members];
    _group set ["gunCount", _n];
    _group set ["center", _center];
    _group set ["groupingDistance", _maxDistance];

    _groups pushBack _group;
    _index = _index + 1;
};

missionNamespace setVariable ["FDC_artilleryGroups", _groups, true];
_groups
