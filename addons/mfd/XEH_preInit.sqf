#include "script_component.hpp"

ADDON = false;

// MFD API
PREP(registerMenu);
PREP(removeMenu);

// Graphical functions
PREP(draw);
PREP(setRowText);
PREP(clearDisplay);

// internal callbacks
PREP(onDraw);
PREP(onButtonPress);
PREP(onLoad);
PREP(onUnload);

// Internals
PREP(sortMenuPriorityList);

GVAR(menus) = HASH_CREATE;
GVAR(sortedMenus) = [];

GVAR(pfh) = nil;

ADDON = true;
