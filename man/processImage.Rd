% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/p.R
\name{processImage}
\alias{processImage}
\title{Run image processing pipeline}
\usage{
processImage(object, img_name = activeImage(object), verbose = NULL, ...)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{img_name}{Character value. The name of the image of interest.
If \code{NULL}, the \link[=concept_active]{active} image is chosen by default. Either way, must
be one of \code{\link[=getImageNames]{getImageNames()}}.}

\item{verbose}{Logical. If \code{TRUE}, informative messages regarding
the computational progress will be printed.

(Warning messages will always be printed.)}

\item{...}{Arguments passed to \code{\link[=identifyPixelContent]{identifyPixelContent()}}.}
}
\value{
The updated input object, containing the added, removed or computed results.
}
\description{
A wrapper around the image processing functions:

\itemize{
\item{\code{\link[=identifyPixelContent]{identifyPixelContent()}}}{}
\item{\code{\link[=identifyTissueOutline]{identifyTissueOutline()}}}{}
\item{\code{\link[=identifyBackgroundColor]{identifyBackgroundColor()}}}
}
}
\keyword{internal}
