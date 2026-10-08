params [["_message","",[""]]];
private _events = missionNamespace getVariable ["FDC_fireLogEvents", []];
_events pushBack [round time, _message];
missionNamespace setVariable ["FDC_fireLogEvents", _events];
