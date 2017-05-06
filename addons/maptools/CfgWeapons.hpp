class CfgWeapons {
    class ACE_ItemCore;
    class ACE_ItemInfo;

    class ACE_MapTools: ACE_ItemCore {
        displayName = CSTRING(Name);
        descriptionShort = CSTRING(Description);
        model = QPATHTOF(data\ace_MapTools.p3d);
        picture = QPATHTOF(UI\maptool_item.paa);
        scope = 2;
        class ItemInfo: ACE_ItemInfo {
            mass = 1;
        };
    };
};
