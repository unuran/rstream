\name{rstream.resetsubstream-methods}
\docType{methods}
\alias{rstream.resetsubstream}
\alias{rstream.nextsubstream}
\alias{rstream.resetsubstream-methods}
\alias{rstream.nextsubstream-methods}
\alias{rstream.resetsubstream,rstream-method}
\alias{rstream.nextsubstream,rstream-method}
\alias{rstream.resetsubstream,rstream.lecuyer-method}
\alias{rstream.nextsubstream,rstream.lecuyer-method}

\title{Methods for Function rstream.resetsubstream and
  rstream.nextsubstream in Package `rstream'}

\description{
  Some subclasses have implmented the concept of substreams. This is
  especially usefull if two or more streams should be synchronized.

  This interface allows to jump to the beginning of the next substream
  and to reset the stream object to the beginning of the current substream.
}

\usage{
rstream.resetsubstream(stream)
rstream.nextsubstream(stream)
}
\arguments{
  \item{stream}{an "rstream" object.}
}

\section{Methods}{
  Methods available for the following "rstream" subclasses:
  \code{\link{rstream.lecuyer-class}}.
}

\seealso{%
  \code{\link{rstream-class}}.
}

\examples{
## create a new rstream object (of subclass rstream.lecuyer)
s <- new("rstream.lecuyer")

## jump to beginning of next substream
rstream.nextsubstream(s)

## generate a sample
x <- rstream.sample(s,10)

## reset substream
rstream.resetsubstream(s)

## the new sample y is identical to x
y <- rstream.sample(s,10)
if (identical(x,y)) print("x and y are identical samples")

}

\keyword{methods}
