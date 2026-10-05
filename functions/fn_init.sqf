if (!hasInterface) exitWith {};

[] spawn
{
    waitUntil { !isNull player };
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
