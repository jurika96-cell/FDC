params ["_logic"];

if (isNull _logic) exitWith {};

private _synced = synchronizedObjects _logic;

{
    if (_x isKindOf "CAManBase") then
    {
        _x setVariable ["FDC_hasAccess", true, true];
    };
} forEach _synced;
