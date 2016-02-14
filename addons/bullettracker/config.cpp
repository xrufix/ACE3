#include "script_component.hpp"
class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_common"};
        author[] = {"esteldunedain","nou","jaynus"};
        VERSION_CONFIG;
    };
};

#include "CfgEventhandlers.hpp"
#include "ACE_Settings.hpp"
