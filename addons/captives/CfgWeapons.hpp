class CfgWeapons {
    class ACE_ItemCore;
    class ACE_ItemInfo;

    class ACE_CableTie: ACE_ItemCore {
        displayName = CSTRING(CableTie);
        descriptionShort = CSTRING(CableTieDescription);
        model = QPATHTOF(models\ace_cabletie.p3d);
        picture = QPATHTOF(UI\ace_cabletie_ca.paa);
        scope = 2;
        class ItemInfo: ACE_ItemInfo {
            mass = 1;
        };
    };
};
