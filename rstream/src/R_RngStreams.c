/*****************************************************************************
 *                                                                           *
 *   File:         R_RngStreams.c                                            *
 *   Title:        Wrapper for Pierre L'Ecuyer's RngStreams library          *
 *                 for multiple streams of Random Numbers                    *
 *   Authors: :    Josef Leydold and Guenter Tirler, WU Wien, Austria        *
 *   Copyright:    GPL version 2                                             *
 *   Date:         2004-05-22                                                *
 *                                                                           *
 *****************************************************************************/

/* $Id: R_RngStreams.c,v 1.13 2004/10/21 11:01:03 leydold Exp $ */

/*---------------------------------------------------------------------------*/

#include <R.h>
#include <Rdefines.h>
#include <Rinternals.h>

#include "R_RNG.h"
#include "RngStreams.h"
#include "R_RngStreams.h"

/*---------------------------------------------------------------------------*/

static void R_RngStreams_free (SEXP R_stream);
/* Free Stream generator object. */

/*---------------------------------------------------------------------------*/

/* Check pointer to generator object */
#define CHECK_STREAM_PTR(s) do { \
    if (TYPEOF(s) != EXTPTRSXP || R_ExternalPtrTag(s) != RngStreams_tag) \
        error("bad Stream object\n"); \
    } while (0)

#define CHECK_NULL(s) do { \
    if ((s)==NULL) error("invalid NULL pointer\n"); } while(0)

/*---------------------------------------------------------------------------*/

