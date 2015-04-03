class CfgVehicles {
    class LandVehicle;
    class StaticWeapon: LandVehicle {
        class ACE_Actions {
            class ACE_MainActions {
                class GVAR(DisAssemble) {
                    displayName = "Disassemble";
                    distance = 3;
                    condition = QUOTE(_this call FUNC(canDisassemble));
                    statement = QUOTE(_this call FUNC(doDisassemble));
                    exceptions[] = {};
                    // icon = QUOTE(PATHTOF(UI\captive_ca.paa));
                    priority = 2;
                    // hotkey = "E";
                };
            };
        };
    };
};
