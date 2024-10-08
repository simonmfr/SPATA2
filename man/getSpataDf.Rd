% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getN-Z.R
\name{getSpataDf}
\alias{getSpataDf}
\title{Obtain a data.frame of observations}
\usage{
getSpataDf(object, ...)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{...}{Used to absorb deprecated arguments or functions.}
}
\value{
A tidy data.frame containing the character variables \emph{barcodes}
and \emph{sample}.
}
\description{
This function is the most basic start if you want
to extract data for your individual analysis.

(In order to extract the coordinates as well use \code{getCoordsDf()}.)
}
\seealso{
joinWith
}
\keyword{internal}
