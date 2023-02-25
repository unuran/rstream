\name{rstream.resetsubstream-methods}
\docType{methods}
\alias{rstream.resetsubstream}
\alias{rstream.nextsubstream}
\alias{rstream.resetsubstream-methods}
\alias{rstream.nextsubstream-methods}
\alias{rstream.resetsubstream,rstream-method}
\alias{rstream.nextsubstream,rstream-method}
\alias{rstream.resetsubstream,rstream.mrg32k3a-method}
\alias{rstream.nextsubstream,rstream.mrg32k3a-method}
%% obsolete
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
\S4method{rstream.resetsubstream}{rstream}(stream)
\S4method{rstream.nextsubstream}{rstream}(stream)
}
\arguments{
  \item{stream}{an "rstream" object.}
}

\section{Methods}{
  Methods available for the following "rstream" subclasses:
  \code{\linkS4class{rstream.mrg32k3a}}.
}

\author{Josef Leydold \email{josef.leydold@wu.ac.at}}

\seealso{%
  \code{\linkS4class{rstream}}.
}

\examples{
## create a new rstream object (of subclass rstream.mrg32k3a)
s <- new("rstream.mrg32k3a")

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
\keyword{distribution}
\keyword{datagen}
