\name{rstream.name-methods}
\docType{methods}
\alias{rstream.name}
\alias{rstream.name<-}
\alias{rstream.name-methods}
\alias{rstream.name<--methods}
\alias{rstream.name,rstream-method}
\alias{rstream.name<-,rstream-method}
\alias{rstream.name,rstream.mrg32k3a-method}
\alias{rstream.name<-,rstream.mrg32k3a-method}
\alias{rstream.name,rstream.runif-method}
\alias{rstream.name<-,rstream.runif-method}
%% obsolete
\alias{rstream.name,rstream.lecuyer-method}
\alias{rstream.name<-,rstream.lecuyer-method}

\title{Methods for Function rstream.name in Package `rstream'}

\description{
  Get and change the name for an "rstream" object in package
  \pkg{rstream}.

  The \code{name} is a character string that gives a user the
  possibility to label an "rstream" object. Any name can be used.
}

\usage{
\S4method{rstream.name}{rstream}(stream)
rstream.name(stream) <- value
}
\arguments{
  \item{stream}{an "rstream" object.}
  \item{value}{a character string that holds the label (name).}
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

## set name of rstream object
rstream.name(s) <- "mystream"

## get name of rstream object
rstream.name(s)

}

\keyword{methods}
\keyword{distribution}
\keyword{datagen}
