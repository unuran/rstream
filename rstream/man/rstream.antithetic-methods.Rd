\name{rstream.antithetic-methods}
\docType{methods}
\alias{rstream.antithetic}
\alias{rstream.antithetic<-}
\alias{rstream.antithetic-methods}
\alias{rstream.antithetic<--methods}
\alias{rstream.antithetic,rstream-method}
\alias{rstream.antithetic<-,rstream-method}
\alias{rstream.antithetic,rstream.mrg32k3a-method}
\alias{rstream.antithetic<-,rstream.mrg32k3a-method}
\alias{rstream.antithetic,rstream.runif-method}
\alias{rstream.antithetic<-,rstream.runif-method}
%% obsolete
\alias{rstream.antithetic,rstream.lecuyer-method}
\alias{rstream.antithetic<-,rstream.lecuyer-method}

\title{Methods for Function rstream.antithetic in Package `rstream'}

\description{
  Get and change the antithetic flag for an "rstream" object in package
  \pkg{rstream}.

  If the antithetic flag is on (\code{TRUE}) the "rstream" object
  returns antithetic random numbers.
  
  Antithetic random streams return numbers which have smallest possible
  correlation (i.e. \eqn{-1}{-1}) to their respective counterparts.
  Thus instead of a number \eqn{u}{u} the number \eqn{1-u}{1-u} is
  returned.

  This is useful for variance reduction techniques in Monte Carlo
  computations. 
}

\usage{
\S4method{rstream.antithetic}{rstream}(stream)
rstream.antithetic(stream) <- value
}
\arguments{
  \item{stream}{an "rstream" object.}
  \item{value}{a boolean (\code{TRUE} or \code{FALSE}) to change the
    status of the flag.}
}

\section{Methods}{
  Methods available for the following "rstream" subclasses:
  \code{\link{rstream.mrg32k3a-class}},
  \code{\link{rstream.runif-class}}.
}

\seealso{%
  \code{\link{rstream-class}}.
}

\examples{
## create a new rstream object (of subclass rstream.mrg32k3a)
s <- new("rstream.mrg32k3a")

## set antithetic flag of rstream object
rstream.antithetic(s) <- TRUE

## get antithetic flag of rstream object
rstream.antithetic(s)

}

\keyword{methods}
\keyword{distribution}
\keyword{datagen}
