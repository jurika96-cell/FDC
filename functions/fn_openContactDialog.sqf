if (missionNamespace getVariable ["FDC_activeFireMission", false]) then {
    createDialog "FDC_MTODialog";
} else {
    createDialog "FDC_ContactDialog";
};
