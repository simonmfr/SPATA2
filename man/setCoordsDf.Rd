% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/setA-Z.R
\name{setCoordsDf}
\alias{setCoordsDf}
\alias{setCoordsDf,SPATA2-method}
\alias{setCoordsDf,SpatialData-method}
\title{Set the coordinates}
\usage{
setCoordsDf(object, ...)

\S4method{setCoordsDf}{SPATA2}(object, coords_df, force = FALSE)

\S4method{setCoordsDf}{SpatialData}(object, coords_df, force = FALSE)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{...}{Used to absorb deprecated arguments or functions.}

\item{coords_df}{A data.frame containing information about every \link[=concept_observations]{observation}. Must contain the variables:
\itemize{
\item{\emph{barcodes} Character. The barcode-sequences (+ the sample belonging) of every observation.}
\item{\emph{sample} Character. The sample belonging of every observation.}
\item{\emph{x_orig} Numeric. The unscaled x-coordinates of every observation.}
\item{\emph{y_orig} Numeric. The unscaled y-coordinates of every observation.}
}}
}
\value{
A spata object containing the set input.
}
\description{
Set the coordinates
}
\details{
All \code{set*()}-functions offer a save way to set certain
slots of your spata-object. They do check the input for validity but
effectively overwrite everything that is occupying the slot to be set -
use with caution.
}
\keyword{internal}
