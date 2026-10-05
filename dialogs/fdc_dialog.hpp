class FDC_ContactDialog
{
    idd = 9100;
    movingEnable = 0;
    enableSimulation = 1;

    class controlsBackground
    {
        class Background
        {
            idc = -1;
            type = 0;
            style = 0;
            x = 0.30;
            y = 0.30;
            w = 0.40;
            h = 0.30;
            colorBackground[] = {0,0,0,0.85};
            colorText[] = {1,1,1,1};
            font = "RobotoCondensed";
            sizeEx = 0.04;
            text = "";
        };
    };

    class controls
    {
        class Title
        {
            idc = -1;
            type = 0;
            style = 2;
            x = 0.32;
            y = 0.34;
            w = 0.36;
            h = 0.06;
            colorBackground[] = {0,0,0,0};
            colorText[] = {1,1,1,1};
            font = "RobotoCondensed";
            sizeEx = 0.05;
            text = "Kapcsolatfelvetel";
        };

        class NextButton
        {
            idc = 9101;
            type = 1;
            style = 2;
            x = 0.54;
            y = 0.50;
            w = 0.14;
            h = 0.06;
            text = "Tovabb";
            font = "RobotoCondensed";
            sizeEx = 0.04;
            colorText[] = {1,1,1,1};
            colorDisabled[] = {0.4,0.4,0.4,1};
            colorBackground[] = {0.2,0.2,0.2,1};
            colorBackgroundDisabled[] = {0.1,0.1,0.1,1};
            colorBackgroundActive[] = {0.3,0.3,0.3,1};
            colorFocused[] = {0.3,0.3,0.3,1};
            colorShadow[] = {0,0,0,1};
            colorBorder[] = {0,0,0,1};
            soundEnter[] = {"",0.1,1};
            soundPush[] = {"",0.1,1};
            soundClick[] = {"",0.1,1};
            soundEscape[] = {"",0.1,1};
            shadow = 0;
            borderSize = 0;
            offsetX = 0;
            offsetY = 0;
            offsetPressedX = 0;
            offsetPressedY = 0;
            onButtonClick = "closeDialog 0;";
        };
    };
};
