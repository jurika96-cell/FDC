disableSerialization;
params [["_display",displayNull,[displayNull]]];
if (isNull _display) exitWith {};
private _report = missionNamespace getVariable ["FDC_fireReportText",""];
(_display displayCtrl 9710) ctrlSetText _report;
