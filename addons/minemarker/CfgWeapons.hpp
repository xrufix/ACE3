class CfgWeapons {
    class ACE_ItemCore;
    class InventoryItem_Base_F;

    class GVAR(Item_Flag): ACE_ItemCore {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Flag_DisplayName);
        picture = QPATHTOF(data\item_minemarkerflag_ca.paa);
        model = QPATHTOF(data\ace_item_minemarker_flag.p3d);

        class ItemInfo: InventoryItem_Base_F {
            mass = 1;
        };
    };
};
