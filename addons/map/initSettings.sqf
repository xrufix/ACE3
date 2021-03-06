[
    QGVAR(mapIllumination),
    "CHECKBOX",
    [localize LSTRING(MapIllumination_DisplayName), localize LSTRING(MapIllumination_Description)],
    format["ACE %1", localize LSTRING(Module_DisplayName)],
    true,
    true
] call CBA_settings_fnc_init;

[
    QGVAR(mapGlow),
    "CHECKBOX",
    [localize LSTRING(MapGlow_DisplayName), localize LSTRING(MapGlow_Description)],
    format["ACE %1", localize LSTRING(Module_DisplayName)],
    true,
    true
] call CBA_settings_fnc_init;

[
    QGVAR(mapShake),
    "CHECKBOX",
    [localize LSTRING(MapShake_DisplayName), localize LSTRING(MapShake_Description)],
    format["ACE %1", localize LSTRING(Module_DisplayName)],
    true,
    true
] call CBA_settings_fnc_init;

[
    QGVAR(mapLimitZoom),
    "CHECKBOX",
    [localize LSTRING(MapLimitZoom_DisplayName), localize LSTRING(MapLimitZoom_Description)],
    format["ACE %1", localize LSTRING(Module_DisplayName)],
    false,
    true
] call CBA_settings_fnc_init;

[
    QGVAR(mapShowCursorCoordinates),
    "CHECKBOX",
    [localize LSTRING(MapShowCursorCoordinates_DisplayName), localize LSTRING(MapShowCursorCoordinates_Description)],
    format["ACE %1", localize LSTRING(Module_DisplayName)],
    false,
    true
] call CBA_settings_fnc_init;

[
    QGVAR(DefaultChannel),
    "LIST",
    [localize LSTRING(DefaultChannel_DisplayName), localize LSTRING(DefaultChannel_Description)],
    format["ACE %1", localize LSTRING(Module_DisplayName)],
    [[-1, 0, 1, 2, 3, 4, 5], [ELSTRING(common,Disabled), "STR_channel_global", "STR_channel_side", "STR_channel_command", "STR_channel_group", "STR_channel_vehicle", "STR_channel_direct"], 0],
    true
] call CBA_settings_fnc_init;

// Blue Force Tracking
[
    QGVAR(BFT_Enabled),
    "CHECKBOX",
    [localize LSTRING(BFT_Enabled_DisplayName), localize LSTRING(BFT_Enabled_Description)],
    [format ["ACE %1", localize LSTRING(Module_DisplayName)], localize LSTRING(BFT_Module_DisplayName)],
    false,
    true
] call CBA_settings_fnc_init;

[
    QGVAR(BFT_Interval),
    "SLIDER",
    [localize LSTRING(BFT_Interval_DisplayName), localize LSTRING(BFT_Interval_Description)],
    [format ["ACE %1", localize LSTRING(Module_DisplayName)], localize LSTRING(BFT_Module_DisplayName)],
    [0, 30, 1, 1],
    true
] call CBA_settings_fnc_init;

[
    QGVAR(BFT_ShowPlayerNames),
    "CHECKBOX",
    [localize LSTRING(BFT_ShowPlayerNames_DisplayName), localize LSTRING(BFT_ShowPlayerNames_Description)],
    [format ["ACE %1", localize LSTRING(Module_DisplayName)], localize LSTRING(BFT_Module_DisplayName)],
    false,
    true
] call CBA_settings_fnc_init;

[
    QGVAR(BFT_HideAiGroups),
    "CHECKBOX",
    [localize LSTRING(BFT_HideAiGroups_DisplayName), localize LSTRING(BFT_HideAiGroups_Description)],
    [format ["ACE %1", localize LSTRING(Module_DisplayName)], localize LSTRING(BFT_Module_DisplayName)],
    false,
    true
] call CBA_settings_fnc_init;
