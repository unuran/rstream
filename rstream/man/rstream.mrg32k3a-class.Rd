\name{rstream.mrg32k3a-class}
\docType{class}
\alias{rstream.mrg32k3a-class}
\alias{initialize,rstream.mrg32k3a-method}
\alias{print,rstream.mrg32k3a-method}

\title{Class "rstream.mrg32k3a" -- Multiple streams with MRG32k3a
  backbone generator from Pierre L'Ecuyers RngStreams package}

\description{
  This class implements the "rstream" interface for Pierre L'Ecuyer's
  RngStreams package with the MRG32K3a multiple recursive generator as its
  backbone generator. This package is well suited for multiple
  independent streams of uniform random numbers. In particular it
  provides antithetic variates and substreams. A very important feature
  is that different streams are stochastically independent (in
  opposition to many other random number generators where the uses has
  to choose seeds carefully). For that reason there only exists a
  package seed for all streams and indiviual seeds should be avoided
  (and requires expertise).
}

\section{Objects from the Class}{
  Objects can be created by calls of the form
  \code{new("rstream.mrg32k3a", name, seed, force.seed, antithetic,
    incprecision)}.

  \describe{
    \item{name:}{An arbitrary string to name the stream object.
      If omitted a string that consists of \code{mrg32k3a} and some
      number (which is increased every time when a new \emph{rstream}
      object is created.}
    \item{seed:}{An array of six numbers. The seed for the RngStreams
      package. If omitted a random seed is used. It should only be
      set at the first creation of an instance of
      an \emph{rstream.mrg32k3a} object.}
    \item{force.see:}{A boolean. If the RngStreams package should be reseeded
      (which is not recommended) it must be \code{TRUE}.
      Default is \code{FALSE}.}
    \item{antithetic:}{A boolean. Whether or not antithetic random
      numbers should be produced.
      Default is \code{FALSE}.}
    \item{incprecision:}{A boolean. Whether or not random numbers with
      increased precision should be produced.
      Default is \code{FALSE}.}
  }
}
\section{Extends}{
  Class \code{"rstream"}, directly.
}

\section{Methods}{
  The class "rstream.mrg32k3a" provides the following methods for
  handling "rstream.mrg32k3a" objects. Some methods that return
  parameters of the stream object have a variant that uses \code{<-} to
  change the respective parameters. See the man pages for the respective
  methods for details.

  Methods to use the stream:
  
  \describe{
    \item{rstream.sample}{\code{signature(object = "rstream.mrg32k3a")}: 
      Get a random sample from the stream object.}
    \item{r}{\code{signature(object = "rstream.mrg32k3a")}:
      Same as \code{rstream.sample}.}
    \item{rstream.reset}{\code{signature(object = "rstream.mrg32k3a")}:
      Reset stream into initial state.}
    \item{rstream.nextsubstream}{\code{signature(object = "rstream.mrg32k3a")}:
      Set state of stream to next substream.}
    \item{rstream.resetsubstream}{\code{signature(object = "rstream.mrg32k3a")}:
      Reset current substream into starting state.}
  }

  Antithetic random streams and increased precision:
  \describe{
    \item{rstream.antithetic}{\code{signature(object = "rstream.mrg32k3a")}:
      Whether or not the stream object returns antithetic random
      numbers.}
    \item{rstream.antithetic<-}{\code{signature(object = "rstream.mrg32k3a")}:
      Change antithetic flag (\code{TRUE} or \code{FALSE}).}
    \item{rstream.incprecision}{\code{signature(object = "rstream.mrg32k3a")}:
      Whether or not the stream object returns random numbers with
      increased precision.}
    \item{rstream.incprecision<-}{\code{signature(object = "rstream.mrg32k3a")}:
      Change flag for increased precision (\code{TRUE} or \code{FALSE}).}
  }

  Handling "rstream.mrg32k3a" objects:

  \describe{
    \item{print}{\code{signature(x = "rstream.mrg32k3a")}:
      Print state of the stream object.}
    \item{rstream.name}{\code{signature(object = "rstream.mrg32k3a")}:
      The name of the stream object.}
    \item{rstream.name<-}{\code{signature(object = "rstream.mrg32k3a")}:
      Change the name of the stream object.}
    \item{rstream.clone}{\code{signature(object = "rstream.mrg32k3a")}:
      Make a copy (clone) of stream object.}
    \item{initialize}{\code{signature(.Object = "rstream.mrg32k3a")}:
      Initialize rstream object. (For Internal usage only).}
  }

  When a "rstream.mrg32k3a" object should be used in another \R session
  or saved for some kind of later reuse all information about the
  object must be packed. Notice no method other than unpacking can be
  applied to a packed object. It must be unpacked before.

  \describe{
    \item{rstream.packed}{\code{signature(object = "rstream.mrg32k3a")}:
      Whether or not the stream object is packed.}
    \item{rstream.packed<-}{\code{signature(object = "rstream.mrg32k3a")}:
      Pack or unpack object: set packed to \code{TRUE} or \code{FALSE}.}
  }
}

\references{
  L'Ecuyer, P.,  Simard, R., Chen, E. J., and Kelton, W. D. (2002)
  \emph{An object-oriented random-number package with many long streams
    and substreams}. Operations Research 50(6), 1073-1075.
}

\author{
  Josef Leydold \email{josef.leydold@wu.ac.at}

  underlying generator: Pierre L'Ecyuer and Richard Simard
}

\note{
  The slots of this class must not be accessed directly. Use
  the above methods instead.

  "rstream" objects cannot simply be copied by \code{<-}. The new
  variable does not hold a copy of an "rstream" object but just points
  to the old object which might not be the wanted result (similar to \R
  environments). Use \code{\link{rstream.clone}} instead.

  One may miss a method for reseeding a random stream. However, there is
  no need for such a method as there is a method for resetting the
  stream to its initial state. I one needs a stream with a different
  stream, then a new rstream object should be created at all.

  Packed objects must be unpacked before any other method can be applied.
}

\section{Warning }{
  The underlying RngStreams library uses a global variable to store the
  package seed. This variable is also stored inside \R. Whenever a new
  instance of a "rstream.mrg32k3a" object is created the value of global
  variable is set to the value of the \R object. Thus there is no
  problem when such "rstream.mrg32k3a" objects are packed for using in
  later \R sessions. However, if such packed objects are not stored in
  the workspace image, then the \R variable gets lost and there is a
  (extremely small) chance that newly created objects are not
  stochastically independent from restored objects.
}

\seealso{%
  \code{\linkS4class{rstream}},
  \code{\link{rstream.antithetic-methods}},
  \code{\link{rstream.clone-methods}},
  \code{\link{rstream.incprecision-methods}},
  \code{\link{rstream.name-methods}},
  \code{\link{rstream.packed-methods}},
  \code{\link{rstream.reset-methods}},
  \code{\link{rstream.sample-methods}},
  \code{\link{rstream.nextsubstream-methods}},
  \code{\link{rstream.RNG}}.
}
\examples{
## create a new rstream.mrg32k3a object
s <- new("rstream.mrg32k3a")

## show state of this object
print(s)

## show and change name of stream object
rstream.name(s)
rstream.name(s) <- "mystream"

## get a random number
x <- rstream.sample(s)

## get a random sample of size 100
x <- rstream.sample(s,100)

## reset random stream
rstream.reset(s)

## show and set antithetic flag
rstream.antithetic(s)
rstream.antithetic(s) <- TRUE

## jump to next substream
rstream.nextsubstream(s)

## make a clone of the rstream object
sc <- rstream.clone(s)

## pack and unpack the rstream object
rstream.packed(s) <- TRUE
rstream.packed(s) <- FALSE

}

\keyword{classes}
\keyword{distribution}
\keyword{datagen}
