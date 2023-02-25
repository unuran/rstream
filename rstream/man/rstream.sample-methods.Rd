\name{rstream.sample-methods}
\docType{methods}
\alias{rstream.sample}
\alias{r}
\alias{rstream.sample-methods}
\alias{r-methods}
\alias{rstream.sample,rstream-method}
\alias{rstream.sample,rstream,numeric-method}
\alias{r,rstream-method}
\alias{r,rstream,numeric-method}
\alias{rstream.sample,rstream.mrg32k3a-method}
\alias{r,rstream.mrg32k3a-method}
\alias{rstream.sample,rstream.runif-method}
\alias{r,rstream.runif-method}
%% obsolete
\alias{rstream.sample,rstream.lecuyer-method}
\alias{r,rstream.lecuyer-method}

\title{Methods for Function rstream.sample in Package `rstream'}

\description{
  Get random sample from an "rstream" object in package
  \pkg{rstream}.
}

\usage{
\S4method{rstream.sample}{rstream,numeric}(stream,n=1)
\S4method{r}{rstream,numeric}(stream,n=1)
}
\arguments{
  \item{stream}{an "rstream" object.}
  \item{n}{sample size.}
}

\section{Methods}{
  Methods available for all "rstream" subclasses:
  \code{\link{rstream.mrg32k3a-class}},
  \code{\link{rstream.runif-class}}.
}

\seealso{%
  \code{\link{rstream-class}}.
}

\note{\code{r} is equivalent to \code{rstream.sample}.}

\examples{
## create a new rstream object (of subclass rstream.mrg32k3a)
s <- new("rstream.mrg32k3a")

## get a random number
x <- rstream.sample(s)

## get a random sample of size 100
x <- rstream.sample(s,100)

## alternatively ...
x <- r(s,100)

}

\keyword{methods}
\keyword{distribution}
\keyword{datagen}
