/*****************************************************************************
 *                                                                           *
 *   File:         R_RNG.c                                                   *
 *   Title:        Interface between external RNGs and R runif() function    *
 *   Authors: :    Josef Leydold and Guenter Tirler, WU Wien, Austria        *
 *   Copyright:    GPL version 2                                             *
 *   Date:         2004-05-22                                                *
 *                                                                           *
 *****************************************************************************/

/* $Id: R_RNG.c,v 1.1 2004/05/26 15:55:06 leydold Exp $ */

/*---------------------------------------------------------------------------*/

#include <R.h>
#include <Rdefines.h>
#include <Rinternals.h>
#include <R_ext/Random.h>

#include "R_RNG.h"

/*---------------------------------------------------------------------------*/

/* variable that hold random number to be returned */
static double U;

/* current stream */
static struct rstream_gen current_stream = {NULL, NULL};

/*---------------------------------------------------------------------------*/

double *user_unif_rand ()
     /* pointer for user-supplied RNG */
{
  if (current_stream.sample == NULL) error("Stream not initialized");

  /* compute number */
  U = current_stream.sample( current_stream.state );

  /* return result as pointer to U */
  return &U;
} /* end of user_unif_rand() */

/*---------------------------------------------------------------------------*/

void rstream_setRNG( RSTREAM_SAMPLE_FUNC *sample, void *state)
     /* Set Stream as global current RNG */
{
  if (sample == NULL || state == NULL)
    error("B: Invalid NULL pointer");

  current_stream.sample = sample;
  current_stream.state = state;
  
} /* end of R_rstream_setRNG() */

/*---------------------------------------------------------------------------*/