/* Use an external reference to store the Stream generator objects */
static SEXP RngStreams_tag = NULL;

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_SetPackageSeed (SEXP R_seed)
     /*----------------------------------------------------------------------*/
     /* Set global seed for RNGStreams package.                              */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_seed ... (double [6]) ... seed                                   */
     /*----------------------------------------------------------------------*/
{
  int n_seed;
  unsigned long seed[6];
  int i;

  /* get data */
  PROTECT(R_seed = AS_NUMERIC(R_seed));
  n_seed = LENGTH(R_seed);

  /* we need array of 6 unsigned long */
  if (n_seed<6) {
    UNPROTECT(1);
    error("too few values for seed\n");
  }

  for (i=0; i<6; i++)
      seed[i] = (unsigned long) NUMERIC_POINTER(R_seed)[i];

  UNPROTECT(1);

  /* set seed */
  if (RngStream_SetPackageSeed(seed))
    error("invalid seed\n");

  return R_NilValue;

} /* end of R_RngStreams_SetPackageSeed() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_GetPackageSeed (void)
     /*----------------------------------------------------------------------*/
     /* Get global seed for RNGStreams package.                              */
     /*                                                                      */
     /* parameters: none                                                     */
     /*----------------------------------------------------------------------*/
{
  unsigned long seed[6];
  SEXP R_seed;
  int i;

  /* get data */
  RngStream_GetPackageSeed(seed);

  PROTECT(R_seed = NEW_NUMERIC(6));
  for (i=0; i<6; i++)
    NUMERIC_POINTER(R_seed)[i] = (double) seed[i];

  UNPROTECT(1);

  return R_seed;

} /* end of R_RngStreams_GetPackageSeed() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_Init (SEXP R_name)
     /*----------------------------------------------------------------------*/
     /* Create and initialize Stream generator object.                       */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_name ... (string) ... name of the Stream                         */
     /*                                                                      */
     /* return:                                                              */
     /*   pointer to Stream object                                           */
     /*----------------------------------------------------------------------*/
{
  SEXP R_newstream;
  RngStream newstream;   /* Notice: RngStream is a pointer to a structure */
  const char *name;

  /* make tag for R object */
  if (!RngStreams_tag) RngStreams_tag = install("RNGSTREAMS_TAG");

  /* check argument */
  if (!R_name || TYPEOF(R_name) != STRSXP)
    error("bad string\n");

  /* get pointer to argument string */
  name = CHAR(STRING_ELT(R_name,0));

  /* create Stream generator object */
  newstream = RngStream_CreateStream(name);

  /* this must not be a NULL pointer */
  if (newstream == NULL) 
    error("cannot create Stream object\n");

  /* make R external pointer and store pointer to Stream generator */
  PROTECT(R_newstream = R_MakeExternalPtr(newstream, RngStreams_tag, R_NilValue));
  UNPROTECT(1);
  
  /* register destructor as C finalizer */
  R_RegisterCFinalizer(R_newstream, R_RngStreams_free);

  /* return pointer to R */
  return R_newstream;

} /* end of R_RngStreams_init() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_SetAntithetic (SEXP R_stream, SEXP R_anti)
     /*----------------------------------------------------------------------*/
     /* Set flag for antithetic random numbers in Stream object.             */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream ... (pointer) ... pointer the Stream object               */
     /*   R_anti   ... (int)     ... flag (1=TRUE, 0=FALSE)                  */
     /*----------------------------------------------------------------------*/
{
  RngStream stream;
  int anti = INTEGER(R_anti)[0];

  /* check pointer */
  CHECK_STREAM_PTR(R_stream);

  /* Extract pointer to generator */
  stream = R_ExternalPtrAddr(R_stream);
  CHECK_NULL(stream);

  /* set flag */
  RngStream_SetAntithetic(stream, anti);

  return R_NilValue;

} /* end of R_RngStreams_Setantithetic() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_GetAntithetic (SEXP R_stream)
     /*----------------------------------------------------------------------*/
     /* Get flag for antithetic random numbers in Stream object.             */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream ... (pointer) ... pointer the Stream object               */
     /*                                                                      */
     /* return:                                                              */
     /*   antithetic flag                                                    */
     /*----------------------------------------------------------------------*/
{
  SEXP R_anti;
  RngStream stream;
  int anti;

  /* check pointer */
  CHECK_STREAM_PTR(R_stream);

  /* Extract pointer to generator */
  stream = R_ExternalPtrAddr(R_stream);
  CHECK_NULL(stream);

  /* get data */
  anti = stream->Anti;

  PROTECT(R_anti = NEW_INTEGER(1));
  INTEGER_POINTER(R_anti)[0] = anti;
  UNPROTECT(1);

  return R_anti;

} /* end of R_RngStreams_GetAntithetic() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_SetIncreasedPrecis (SEXP R_stream, SEXP R_incp)
     /*----------------------------------------------------------------------*/
     /* Set flag for increased precision in Stream object.                   */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream ... (pointer) ... pointer the Stream object               */
     /*   R_incp   ... (int)     ... flag (1=TRUE, 0=FALSE)                  */
     /*----------------------------------------------------------------------*/
{
  RngStream stream;
  int incp = INTEGER(R_incp)[0];

  /* check pointer */
  CHECK_STREAM_PTR(R_stream);

  /* Extract pointer to generator */
  stream = R_ExternalPtrAddr(R_stream);
  CHECK_NULL(stream);

  /* set flag */
  RngStream_IncreasedPrecis(stream, incp);

  return R_NilValue;

} /* end of R_RngStreams_IncreasedPrecis() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_GetIncreasedPrecis (SEXP R_stream)
     /*----------------------------------------------------------------------*/
     /* Get flag for increased precision in Stream object.                   */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream ... (pointer) ... pointer the Stream object               */
     /*                                                                      */
     /* return:                                                              */
     /*   increased precision flag                                           */
     /*----------------------------------------------------------------------*/
{
  SEXP R_incp;
  RngStream stream;
  int incp;

  /* check pointer */
  CHECK_STREAM_PTR(R_stream);

  /* Extract pointer to generator */
  stream = R_ExternalPtrAddr(R_stream);
  CHECK_NULL(stream);

  /* get data */
  incp = stream->IncPrec;

  PROTECT(R_incp = NEW_INTEGER(1));
  INTEGER_POINTER(R_incp)[0] = incp;
  UNPROTECT(1);

  return R_incp;

} /* end of R_RngStreams_GetIncreasedPrecis() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_Sample (SEXP R_stream, SEXP R_size)
     /*----------------------------------------------------------------------*/
     /* Sample from Stream object.                                           */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream ... (pointer) ... pointer the Stream object               */
     /*   R_size   ... (int)     ... sample size                             */
     /*                                                                      */
     /* return:                                                              */
     /*   pointer to stream object                                           */
     /*----------------------------------------------------------------------*/
{
  RngStream stream;
  int n = INTEGER(R_size)[0];
  int i;
  SEXP R_sample;

  /* check pointer */
  CHECK_STREAM_PTR(R_stream);

  /* Extract pointer to generator */
  stream = R_ExternalPtrAddr(R_stream);
  CHECK_NULL(stream);

  /* generate random sample of size n */
  PROTECT(R_sample = NEW_NUMERIC(n));
  for (i=0; i<n; i++)
    NUMERIC_POINTER(R_sample)[i] = RngStream_RandU01(stream);
  UNPROTECT(1);

  /* return sample to R */
  return R_sample;
 
} /* end of R_RngStreams_sample() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_ResetStartStream (SEXP R_stream)
     /*----------------------------------------------------------------------*/
     /* Reset Stream object.                                                 */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream ... (pointer) ... pointer the Stream object               */
     /*----------------------------------------------------------------------*/
{
  RngStream stream;

  /* check pointer */
  CHECK_STREAM_PTR(R_stream);

  /* Extract pointer to generator */
  stream = R_ExternalPtrAddr(R_stream);
  CHECK_NULL(stream);

  /* reset */
  RngStream_ResetStartStream(stream);

  return R_NilValue;
} /* end of R_RngStreams_ResetStartStream() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_ResetStartSubstream (SEXP R_stream)
     /*----------------------------------------------------------------------*/
     /* Reset current substream (jump to begining of current substream).     */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream ... (pointer) ... pointer the Stream object               */
     /*----------------------------------------------------------------------*/
{
  RngStream stream;

  /* check pointer */
  CHECK_STREAM_PTR(R_stream);

  /* Extract pointer to generator */
  stream = R_ExternalPtrAddr(R_stream);
  CHECK_NULL(stream);

  /* reset */
  RngStream_ResetStartSubstream(stream);

  return R_NilValue;
} /* end of R_RngStreams_ResetStartSubstream() */

