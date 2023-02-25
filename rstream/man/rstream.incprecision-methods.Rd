\name{rstream.incprecision-methods}
\docType{methods}
\alias{rstream.incprecision}
\alias{rstream.incprecision<-}
\alias{rstream.incprecision-methods}
\alias{rstream.incprecision<--methods}
\alias{rstream.incprecision,rstream-method}
\alias{rstream.incprecision<-,rstream-method}
\alias{rstream.incprecision,rstream.mrg32k3a-method}
\alias{rstream.incprecision<-,rstream.mrg32k3a-method}
%% obsolete
\alias{rstream.incprecision,rstream.lecuyer-method}
\alias{rstream.incprecision<-,rstream.lecuyer-method}

\title{Methods for Function rstream.incprecision in Package `rstream'}

\description{
  Get and change the flag for increased precision of an "rstream" object
  in package \pkg{rstream}.

  If the increased precision flag is on (\code{TRUE}) the "rstream" object
  returns random numbers with precision close to machine epsilon.

  Most sources of pseudo random numbers generate random numbers of
  precision \eqn{2^{-32}\approx 2\times 10^{-10}}{2^(-32) ~ 2.e-10}.
  When the flag is on the precision is increased to machine epsilon
  (i.e. \eqn{\approx 10^{-16}}{~ 1.e-16}) by combining two random
  numbers of default precision.
}

\usage{
\S4method{rstream.incprecision}{rstream}(stream)
rstream.incprecision(stream) <- value
}
\arguments{
  \item{stream}{an "rstream" object.}
  \item{value}{a boolean (\code{TRUE} or \code{FALSE}) to change the
    status of the flag.}
}

\section{Methods}{
  Methods available for the following "rstream" subclasses:
  \code{\link{rstream.mrg32k3a-class}}.
}

\seealso{%
  \code{\link{rstream-class}}.
}

\examples{
## create a new rstream object (of subclass rstream.mrg32k3a)
s <- new("rstream.mrg32k3a")

## set increased precision flag of rstream object
rstream.incprecision(s) <- TRUE

## get increased precision flag of rstream object
rstream.incprecision(s)

}

\keyword{methods}
