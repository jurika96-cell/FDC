/*
    Detect usable artillery automatically.

    Priority:
    1. Explicit FDC_artillery = 1 config flag.
    2. Explicit class names in FDC_artilleryTypes.
    3. Any alive LandVehicle for which getArtilleryAmmo returns at least one magazine.

    The third rule makes compatible modded artillery (for example Sholefet variants)
    work without maintaining a classname whitelist.
*/
private _explicitTypes = missionNamespace getVariable ["FDC_artilleryTypes", []];

private _guns = allMissionObjects "LandVehicle" select {
    private _vehicle = _x;
    private _cfg = configFile >> "CfgVehicles" >> typeOf _vehicle;
    private _flagged = getNumber (_cfg >> "FDC_artillery") > 0;
    private _explicit = typeOf _vehicle in _explicitTypes;
    private _engineArtillery = count (getArtilleryAmmo [_vehicle]) > 0;

    alive _vehicle && {_flagged || _explicit || _engineArtillery}
};

missionNamespace setVariable ["FDC_artilleryRegistry", _guns, true];
_guns
