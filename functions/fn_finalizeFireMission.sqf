private _report = missionNamespace getVariable ["FDC_fireReportText",""];
if (_report isEqualTo "") exitWith {hint "Nincs naplo."; false};
diag_log "========== FDC TUZFELADAT NAPLO START ==========";
{diag_log ("[FDC] " + _x);} forEach (_report splitString (toString [10]));
diag_log "========== FDC TUZFELADAT NAPLO END ==========";
private _archive = missionNamespace getVariable ["FDC_fireReportArchive",[]];
_archive pushBack _report;
missionNamespace setVariable ["FDC_fireReportArchive",_archive];
[] call FDC_fnc_endFireMission;
true