SEXP R_RngStreams_ResetNextSubstream (SEXP R_stream)
     /*----------------------------------------------------------------------*/
     /* Go to begining of next substream.                                    */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream ... (pointer) ... pointer the Stream object               */
     /*----------------------------------------------------------------------*/
{
  RngStream stream;

  /* check pointer */
  CHECK_STREAM_PTR(R_stream);

  /* Extract pointer to generator */
  stream = R_ExternalPtrAddr(R_stream);
  CHECK_NULL(stream);

  /* reset */
  RngStream_ResetNextSubstream(stream);

  return R_NilValue;
} /* end of R_RngStreams_ResetNextSubstream() */

/*---------------------------------------------------------------------------*/

void R_RngStreams_free (SEXP R_stream)
     /*----------------------------------------------------------------------*/
     /* Free Stream generator object.                                        */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream ... (pointer) ... pointer the Stream object               */
     /*----------------------------------------------------------------------*/
{
  RngStream stream;

  /* check pointer */
  CHECK_STREAM_PTR(R_stream);

  /* Extract pointer to generator */
  stream = R_ExternalPtrAddr(R_stream);
  CHECK_NULL(stream);

  /* free generator object */
  RngStream_DeleteStream (&stream);
  R_ClearExternalPtr(R_stream);

} /* end of R_RngStreams_free() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_Free (SEXP R_stream)
     /*----------------------------------------------------------------------*/
     /* Free Stream generator object.                                        */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream ... (pointer) ... pointer the Stream object               */
     /*                                                                      */
     /* return:                                                              */
     /*   NULL                                                               */
     /*----------------------------------------------------------------------*/
{
  R_RngStreams_free(R_stream);
  return R_NilValue;
} /* end of R_RngStreams_Free() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_Clone (SEXP R_stream, SEXP R_name)
     /*----------------------------------------------------------------------*/
     /* Make a clone (copy) of Stream object.                                */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream ... (pointer) ... pointer the Stream object               */
     /*   R_name   ... (string) ... name of the Stream                       */
     /*                                                                      */
     /* return:                                                              */
     /*   pointer to cloned Stream object                                    */
     /*----------------------------------------------------------------------*/
{
  SEXP R_clone;
  RngStream stream, clone;
  const char *name;
  size_t len;

  /* check argument */
  CHECK_STREAM_PTR(R_stream);
  if (!R_name || TYPEOF(R_name) != STRSXP)
    error("bad string\n");

  /* Extract pointer to Stream */
  stream = R_ExternalPtrAddr(R_stream);
  CHECK_NULL(stream);

  /* get pointer to argument string */
  name = CHAR(STRING_ELT(R_name,0));

  /* make clone */
  clone = malloc(sizeof(struct RngStream_InfoState));
  if (clone == NULL) 
    error("no more memory\n");
  memcpy(clone,stream,sizeof(struct RngStream_InfoState));
 
  /* we also need a name */
  len = strlen(name);
  clone->name = malloc(len + 1);
  if (clone->name == NULL) {
    free(clone);
    error("no more memory\n");
  }
  strncpy(clone->name, name, len+1);

  /* make R external pointer and store pointer to Stream generator */
  PROTECT(R_clone = R_MakeExternalPtr(clone, RngStreams_tag, R_NilValue));
  UNPROTECT(1);
  
  /* register destructor as C finalizer */
  R_RegisterCFinalizer(R_clone, R_RngStreams_free);

  /* return pointer to R */
  return R_clone;

} /* end of R_RngStreams_Clone() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_SetName (SEXP R_stream, SEXP R_name)
     /*----------------------------------------------------------------------*/
     /* Set name of Stream object.                                           */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream ... (pointer) ... pointer the Stream object               */
     /*   R_name   ... (string)  ... new name of the Stream                  */
     /*                                                                      */
     /* return:                                                              */
     /*   pointer to Stream object                                           */
     /*----------------------------------------------------------------------*/
{
  RngStream stream;
  char *name, *newname;
  size_t len;

  /* check pointer */
  CHECK_STREAM_PTR(R_stream);

  /* Extract pointer to generator */
  stream = R_ExternalPtrAddr(R_stream);
  CHECK_NULL(stream);

  /* get name */
  name = CHAR(STRING_ELT(R_name,0));
  len = strlen(name);

  /* allocate memory */
  newname = malloc(len+1);
  if (newname == NULL)
    error("cannot set new name: no more memory\n");
  free(stream->name);

  /* copy name */
  strncpy(newname, name, len+1);
  stream->name = newname;

  return R_NilValue;

} /* end of R_RngStreams_SetName() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_GetName (SEXP R_stream)
     /*----------------------------------------------------------------------*/
     /* Get name of Stream object.                                           */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream ... (pointer) ... pointer the Stream object               */
     /*                                                                      */
     /* return:                                                              */
     /*   name (string)                                                      */
     /*----------------------------------------------------------------------*/
{
  RngStream stream;
  SEXP R_name;

  /* check pointer */
  CHECK_STREAM_PTR(R_stream);

  /* Extract pointer to generator */
  stream = R_ExternalPtrAddr(R_stream);
  CHECK_NULL(stream);

  /* get name of object */
  PROTECT(R_name = NEW_STRING(1));
  SET_STRING_ELT(R_name, 0, mkChar(stream->name));
  UNPROTECT(1);

  /* return name to R */
  return R_name;

} /* end of R_RngStreams_GetName() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_GetData (SEXP R_stream)
     /*----------------------------------------------------------------------*/
     /* Get data structure of Stream object.                                 */
     /* (For the name of the Stream object use R_RngStreams_GetName() ).     */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream ... (pointer) ... pointer the Stream object               */
     /*                                                                      */
     /* return:                                                              */
     /*   data (double[20])                                                  */
     /*----------------------------------------------------------------------*/
{
  RngStream stream;
  SEXP R_stream_data;

  /* check pointer */
  CHECK_STREAM_PTR(R_stream);

  /* Extract pointer to generator */
  stream = R_ExternalPtrAddr(R_stream);
  CHECK_NULL(stream);

  PROTECT(R_stream_data = NEW_NUMERIC(20));
  memcpy(NUMERIC_POINTER(R_stream_data)   , stream->Cg, 6*sizeof(double));
  memcpy(NUMERIC_POINTER(R_stream_data)+ 6, stream->Bg, 6*sizeof(double));
  memcpy(NUMERIC_POINTER(R_stream_data)+12, stream->Ig, 6*sizeof(double));
  NUMERIC_POINTER(R_stream_data)[18] = (double) stream->Anti;
  NUMERIC_POINTER(R_stream_data)[19] = (double) stream->IncPrec;

  UNPROTECT(1);
  
  /* return data to R */
  return R_stream_data;

} /* end of R_RngStreams_GetData() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_SetData (SEXP R_stream_data, SEXP R_name)
     /*----------------------------------------------------------------------*/
     /* Create and initialize Stream generator object and                    */
     /* set data structure of Stream object.                                 */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream_data ... (double[20]) ... pointer the Stream object       */
     /*   R_name        ... (string)     ... name of the Stream              */
     /*                                                                      */
     /* return:                                                              */
     /*   pointer to Stream object                                           */
     /*----------------------------------------------------------------------*/
{
  RngStream newstream;
  SEXP R_newstream;
  const char *name;
  size_t len;

  /* check argument */
  if (!R_name || TYPEOF(R_name) != STRSXP)
    error("bad string\n");
  if (LENGTH(R_stream_data) != 20) {
    error("invalid data for Stream object\n");
  }

  /* get name */
  name = CHAR(STRING_ELT(R_name,0));
  len = strlen(name);

  /* allocate memory */
  newstream = malloc(sizeof(struct RngStream_InfoState));
  if (newstream == NULL) {
    error("no more memory\n");
  }
  newstream->name = malloc(len+1);
  if (newstream->name == NULL) {
    free(newstream);
    error("no more memory\n");
  }

  /* copy data */
  PROTECT(R_stream_data = AS_NUMERIC(R_stream_data));
  memcpy(newstream->Cg, NUMERIC_POINTER(R_stream_data)   , 6*sizeof(double));
  memcpy(newstream->Bg, NUMERIC_POINTER(R_stream_data)+ 6, 6*sizeof(double));
  memcpy(newstream->Ig, NUMERIC_POINTER(R_stream_data)+12, 6*sizeof(double));
  newstream->Anti    = (int) NUMERIC_POINTER(R_stream_data)[18];
  newstream->IncPrec = (int) NUMERIC_POINTER(R_stream_data)[19];
  strncpy(newstream->name, name, len+1);
  UNPROTECT(1);

  /* make R external pointer and store pointer to Stream generator */
  PROTECT(R_newstream = R_MakeExternalPtr(newstream, RngStreams_tag, R_NilValue));
  UNPROTECT(1);
  
  /* register destructor as C finalizer */
  R_RegisterCFinalizer(R_newstream, R_RngStreams_free);

  /* return Stream object to R */
  return R_newstream;

} /* end of R_RngStreams_SetData() */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_setRNG (SEXP R_stream)
     /*----------------------------------------------------------------------*/
     /* Set Stream as current global generator in R.                         */
     /*                                                                      */
     /* parameters:                                                          */
     /*   R_stream ... (pointer) ... pointer the Stream object               */
     /*                                                                      */
     /* return:                                                              */
     /*   data (double[20])                                                  */
     /*----------------------------------------------------------------------*/
{
  RngStream stream;

  /* check pointer */
  CHECK_STREAM_PTR(R_stream);

  /* Extract pointer to generator */
  stream = R_ExternalPtrAddr(R_stream);
  CHECK_NULL(stream);

  /* Set Stream as global current RNG */
  rstream_setRNG((RSTREAM_SAMPLE_FUNC*) RngStream_RandU01, stream);

  return R_NilValue;
} /* end of R_RngStreams_setRNG() */

/*---------------------------------------------------------------------------*/
