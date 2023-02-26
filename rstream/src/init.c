
/*-------------------------------------------------------------------------*/

#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

#include "R_RngStreams.h"

/*-------------------------------------------------------------------------*/

static const R_CallMethodDef CallEntries[] = {
    {"R_RngStreams_Clone",               (DL_FUNC) &R_RngStreams_Clone,               3},
    {"R_RngStreams_Free",                (DL_FUNC) &R_RngStreams_Free,                1},
    {"R_RngStreams_GetAntithetic",       (DL_FUNC) &R_RngStreams_GetAntithetic,       1},
    {"R_RngStreams_GetData",             (DL_FUNC) &R_RngStreams_GetData,             1},
    {"R_RngStreams_GetIncreasedPrecis",  (DL_FUNC) &R_RngStreams_GetIncreasedPrecis,  1},
    {"R_RngStreams_GetName",             (DL_FUNC) &R_RngStreams_GetName,             1},
    {"R_RngStreams_GetPackageSeed",      (DL_FUNC) &R_RngStreams_GetPackageSeed,      0},
    {"R_RngStreams_Init",                (DL_FUNC) &R_RngStreams_Init,                2},
    {"R_RngStreams_ResetNextSubstream",  (DL_FUNC) &R_RngStreams_ResetNextSubstream,  1},
    {"R_RngStreams_ResetStartStream",    (DL_FUNC) &R_RngStreams_ResetStartStream,    1},
    {"R_RngStreams_ResetStartSubstream", (DL_FUNC) &R_RngStreams_ResetStartSubstream, 1},
    {"R_RngStreams_Sample",              (DL_FUNC) &R_RngStreams_Sample,              2},
    {"R_RngStreams_SetAntithetic",       (DL_FUNC) &R_RngStreams_SetAntithetic,       2},
    {"R_RngStreams_SetData",             (DL_FUNC) &R_RngStreams_SetData,             4},
    {"R_RngStreams_SetIncreasedPrecis",  (DL_FUNC) &R_RngStreams_SetIncreasedPrecis,  2},
    {"R_RngStreams_SetName",             (DL_FUNC) &R_RngStreams_SetName,             2},
    {"R_RngStreams_SetPackageSeed",      (DL_FUNC) &R_RngStreams_SetPackageSeed,      1},
    {"R_RngStreams_setRNG",              (DL_FUNC) &R_RngStreams_setRNG,              1},
    {NULL, NULL, 0}
};

/*-------------------------------------------------------------------------*/

void R_init_rstream(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, TRUE);
    /* If we set this to FALSE we get 
     *    Error in RNGkind(kind = "user-supplied") : 
     *    'user_unif_rand' not in load table
     */
}

/*-------------------------------------------------------------------------*/
