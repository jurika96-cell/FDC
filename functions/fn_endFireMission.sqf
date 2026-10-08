/*
    Close the active fire mission and clear mission-specific state.
    The next FDC opening starts at the first transmission.
*/
missionNamespace setVariable ["FDC_activeFireMission", false];
{
    missionNamespace setVariable [_x, nil];
} forEach [
    "FDC_MTOData",
    "FDC_MTOSelectedGroup",
    "FDC_MTOTargetPosition",
    "FDC_MTOGunSolutions",
    "FDC_adjustedTargetPosition",
    "FDC_adjustmentObserverAzimuth",
    "FDC_locationValues",
    "FDC_locationMode",
    "FDC_shiftDirections",
    "FDC_missionType",
    "FDC_targetData",
    "FDC_targetNumber",
    "FDC_adjustmentLog",
    "FDC_fireReportText",
    "FDC_observerReport",
    "FDC_fireLogEvents"
];
closeDialog 0;
hint "Tuzfeladat vege.";
