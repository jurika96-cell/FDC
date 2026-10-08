/* Finish the current mission, optionally writing its report to RPT, then start a new first transmission. */
params [["_save",true,[true]]];
private _report = missionNamespace getVariable ["FDC_fireReportText",""];
if (_save && {_report isEqualTo ""}) exitWith {hint "Nincs naplo."; false};
if (_save) then {
    diag_log "========== FDC TUZFELADAT NAPLO START ==========";
    {diag_log ("[FDC] " + _x);} forEach (_report splitString (toString [10]));
    diag_log "========== FDC TUZFELADAT NAPLO END ==========";
    private _archive = missionNamespace getVariable ["FDC_fireReportArchive",[]];
    _archive pushBack _report;
    missionNamespace setVariable ["FDC_fireReportArchive",_archive];
};
// Clear state before reopening: the next FDC session must start with transmission 1.
missionNamespace setVariable ["FDC_activeFireMission",false];
{
    missionNamespace setVariable [_x,nil];
} forEach [
    "FDC_MTOData","FDC_MTOSelectedGroup","FDC_MTOTargetPosition",
    "FDC_MTOGunSolutions","FDC_adjustedTargetPosition",
    "FDC_adjustmentObserverAzimuth","FDC_locationValues",
    "FDC_locationMode","FDC_shiftDirections","FDC_missionType",
    "FDC_targetData","FDC_targetNumber","FDC_adjustmentLog",
    "FDC_fireReportText","FDC_observerReport","FDC_fireLogEvents"
];
// The report and BDA dialogs can be stacked on the MTO dialog.
// Unwind all layers before opening the first transmission.
[] spawn {
    for "_i" from 0 to 5 do {
        if (dialog) then {closeDialog 0; uiSleep 0.05;};
    };
    createDialog "FDC_ContactDialog";
};
true
