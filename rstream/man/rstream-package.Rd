\name{rstream-package}

\alias{rstream-package}
\alias{rstream}

\docType{package}

\title{"rstream" -- A package for multiple streams of uniform random numbers}

\description{
  Unified interface to uniform random number generators
}

\details{
\tabular{ll}{
Package: \tab rstream\cr
Type: \tab Package\cr
Version: \tab 1.3.5         \cr
Date: \tab 2017-06-21    \cr
License: \tab GPL 2 or later\cr
}

This package provides a unified interface to uniform random number
Objects of its classes act as a source of streams for random numbers
that can be handled by a set of methods and which can be used as
arguments of functions that require sources of randomness, e.g. discrete
event models, Monte Carlo integration or other stochastic simulations.

The instances of objects are independent, i.e., sampling random numbers
from one instance or reseting and changing its state does not effect any
other instance. (However, different streams may not be
\emph{stochastically} independent if they are not carefully seeded!)

Additionally there is a mechanismus interface to save and restore such
streams, e.g. for the next \R session, for a reruning some stochastic
calculations with identical input, or for sending the stream object
to a slave node in parallel computing via MPI.

The interface to these classes is inspired by Pierre L'Ecuyers
RngStreams package.

For an overview of classes and methods, see
\code{\linkS4class{rstream}}.
}

\author{Josef Leydold \email{josef.leydold@wu.ac.at}}

\references{
  P. L'Ecuyer and J. Leydold (2005):
  rstream: Streams of Random Numbers for Stochastic Simulation,
  R News 5(2), 16--20.
}

\seealso{
  \code{\linkS4class{rstream}}.
}

\keyword{distribution}
\keyword{datagen}

