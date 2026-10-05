class FDC_Background { idc=-1; type=0; style=0; x=0.18; y=0.12; w=0.64; h=0.76; colorBackground[]={0,0,0,1}; colorText[]={1,1,1,1}; font="RobotoCondensed"; sizeEx=0.035; text=""; };
class FDC_Title { idc=-1; type=0; style=2; x=0.20; y=0.15; w=0.60; h=0.06; colorBackground[]={0.12,0.12,0.12,1}; colorText[]={1,1,1,1}; font="RobotoCondensed"; sizeEx=0.045; text=""; };
class FDC_Label { idc=-1; type=0; style=0; x=0.22; y=0.24; w=0.20; h=0.045; colorBackground[]={0,0,0,0}; colorText[]={1,1,1,1}; font="RobotoCondensed"; sizeEx=0.032; text=""; };
class FDC_Edit { idc=-1; type=2; style=0; x=0.43; y=0.24; w=0.32; h=0.045; text=""; font="RobotoCondensed"; sizeEx=0.032; colorText[]={1,1,1,1}; colorDisabled[]={0.4,0.4,0.4,1}; colorSelection[]={0.3,0.3,0.3,1}; autocomplete=""; colorBackground[]={0.12,0.12,0.12,1}; };
class FDC_Combo { idc=-1; type=4; style=0x10+0x200; x=0.43; y=0.24; w=0.32; h=0.045; colorSelect[]={1,1,1,1}; colorText[]={1,1,1,1}; colorBackground[]={0.12,0.12,0.12,1}; colorSelectBackground[]={0.25,0.25,0.25,1}; colorScrollbar[]={1,1,1,1}; colorDisabled[]={0.4,0.4,0.4,1}; colorPicture[]={1,1,1,1}; colorPictureSelected[]={1,1,1,1}; colorPictureDisabled[]={0.4,0.4,0.4,1}; arrowEmpty="\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa"; arrowFull="\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa"; wholeHeight=0.30; maxHistoryDelay=1; font="RobotoCondensed"; sizeEx=0.032; soundSelect[]={"",0.1,1}; soundExpand[]={"",0.1,1}; soundCollapse[]={"",0.1,1}; class ComboScrollBar { color[]={1,1,1,1}; colorActive[]={1,1,1,1}; colorDisabled[]={1,1,1,0.3}; thumb="\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; arrowEmpty="\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; arrowFull="\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; border="\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; shadow=0; scrollSpeed=0.06; width=0; height=0; autoScrollEnabled=0; autoScrollSpeed=-1; autoScrollDelay=5; autoScrollRewind=0; }; };
class FDC_Button { idc=-1; type=1; style=2; x=0.62; y=0.80; w=0.14; h=0.05; text="Tovabb"; font="RobotoCondensed"; sizeEx=0.032; colorText[]={1,1,1,1}; colorDisabled[]={0.4,0.4,0.4,1}; colorBackground[]={0.2,0.2,0.2,1}; colorBackgroundDisabled[]={0.1,0.1,0.1,1}; colorBackgroundActive[]={0.3,0.3,0.3,1}; colorFocused[]={0.3,0.3,0.3,1}; colorShadow[]={0,0,0,1}; colorBorder[]={0,0,0,1}; soundEnter[]={"",0.1,1}; soundPush[]={"",0.1,1}; soundClick[]={"",0.1,1}; soundEscape[]={"",0.1,1}; shadow=0; borderSize=0; offsetX=0; offsetY=0; offsetPressedX=0; offsetPressedY=0; };

class FDC_ContactDialog {
 idd=9100; movingEnable=0; enableSimulation=1; onLoad="[] spawn { disableSerialization; waitUntil {!isNull (findDisplay 9100)}; private _c=(findDisplay 9100) displayCtrl 9110; private _items=['Beloves','Hatastuz','Azonnali lefogas','Azonnali kodosites','Beloves polarisan','Tuzathelyezes ismert pontrol']; lbClear _c; {_c lbAdd _x;} forEach _items; private _saved=missionNamespace getVariable ['FDC_missionType','Beloves']; private _idx=_items find _saved; if (_idx < 0) then {_idx=0;}; _c lbSetCurSel _idx; };";
 class controlsBackground { class Background:FDC_Background{}; };
 class controls {
  class Title:FDC_Title { text="1. ADAS - KAPCSOLATFELVETEL"; };
  class L1:FDC_Label { y=0.28; text="Tuzfeladat:"; };
  class Mission:FDC_Combo { idc=9110; y=0.28; };
  class Next:FDC_Button { idc=9101; onButtonClick="[] call FDC_fnc_saveContact; closeDialog 0; createDialog 'FDC_CoordinateDialog';"; };
 };
};

