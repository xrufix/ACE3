
class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};
class Extended_Killed_EventHandlers {
    class ADDON {
        class ACE_BaseCrate {
            killed = QUOTE(call FUNC(handleKilled));
        };
    };

};
