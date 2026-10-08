class CfgPatches
{
    class FDC
    {
        name = "FDC";
        author = "jurika96-cell";
        requiredVersion = 2.14;
        requiredAddons[] = {"ace_interact_menu", "A3_Modules_F"};
        units[] = {"FDC_ModuleAccess"};
        weapons[] = {};
    };
};

#include "dialogs\fdc_dialog.hpp"

class CfgFunctions
{
    class FDC
    {
        tag = "FDC";
        class Core
        {
            file = "\FDC\functions";
            class init { postInit = 1; };
            class openContactDialog {};
            class grantAccess {};
            class initContactDialog {};
            class saveContact {};
            class initCoordinateDialog {};
            class coordinateModeChanged {};
            class saveCoordinate {};
            class initTargetDialog {};
            class saveTarget {};
            class initMTODialog {};
            class scanArtillery {};
            class groupArtillery {};
            class resolveTargetPosition {};
            class updateMTO {};
            class saveMTO {};
            class executeMTOFire {};
            class initAdjustmentDialog {};
            class applyAdjustment {};
            class endFireMission {};
            class logEvent {};
            class showFireReport {};
            class submitObserverReport {};
            class finalizeFireMission {};
        };
    };
};

class CfgFactionClasses
{
    class NO_CATEGORY;
    class FDC_Modules: NO_CATEGORY
    {
        displayName = "FDC";
    };
};

class CfgVehicles
{
    class Logic;
    class Module_F: Logic
    {
        class AttributesBase;
        class ModuleDescription;
    };

    class FDC_ModuleAccess: Module_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = "FDC - Hozzaferes";
        category = "FDC_Modules";
        function = "FDC_fnc_grantAccess";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;
        isDisposable = 0;

        class ModuleDescription: ModuleDescription
        {
            description = "Az FDC modult a szinkronizalt jatekos szamara teszi elerhetove.";
            sync[] = {"AnyPerson"};
        };
    };
};
