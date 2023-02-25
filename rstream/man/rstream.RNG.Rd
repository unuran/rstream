\name{rstream.RNG}
\alias{rstream.RNG}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{Get and set "rstream" object from/to R global generator}

\description{
  The function \code{rstream.RNG(stream)} is used to set a given
  "rstream" object \code{stream} as current global \R uniform random
  number generators. 

  Without an argument (or \code{NULL}) it returns an "rstream" object
  that contains the current global generator.
  It is a copy (clone) of the global generator and thus it can be
  handled independently from the global generator.
}

\usage{
rstream.RNG(stream = NULL)
}
\arguments{
  \item{stream}{\code{NULL} or an "rstream" object}
}
%\details{
%  ~~ If necessary, more details than the __description__  above ~~
%}
\value{
  \code{rstream.RNG} returns an "rstream" object.
}

\author{Josef Leydold (leydold@statmath.wu.ac.at)}

\seealso{
  \code{\link{rstream-class}}.
}

\examples{
## create a new rstream.runif object
s <- new("rstream.mrg32k3a")

## use this stream as global R uniform RNG
rstream.RNG(s)

## get a (idenpendent) copy of the stream
## that contains the global R uniform RNG
gs <- rstream.RNG()

## change the state of the global generator
gs <- rstream.RNG()
rstream.nextsubstream(gs)
rstream.RNG(gs)

}

\keyword{methods}
\keyword{distribution}
\keyword{datagen}
