class CfgVehicles {
    class NATO_Box_Base;
    class ACE_BaseCrate: NATO_Box_Base {
        author = ECSTRING(common,ACETeam);
        scope = 0;
        scopeCurator = 0;
    };
    class ACE_Crate_Medium_Empty: ACE_BaseCrate {
        scope = 2;
        scopeCurator = 2;
        displayName = "ACE Crate Medium Empty";
        model = PATHTOF(data\ACE_crate_medium.p3d);
        hiddenselection[] = {"Crate","Logo1","Logo2","Logo3","Logo4","Logo5","Logo6","Logo7","Logo8","Logo9","Logo10","Logo11","Logo12","Logo13","Logo14","Logo15","Logo16","Text1","Text2","Text3","Text4"};
        hiddenSelectionsTextures[] = {QUOTE(PATHTOF(data\ACE_crate_co.paa)),"","","","","","","","","","","","","","","","","","","",""};
    };
};
