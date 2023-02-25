\name{rstream.clone-methods}
\docType{methods}
\alias{rstream.clone}
\alias{rstream.clone-methods}
\alias{rstream.clone,rstream-method}
\alias{rstream.clone,rstream.mrg32k3a-method}
\alias{rstream.clone,rstream.runif-method}
%% obsolete
\alias{rstream.clone,rstream.lecuyer-method}

\title{Methods for Function rstream.clone in Package `rstream'}

\description{
  Make a copy (clone) of an "rstream" object in package
  \pkg{rstream}.

  "rstream" objects cannot simply be copied by \code{<-}. The new
  variable does not hold a copy of an "rstream" object but just points
  to the old object which might not be the wanted result (similar to \R
  environments). To get a copy of the whole "rstream" object the clone
  method must be used.
}

\usage{
clone <- rstream.clone(stream)
}
\arguments{
  \item{stream}{an "rstream" object.}
}

\section{Methods}{
  Methods available for all "rstream" subclasses:
  \code{\link{rstream.mrg32k3a-class}},
  \code{\link{rstream.runif-class}}.
}

\note{
  The label (name) of the new copy has a dot "." appended to distinguish
  the original object from its copy.
}

\seealso{%
  \code{\link{rstream-class}}.
}

\examples{
## create a new rstream object (of subclass rstream.mrg32k3a)
s <- new("rstream.mrg32k3a")

## make a copy (clone)
clone <- rstream.clone(s)
}

\keyword{methods}
\keyword{distribution}
\keyword{datagen}
