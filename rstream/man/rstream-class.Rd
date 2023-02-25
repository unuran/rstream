\name{rstream-class}
\docType{class}
\alias{rstream-class}
\alias{print,rstream-method}
\alias{show,rstream-method}

\title{Class "rstream" -- Multiple streams of uniform random numbers}

\description{%
  The virtual class "rstream" provides a unified interface to uniform
  random number generators. Objects of its subclasses act as a source of
  streams for random numbers that can be handled by a set of methods and
  which can be used as arguments of functions that require sources of
  randomness, e.g. discrete event models, Monte Carlo integration or
  other stochastic simulations.

  The instances of objects of this class and its subclasses are
  independent, i.e., sampling random numbers from one instance or
  reseting and changing its state does not effect any other
  instance. (However, different streams may not be \emph{stochastically} 
  independent if they are not carefully seeded!)

  Additionally there is a mechanismus interface to save and restore such
  streams, e.g. for the next \R session, for a reruning some stochastic
  calculations with identical input, or for sending the stream object
  to a slave node in parallel computing via MPI.

  The interface to these classes is inspired by Pierre L'Ecuyers
  RngStreams package.
}

\section{Objects from the Class}{A virtual Class: No objects may be created from it.}

\section{Methods}{
  The virtual class "rstream" prepares the following methods for
  handling random stream objects. Some methods that return parameters of
  the stream object have a variant that uses \code{<-} to change the
  respective parameters. See the man pages for the respective methods
  for details.

  \strong{Notice:} Some subclasses only implement a subset of these
  interfaces. The methods that do not work produce an error message.

  Methods to use the stream (available for all subclasses):
  
  \describe{
    \item{rstream.sample}{\code{signature(object = "rstream")}: 
      Get a random sample from the stream object.}
    \item{r}{\code{signature(object = "rstream")}:
      Same as \code{rstream.sample}.}
    \item{rstream.reset}{\code{signature(object = "rstream")}:
      Reset stream into initial state.}
  }

  Some subclasses have implemented the concept of substreams. This is
  especially usefull if two or more streams should be synchronized:
  
  \describe{
    \item{rstream.nextsubstream}{\code{signature(object = "rstream")}:
      Set state of stream to next substream.}
    \item{rstream.resetsubstream}{\code{signature(object = "rstream")}:
      Reset current substream into starting state.}
  }

  Antithetic random streams return numbers which have smallest possible
  correlation (i.e. \eqn{-1}{-1}) to their respective counterparts:
  
  \describe{
    \item{rstream.antithetic}{\code{signature(object = "rstream")}:
      Whether or not the stream object returns antithetic random
      numbers.}
    \item{rstream.antithetic<-}{\code{signature(object = "rstream")}:
      Change antithetic flag (\code{TRUE} or \code{FALSE}).}
  }

  Most sources of pseudo random numbers generate random numbers of
  precision \eqn{2^{-32}\approx 2\times 10^{-10}}{2^(-32) ~ 2.e-10}.
  For some streams this can be increased to machine epsilon (i.e.
  \eqn{\approx 10^{-16}}{~ 1.e-16}) by combining two random numbers of
  lower precision:
  
  \describe{
    \item{rstream.incprecision}{\code{signature(object = "rstream")}:
      Whether or not the stream object returns random numbers with
      increased precision.}
    \item{rstream.incprecision<-}{\code{signature(object = "rstream")}:
      Change flag for increased precision (\code{TRUE} or \code{FALSE}).}
  }

  Handling "rstream" objects:

  \describe{
    \item{print}{\code{signature(x = "rstream")}:
      Print state of the stream object.}
    \item{show}{\code{signature(x = "rstream")}:
      Same as \code{print}.}
    \item{rstream.name}{\code{signature(object = "rstream")}:
      The name of the stream object.}
    \item{rstream.name<-}{\code{signature(object = "rstream")}:
      Change the name of the stream object.}
    \item{rstream.clone}{\code{signature(object = "rstream")}:
      Make a copy (clone) of stream object.}
  }

  When a "rstream" object should be used in another \R session or saved for
  some kind of later reuse all information about the object must be
  packed. Notice no method other than unpacking can be applied to a
  packed object. It must be unpacked before.

  \describe{
    \item{rstream.packed}{\code{signature(object = "rstream")}:
      Whether or not the stream object is packed.}
    \item{rstream.packed<-}{\code{signature(object = "rstream")}:
      Pack or unpack object: set packed to \code{TRUE} or \code{FALSE}.}
  }
}

\references{
  L'Ecuyer, P.,  Simard, R., Chen, E. J., and Kelton, W. D. (2002)
  \emph{An object-oriented random-number package with many long streams
    and substreams}. Operations Research 50(6), 1073-1075.
}

\author{Josef Leydold (leydold@statistik.wu-wien.ac.at)}

\note{%
  "rstream" objects cannot simply be copied by \code{<-}. The new
  variable does not hold a copy of an "rstream" object but just points
  to the old object which might not be the wanted result (similar to \R
  environments). Use \code{\link{rstream.clone}} instead.
  
  The actual interface is implemented in subclasses, one for each source
  (package/library) of random numbers. The slots of this
  class and of all its subclasses must not be accessed directly. Use
  the above methods instead.

  One may miss a method for reseeding a random stream. However, there is
  no need for such a method as there is a method for resetting the
  stream to its initial state. I one needs a stream with a different
  stream, then a new rstream object should be created at all.

  Packed objects must be unpacked before any other method can be applied.
}

\section{Warning }{
  When "rstream" objects should be used in later \R sessions they must
  be packed before the current \R session is stopped and unpacked after
  the new \R session has been started and the workspace image has been
  reloaded. 
}

\seealso{
  \code{\link{rstream.mrg32k3a-class}},
  \code{\link{rstream.runif-class}}.
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

\keyword{classes}
\keyword{distribution}
\keyword{datagen}
