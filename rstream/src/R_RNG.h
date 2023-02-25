/*****************************************************************************
 *                                                                           *
 *   File:         R_RNG.h                                                   *
 *   Title:        Interface between external RNGs and R runif() function    *
 *   Authors: :    Josef Leydold and Guenter Tirler, WU Wien, Austria        *
 *   Copyright:    GPL version 2                                             *
 *   Date:         2004-05-22                                                *
 *                                                                           *
 *****************************************************************************/

/* $Id: R_RNG.h,v 1.1 2004/05/26 15:55:06 leydold Exp $ */

/*---------------------------------------------------------------------------*/

/* sampling function and structure to store generator */
typedef double RSTREAM_SAMPLE_FUNC( void *gen );

struct rstream_gen {
  RSTREAM_SAMPLE_FUNC *sample;
  void *state;
};

/*---------------------------------------------------------------------------*/

/* Set Stream as global current RNG */
void rstream_setRNG( RSTREAM_SAMPLE_FUNC *sample, void *state);

/*---------------------------------------------------------------------------*/
