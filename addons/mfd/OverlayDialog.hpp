#include "script_component.hpp"


class GVAR(OverlayDialog) {
	idd = 69696969;
	movingEnable = 0;
	
	name = QGVAR(OverlayDialog);
	duration = 999999;
	fadein = 0;
	onUnload = QUOTE(_this call FUNC(onLoad));
	onLoad = QUOTE(_this call FUNC(onUnload));

	controlsBackground[] = {GVAR(BackgroundImage)};
	objects[] = {};
    
	class GVAR(BackgroundImage) {
		type = 0; // CT_STATIC
		idc = -1;
		style = 48 + 0x800; // ST_PICTURE + ST_KEEP_ASPECT_RATIO
		colorBackground[] = {0.2, 0.2, 0.2, 1};
		colorText[] = {1, 1, 1, 1};
		font = "PixelSplitterBold";
		sizeEx = 0.03;
		x = SafeZoneX;
		y = "(SafeZoneY + SafeZoneH) - (SafeZoneW * 0.35)";
		w = (SafeZoneW * 0.35);
		h = (SafeZoneW * 0.35);
        
		text = PATHTOF(data\interface_TAD_ca.paa);
	};
	
	class controls {
	
	};
};