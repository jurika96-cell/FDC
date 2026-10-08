disableSerialization;
params [["_display",displayNull,[displayNull]]];
if (isNull _display) exitWith {false};
private _bda = ctrlText (_display displayCtrl 9610);
if (_bda isEqualTo "") exitWith {hint "Add meg a figyelo jelenteset!"; false};
missionNamespace setVariable ["FDC_observerReport",_bda];
private _mission = missionNamespace getVariable ["FDC_missionType",""];
private _loc = missionNamespace getVariable ["FDC_locationValues",[]];
private _locMode = missionNamespace getVariable ["FDC_locationMode",""];
private _target = missionNamespace getVariable ["FDC_targetData",[]];
private _mto = missionNamespace getVariable ["FDC_MTOData",[]];
private _number = missionNamespace getVariable ["FDC_targetNumber",""];
private _locationText = format ["%1: %2",_locMode,_loc joinString " "];
if (_number isNotEqualTo "") then {_locationText = _locationText + format [" | Celszam: %1",_number];};
private _targetText = if (count _target >= 6) then {
 format ["%1, %2, %3x%4, %5, cel fekvese %6",_target select 0,_target select 1,_target select 2,_target select 3,_target select 4,_target select 5]
} else {str _target};
private _mtoText = if (count _mto >= 5) then {
 format ["MTO: %1, celszam %2, %3 loveg, %4 granat/loveg, ropido %5",_mto select 0,_mto select 1,_mto select 2,_mto select 3,_mto select 4]
} else {"MTO: nincs rogzitett adat"};
private _lines = [_mission,"",_locationText,"",_targetText,"",_mtoText,""];
{_lines pushBack _x;} forEach (missionNamespace getVariable ["FDC_adjustmentLog",[]]);
_lines pushBack "";
_lines pushBack ("BDA: " + _bda);
missionNamespace setVariable ["FDC_fireReportText",_lines joinString (toString [10])];
closeDialog 0;
createDialog "FDC_FireReportDialog";
true
