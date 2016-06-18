#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {
            QGVAR(Flag)
        };
        weapons[] = {
            QGVAR(Item_Flag)
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_explosives"};
        author = ECSTRING(common,ACETeam);
        authors[] = {"Jonpas"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
