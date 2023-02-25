\name{rstream.packed-methods}
\docType{methods}
\alias{rstream.packed}
\alias{rstream.packed<-}
\alias{rstream.packed-methods}
\alias{rstream.packed<--methods}
\alias{rstream.packed,rstream-method}
\alias{rstream.packed<-,rstream-method}
\alias{rstream.packed,rstream.mrg32k3a-method}
\alias{rstream.packed<-,rstream.mrg32k3a-method}
\alias{rstream.packed,rstream.runif-method}
\alias{rstream.packed<-,rstream.runif-method}
%% obsolete
\alias{rstream.packed,rstream.lecuyer-method}
\alias{rstream.packed<-,rstream.lecuyer-method}

\title{Methods for Function rstream.packed in Package `rstream'}

\description{
  Get status (packed/unopacked) of an "rstream" object in package
  \pkg{rstream}.
  
  Pack and unpack an "rstream" object in package \pkg{rstream}.

  When a "rstream" object should be used in another \R session or saved
  for some kind of later reuse all information about the object must be
  packed. Notice no method other than unpacking can be applied to a
  packed object. It must be unpacked before.
}

\usage{
\S4method{rstream.packed}{rstream}(stream)
rstream.packed(stream) <- value
}

\arguments{
  \item{stream}{an "rstream" object.}
  \item{value}{a boolean (\code{TRUE} or \code{FALSE}) to change the
    status of the object.\cr
    \code{TRUE}: pack the object.\cr
    \code{FALSE}: unpack the object.}
}

\section{Methods}{
  Methods available for all "rstream" subclasses:
  \code{\link{rstream.mrg32k3a-class}},
  \code{\link{rstream.runif-class}}.
}

\seealso{%
  \code{\link{rstream-class}}.
}

\examples{
## create a new rstream object (of subclass rstream.mrg32k3a)
s <- new("rstream.mrg32k3a")

## pack rstream object
rstream.packed(s) <- TRUE

## status of object 
rstream.packed(s)

## pack rstream object
rstream.packed(s) <- FALSE

}

\keyword{methods}
\keyword{distribution}
\keyword{datagen}
