class CfgPatches
{
    class FDC
    {
        name = "FDC";
        author = "jurika96-cell";
        requiredVersion = 2.14;
        requiredAddons[] = {"ace_interact_menu"};
        units[] = {};
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
            class init
            {
                postInit = 1;
            };
            class openContactDialog {};
        };
    };
};
