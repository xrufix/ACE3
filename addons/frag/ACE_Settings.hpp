class ACE_Settings {
    class GVAR(Enabled) {
        category = CSTRING(Module_DisplayName);
        displayName = CSTRING(EnableFrag);
        description = CSTRING(EnableFrag_Desc);
        typeName = "BOOL";
        value = 1;
    };
    class GVAR(SpallEnabled) {
        category = CSTRING(Module_DisplayName);
        displayName = CSTRING(EnableSpall);
        description = CSTRING(EnableSpall_Desc);
        typeName = "BOOL";
        value = 0;
    };
    class GVAR(EnableDebugTrace) {
        category = CSTRING(Module_DisplayName);
        displayName = CSTRING(EnableDebugTrace);
        description = CSTRING(EnableDebugTrace_Desc);
        typeName = "BOOL";
        value = 0;
    };
};