class FDC_CoordinateDialog {
 idd=9200; movingEnable=0; enableSimulation=1; onLoad="[] call FDC_fnc_initCoordinateDialog";
 class controlsBackground { class Background:FDC_Background{}; };
 class controls {
  class Title:FDC_Title { text="2. ADAS - KOORDINATA"; };
  class LMode:FDC_Label { y=0.23; text="Helymeghatarozas:"; }; class Mode:FDC_Combo { idc=9210; y=0.23; onLBSelChanged="[] call FDC_fnc_coordinateModeChanged"; };
  class L1:FDC_Label { idc=9220; y=0.30; }; class E1:FDC_Edit { idc=9230; y=0.30; maxChars=5; };
  class L2:FDC_Label { idc=9221; y=0.36; }; class E2:FDC_Edit { idc=9231; y=0.36; maxChars=5; };
  class L3:FDC_Label { idc=9222; y=0.42; }; class E3:FDC_Edit { idc=9232; y=0.42; };
  class L4:FDC_Label { idc=9223; y=0.48; }; class E4:FDC_Edit { idc=9233; y=0.48; maxChars=4; }; class LR:FDC_Combo { idc=9240; x=0.43; y=0.48; w=0.12; };
  class L5:FDC_Label { idc=9224; y=0.54; }; class E5:FDC_Edit { idc=9234; y=0.54; }; class NF:FDC_Combo { idc=9241; x=0.43; y=0.54; w=0.12; };
  class L6:FDC_Label { idc=9225; y=0.60; }; class E6:FDC_Edit { idc=9235; y=0.60; maxChars=4; };
  class Back:FDC_Button { x=0.46; y=0.80; text="Vissza"; onButtonClick="[] call FDC_fnc_saveCoordinate; closeDialog 0; createDialog 'FDC_ContactDialog';"; };
  class Next:FDC_Button { onButtonClick="[] call FDC_fnc_saveCoordinate; closeDialog 0; createDialog 'FDC_TargetTypeDialog';"; };
 };
};

class FDC_TargetTypeDialog {
 idd=9300; movingEnable=0; enableSimulation=1; onLoad="[] call FDC_fnc_initTargetDialog";
 class controlsBackground { class Background:FDC_Background{}; };
 class controls {
  class Title:FDC_Title { text="3. ADAS - CEL JELLEGE"; };
  class L1:FDC_Label { y=0.23; text="Cel jellege:"; }; class E1:FDC_Edit { idc=9310; y=0.23; };
  class L2:FDC_Label { y=0.29; text="Elhelyezkedes:"; }; class E2:FDC_Edit { idc=9311; y=0.29; };
  class L3:FDC_Label { y=0.35; text="Szelesseg (m):"; }; class E3:FDC_Edit { idc=9312; y=0.35; };
  class L4:FDC_Label { y=0.41; text="Melyseg (m):"; }; class E4:FDC_Edit { idc=9313; y=0.41; };
  class L5:FDC_Label { y=0.47; text="Alak:"; }; class E5:FDC_Edit { idc=9314; y=0.47; };
  class L6:FDC_Label { y=0.53; text="Cel iranya (mils):"; }; class E6:FDC_Edit { idc=9315; y=0.53; maxChars=4; };
  class L7:FDC_Label { y=0.59; text="Granat:"; }; class C1:FDC_Combo { idc=9316; y=0.59; };
  class L8:FDC_Label { y=0.65; text="Gyujto:"; }; class C2:FDC_Combo { idc=9317; y=0.65; };
  class L9:FDC_Label { y=0.71; text="Roppalya:"; }; class C3:FDC_Combo { idc=9318; y=0.71; };
  class Back:FDC_Button { x=0.46; y=0.80; text="Vissza"; onButtonClick="[] call FDC_fnc_saveTarget; closeDialog 0; createDialog 'FDC_CoordinateDialog';"; };
  class Next:FDC_Button { onButtonClick="[] call FDC_fnc_saveTarget; closeDialog 0; createDialog 'FDC_MTODialog';"; };
 };
};

class FDC_MTODialog {
 idd=9400; movingEnable=0; enableSimulation=1; onLoad="[] call FDC_fnc_initMTODialog";
 class controlsBackground { class Background:FDC_Background{}; };
 class controls {
  class Title:FDC_Title { text="MTO"; };
  class L1:FDC_Label { y=0.25; text="Lovo alegyseg:"; }; class Unit:FDC_Combo { idc=9410; y=0.25; };
  class L2:FDC_Label { y=0.31; text="Cel szama:"; }; class TargetNo:FDC_Edit { idc=9411; y=0.31; };
  class L3:FDC_Label { y=0.37; text="Lovo lovegek:"; }; class Guns:FDC_Edit { idc=9412; y=0.37; };
  class L4:FDC_Label { y=0.43; text="Granat / loveg:"; }; class Rounds:FDC_Edit { idc=9413; y=0.43; };
  class L5:FDC_Label { y=0.49; text="Legkisebb ropido:"; }; class TOF:FDC_Label { idc=9414; x=0.43; y=0.49; w=0.32; text="-- s"; };
  class Back:FDC_Button { x=0.22; y=0.54; text="Vissza"; onButtonClick="closeDialog 0; createDialog 'FDC_TargetTypeDialog';"; };
  class Save:FDC_Button { x=0.22; y=0.60; text="Rogzites"; onButtonClick="[] call FDC_fnc_saveMTO"; };
  class Adjust:FDC_Button { x=0.38; y=0.60; text="Javitas"; onButtonClick="hint 'Javitas funkcio kovetkezik';"; };
  class AdjustFire:FDC_Button { x=0.54; y=0.67; text="Beloves"; onButtonClick="hint 'Beloves funkcio kovetkezik';"; };
  class FFE:FDC_Button { x=0.54; y=0.74; text="Hatastuz"; onButtonClick="hint 'Hatastuz funkcio kovetkezik';"; };
 };
};
