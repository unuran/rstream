\name{rstream.reset-methods}
\docType{methods}
\alias{rstream.reset}
\alias{rstream.reset-methods}
\alias{rstream.reset,rstream-method}
\alias{rstream.reset,rstream.mrg32k3a-method}
\alias{rstream.reset,rstream.runif-method}
%% obsolete
\alias{rstream.reset,rstream.lecuyer-method}

\title{Methods for Function rstream.reset in Package `rstream'}

\description{
  Reset "rstream" object in package \pkg{rstream} into its initial
  state.

  By resetting the stream object the same stream of random numbers can
  be generated.
}

\usage{
\S4method{rstream.reset}{rstream}(stream)
}
\arguments{
  \item{stream}{an "rstream" object.}
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

## generate a sample
x <- rstream.sample(s,10)

## reset the stream object
rstream.reset(s)

## the new sample y is identical to x
y <- rstream.sample(s,10)
if (identical(x,y)) print("x and y are identical samples")

}

\keyword{methods}
\keyword{distribution}
\keyword{datagen}
