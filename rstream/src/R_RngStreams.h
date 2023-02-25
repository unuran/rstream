/*****************************************************************************
 *                                                                           *
 *   File:         R_RngStreams.h                                            *
 *   Title:        Wrapper for Pierre L'Ecuyer's RngStreams library          *
 *                 for multiple streams of Random Numbers                    *
 *   Authors: :    Josef Leydold and Guenter Tirler, WU Wien, Austria        *
 *   Copyright:    GPL version 2                                             *
 *   Date:         2004-05-22                                                *
 *                                                                           *
 *****************************************************************************/

/* $Id: R_RngStreams.h,v 1.12 2004/10/21 11:01:03 leydold Exp $ */

/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_SetPackageSeed (SEXP R_seed);
SEXP R_RngStreams_GetPackageSeed (void);
/*---------------------------------------------------------------------------*/
/* Set and get global seed for RNGStreams package.                           */
/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_Init (SEXP R_name);
/*---------------------------------------------------------------------------*/
/* Create and initinalize Stream generator object.                           */
/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_SetAntithetic (SEXP R_stream, SEXP R_anti);
SEXP R_RngStreams_GetAntithetic (SEXP R_stream);
/*---------------------------------------------------------------------------*/
/* Set and get flag for antithetic random numbers in Stream object.          */
/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_SetIncreasedPrecis (SEXP R_stream, SEXP R_incp);
SEXP R_RngStreams_GetIncreasedPrecis (SEXP R_stream);
/*---------------------------------------------------------------------------*/
/* Set and get flag for increased precision in Stream object.                */
/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_Sample (SEXP R_stream, SEXP R_size);
/*---------------------------------------------------------------------------*/
/* Sample from Stream object.                                                */
/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_ResetStartStream (SEXP R_stream);
/*---------------------------------------------------------------------------*/
/* Reset Stream object.                                                      */
/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_ResetStartSubstream (SEXP R_stream);
SEXP R_RngStreams_ResetNextSubstream (SEXP R_stream);
/*---------------------------------------------------------------------------*/
/* Goto to begining of current and next substream, respectively.             */
/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_Clone (SEXP R_stream, SEXP R_name);
/*---------------------------------------------------------------------------*/
/* Make a clone (copy) of Stream object.                                     */
/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_SetName (SEXP R_stream, SEXP R_name);
SEXP R_RngStreams_GetName (SEXP R_stream);
/*---------------------------------------------------------------------------*/
/* Set and get name of Stream object.                                        */
/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_GetData (SEXP R_stream);
/*---------------------------------------------------------------------------*/
/* Get data structure of Stream object.                                      */
/* (For the name of the Stream object use R_RngStreams_GetName() ).          */
/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_SetData (SEXP R_stream_data, SEXP R_name);
/*---------------------------------------------------------------------------*/
/* Create and initialize Stream generator object and                         */
/* set data structure of Stream object.                                      */
/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_Free (SEXP R_stream);
/*---------------------------------------------------------------------------*/
/* Free Stream generator object.                                             */
/*---------------------------------------------------------------------------*/

SEXP R_RngStreams_setRNG (SEXP R_stream);
/*---------------------------------------------------------------------------*/
/* Set Stream as current global generator in R.                              */
/*---------------------------------------------------------------------------*/

