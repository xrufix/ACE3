class CfgVehicles {
    class Box_NATO_Support_F;
    class ACE_Box_Misc: Box_NATO_Support_F {
        class TransportItems {
            MACRO_ADDITEM(GVAR(Item_Flag),5);
        };
    };

    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Explosives {
                class ACE_Mark {
                    displayName = CSTRING(Mark);
                    condition = "true";//condition = QUOTE(_player call FUNC(hasMarker));
                    statement = "true";
                    showDisabled = 0;
                    priority = 0.1;
                    icon = "";//@todo
                    class GVAR(flag) {
                        displayName = CSTRING(Flag_DisplayName);
                        condition = QUOTE([ARR_2(_player,'GVAR(Item_Flag)')] call FUNC(canPlace));
                        statement = QUOTE([ARR_3(_player,'GVAR(Item_Flag)','GVAR(Flag)')] call FUNC(place));
                        showDisabled = 0;
                        priority = 0.1;
                        icon = ""; //@todo
                    };
                };
            };
        };
    };

    class FlagCarrier;
    class GVAR(Flag): FlagCarrier {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Flag_DisplayName);
        model = QPATHTOF(data\ace_minemarker_flag.p3d);
    };
};
