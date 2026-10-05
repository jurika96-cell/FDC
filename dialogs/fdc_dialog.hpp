class FDC_Background
{
    idc = -1;
    type = 0;
    style = 0;
    x = 0.30;
    y = 0.30;
    w = 0.40;
    h = 0.30;
    colorBackground[] = {0,0,0,1};
    colorText[] = {1,1,1,1};
    font = "RobotoCondensed";
    sizeEx = 0.04;
    text = "";
};

class FDC_Title
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
    text = "";
};

class FDC_NextButton
{
    idc = -1;
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
};

class FDC_ContactDialog
{
    idd = 9100;
    movingEnable = 0;
    enableSimulation = 1;
    class controlsBackground { class Background: FDC_Background {}; };
    class controls
    {
        class Title: FDC_Title { text = "Kapcsolatfelvetel"; };
        class NextButton: FDC_NextButton
        {
            idc = 9101;
            onButtonClick = "closeDialog 0; createDialog 'FDC_CoordinateDialog';";
        };
    };
};

class FDC_CoordinateDialog
{
    idd = 9200;
    movingEnable = 0;
    enableSimulation = 1;
    class controlsBackground { class Background: FDC_Background {}; };
    class controls
    {
        class Title: FDC_Title { text = "Koordinata"; };
        class NextButton: FDC_NextButton
        {
            idc = 9201;
            onButtonClick = "closeDialog 0; createDialog 'FDC_TargetTypeDialog';";
        };
    };
};

class FDC_TargetTypeDialog
{
    idd = 9300;
    movingEnable = 0;
    enableSimulation = 1;
    class controlsBackground { class Background: FDC_Background {}; };
    class controls
    {
        class Title: FDC_Title { text = "Cel jellege"; };
        class NextButton: FDC_NextButton
        {
            idc = 9301;
            onButtonClick = "closeDialog 0; createDialog 'FDC_MTODialog';";
        };
    };
};

class FDC_MTODialog
{
    idd = 9400;
    movingEnable = 0;
    enableSimulation = 1;
    class controlsBackground { class Background: FDC_Background {}; };
    class controls
    {
        class Title: FDC_Title { text = "MTO"; };
        class NextButton: FDC_NextButton
        {
            idc = 9401;
            text = "Tovabb";
            onButtonClick = "closeDialog 0;";
        };
    };
};
