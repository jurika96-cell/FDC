if (!hasInterface) exitWith {};

[] spawn
{
    waitUntil { !isNull player };

    // Temporary build marker: proves that Arma loaded the current GitHub build.
    systemChat "FDC BUILD TEST - 2026-10-05";
    hintSilent "FDC BUILD TEST - 2026-10-05";
    uiSleep 4;
    hintSilent "";

    waitUntil { !isNil "ace_interact_menu_fnc_createAction" };

    private _action = [
        "FDC_Main",
        "FDC",
        "",
        { [] call FDC_fnc_openContactDialog; },
        { player getVariable ["FDC_hasAccess", false] }
    ] call ace_interact_menu_fnc_createAction;

    [
        player,
        1,
        ["ACE_SelfActions"],
        _action
    ] call ace_interact_menu_fnc_addActionToObject;
};
