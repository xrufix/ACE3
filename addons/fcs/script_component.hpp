#define COMPONENT fcs
#include "\z\ace\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_FCS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_FCS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_FCS
#endif

#define FCS_INTERVAL 0.1
#define DIFFANGLE(old,new) ((((new - old) mod 360) + 540) mod 360) - 180

#include "\z\ace\addons\main\script_macros.hpp"
