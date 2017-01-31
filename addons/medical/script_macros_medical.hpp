// - Utility ------------------------------------------------------------------

// Getting variables from config with default values
#define GET_NUMBER(config,default) (if (isNumber (config)) then {getNumber (config)} else {default})
#define GET_STRING(config,default) (if (isText (config)) then {getText (config)} else {default})
#define GET_ARRAY(config,default) (if (isArray (config)) then {getArray (config)} else {default})
// scale received pain to 0-2 level to select type of scream
// below 0.25: 0, from 0.25 to 0.5: 1, more than 0.5: 2
#define PAIN_TO_SCREAM(pain) (floor (4 * pain) min 2)
// scale received pain to 0-2 level to select type of scream
// below 0.33: 0, from 0.34 to 0.66: 1, more than 0.67: 2
#define PAIN_TO_MOAN(pain) (floor (3 * pain) min 2)


// - Constants ----------------------------------------------------------------

// - General -

#define ALL_BODY_PARTS ["head", "body", "leftarm", "rightarm", "leftleg", "rightleg"]

// - Blood -

// Blood loss classifications
#define BLOOD_VOLUME_CLASS_1_HEMORRHAGE 6.000 // lost less than 15% blood, Class I Hemorrhage
#define BLOOD_VOLUME_CLASS_2_HEMORRHAGE 5.100 // lost more than 15% blood, Class II Hemorrhage
#define BLOOD_VOLUME_CLASS_3_HEMORRHAGE 4.200 // lost more than 30% blood, Class III Hemorrhage
#define BLOOD_VOLUME_CLASS_4_HEMORRHAGE 3.600 // lost more than 40% blood, Class IV Hemorrhage
// IV Change per second calculation:
// 250 ml should take 60 seconds to fill. 250 ml / 60 s ~ 4.1667 ml/s.
#define IV_CHANGE_PER_SECOND 4.1667 // in milliliters per second
// To be replaced by a proper blood pressure calculation
#define BLOOD_LOSS_KNOCK_OUT_THRESHOLD 0.5 // 50% of cardiac output

// - Pain -

// Minimum pain to knock a person out
#define PAIN_UNCONSCIOUS 0.5
// Pain fade out time (time it takes until pain is guaranteed to be completly gone)
#define PAIN_FADE_TIME 900
// Only relevant when advanced medication is disabled
// Morphine pain suppression fade out time (time it takes until pain suppression is guaranteed to be completly gone)
#define PAIN_SUPPRESSION_FADE_TIME 1800

// - Unconsciousness -

// Chance to wake up when vitals are stable (checked once every SPONTANEOUS_WAKE_UP_INTERVAL seconds)
#define SPONTANEOUS_WAKE_UP_CHANCE 0.2
#define SPONTANEOUS_WAKE_UP_INTERVAL 15

// - Damage -

// Minimum amount of damage required for penetrating wounds (also minDamage for velocity wounds)
#define PENETRATION_THRESHOLD 0.35
// Minimum damage for a head injury to be lethal
#define LETHAL_HEAD_DAMAGE_THRESHOLD 1.0
// Minimum leg damage required for limping
#define LIMPING_DAMAGE_THRESHOLD 0.30
// Minimum body part damage required for blood effect on uniform
#define VISUAL_BODY_DAMAGE_THRESHOLD 0.35


// - Default medical variable values ------------------------------------------
// Please add which variable the macro belongs to!

// heartRate
#define DEFAULT_HEART_RATE 80
// bloodVolume
// 0.077 l/kg * 80kg = 6.16l
#define DEFAULT_BLOOD_VOLUME 6.0 // in liters
// bloodPressure
#define DEFAULT_BLOOD_PRESSURE [80, 120]
// peripheralResistance
#define DEFAULT_PERIPHERAL_RESISTANCE 100
// bodyPartDamage
#define DEFAULT_BODY_PART_DAMAGE [0, 0, 0, 0, 0, 0]
// bodyPartStatus
#define DEFAULT_BODY_PART_STATUS [0, 0, 0, 0, 0, 0]
