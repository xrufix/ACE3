#define COMPONENT bullettracker
#include "\z\ace\addons\main\script_mod.hpp"

//#define DEBUG_ENABLED_BULLETTRACKER
// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_BULLETTRACKER
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_BULLETTRACKER
    #define DEBUG_SETTINGS DEBUG_SETTINGS_BULLETTRACKER
#endif

#include "\z\ace\addons\main\script_macros.hpp"
