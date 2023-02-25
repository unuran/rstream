\name{rstream.runif-class}
\docType{class}
\alias{rstream.runif-class}
\alias{initialize,rstream.runif-method}
\alias{print,rstream.runif-method}

\title{Class "rstream.runif" -- Interface to R internal uniform random
  number generators} 

\description{
  This class implements the "rstream" interface for the \R internal
  uniform RNGs. This class allows to access and handle these generators
  in exactly the same way as external generators. In particular, one can
  create copies of generators. There is no need to deal with
  \code{\link{RNGkind}} and \code{\link{set.seed}} when different
  RNGs should be used.
}

\section{Objects from the Class}{
  Objects can be created by calls of the form
  \code{new("rstream.runif", name, kind, seed, antithetic)}.

  \describe{
    \item{name:}{An arbitrary string to name the stream object.
      If omitted a string that consists of \code{runif} and some
      number (which is increased every time when a new \emph{rstream}
      object is created.}
    \item{kind:}{A character string. The new "rstream" object uses
      the RNG of type \code{kind}. The same strings as for
      \code{\link{RNGkind}} can be used. Additionally the string
      \code{"current"} is available to use the type of generator to
      which \R is currently set (this is the default if no kind is
      given). 
      User-supplied generators cannot be used.}
    \item{seed:}{The seed for the generator as used by the
      \code{\link{set.seed}} call. If omitted a random seed is used.}
    \item{antithetic:}{A boolean. Whether or not antithetic random
      numbers should be produced.
      Default is \code{FALSE}.}
  }
}
\section{Extends}{
  Class \code{"rstream"}, directly.
}

\section{Methods}{
  The class "rstream.runif" provides the following methods for
  handling "rstream.runif" objects. Some methods that return
  parameters of the stream object have a variant that uses \code{<-} to
  change the respective parameters. See the man pages for the respective
  methods for details.

  Methods to use the stream:
  
  \describe{
    \item{rstream.sample}{\code{signature(object = "rstream.runif")}: 
      Get a random sample from the stream object.}
    \item{r}{\code{signature(object = "rstream.runif")}:
      Same as \code{rstream.sample}.}
    \item{rstream.reset}{\code{signature(object = "rstream.runif")}:
      Reset stream into initial state.}
  }

  Antithetic random streams:
  \describe{
    \item{rstream.antithetic}{\code{signature(object = "rstream.runif")}:
      Whether or not the stream object returns antithetic random
      numbers.}
    \item{rstream.antithetic<-}{\code{signature(object = "rstream.runif")}:
      Change antithetic flag (\code{TRUE} or \code{FALSE}).}
  }

  Handling "rstream.runif" objects:

  \describe{
    \item{print}{\code{signature(x = "rstream.runif")}:
      Print state of the stream object.}
    \item{rstream.name}{\code{signature(object = "rstream.runif")}:
      The name of the stream object.}
    \item{rstream.name<-}{\code{signature(object = "rstream.runif")}:
      Change the name of the stream object.}
    \item{rstream.clone}{\code{signature(object = "rstream.runif")}:
      Make a copy (clone) of stream object.}
    \item{initialize}{\code{signature(.Object = "rstream.runif")}:
      Initialize rstream object. (For Internal usage only).}
  }

  When a "rstream.runif" object should be used in another \R session
  or saved for some kind of later reuse all information about the
  object must be packed. Notice no method other than unpacking can be
  applied to a packed object. It must be unpacked before.

  \describe{
    \item{rstream.packed}{\code{signature(object = "rstream.runif")}:
      Whether or not the stream object is packed.}
    \item{rstream.packed<-}{\code{signature(object = "rstream.runif")}:
      Pack or unpack object: set packed to \code{TRUE} or \code{FALSE}.}
  }
}

\author{Josef Leydold \email{josef.leydold@wu.ac.at}}

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

\seealso{%
  \code{\linkS4class{rstream}},
  \code{\link{rstream.antithetic-methods}},
  \code{\link{rstream.clone-methods}},
  \code{\link{rstream.name-methods}},
  \code{\link{rstream.packed-methods}},
  \code{\link{rstream.reset-methods}},
  \code{\link{rstream.sample-methods}},
  \code{\link{rstream.RNG}}.
}

\examples{
## create a new rstream.runif object
s <- new("rstream.runif")

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

## make a clone of the rstream object
sc <- rstream.clone(s)

## pack and unpack the rstream object
rstream.packed(s) <- TRUE
rstream.packed(s) <- FALSE

}

\keyword{classes}
\keyword{distribution}
\keyword{datagen}
