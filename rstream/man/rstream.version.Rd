\name{rstream.version}
\alias{rstream.version}

\title{Switch to behavior of earlier version of package}

\description{
  \code{rstream.version} can be used to switch to the behavior as it was
  in an earlier version of package \pkg{rstream} (for reproducibility).
}

\usage{
rstream.version(version)
}

\arguments{
  \item{version}{a character string containing a version number of the
    form \code{"xx.yy"} or \code{"xx.yy.zz"}, e.g., \code{"1.2.5"}.}
}

\details{
  Bug fixes may influence a generated random stream (see NEWS file,
  \code{news(package="rstream")}).
  However, it is sometimes necessary to reproduce the same sequence with
  a newer version of the package. Thus one can switch to this behavior
  by means of \code{rstream.version}.

  \code{version} is a character string that contains the requested
  version number. Notice that only the major number and the first
  minor number are relevant. The string \code{"default"} can be used
  to switch back to the new behavior.
  When \code{version} is omitted than the actual version number is
  shown.
}

\author{Josef Leydold \email{josef.leydold@wu.ac.at}}

\seealso{
  \code{\linkS4class{rstream}}.
}

\examples{
## Switch to version 1.2
rstream.version("1.2")
## Show current version
rstream.version()
## Switch back to default
rstream.version("default")
rstream.version()
}

\keyword{distribution}
