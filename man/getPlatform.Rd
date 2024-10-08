% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getN-Z.R
\name{getPlatform}
\alias{getPlatform}
\alias{getPlatform,SPATA2-method}
\alias{getPlatform,SpatialData-method}
\title{Obtain platform name}
\usage{
getPlatform(object, ...)

\S4method{getPlatform}{SPATA2}(object, ...)

\S4method{getPlatform}{SpatialData}(object, ...)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{...}{Used to absorb deprecated arguments or functions.}
}
\value{
A character string representing the platform information.
}
\description{
Generic function to retrieve the platform information from the
object - the name of it's \link[=SpatialMethod]{spatial method}.
}
\examples{

library(SPATA2)
library(SPATAData)

# VisiumSmall
object <- loadExampleData("UKF313T")
getPlatform(object)

# VisiumLarge
object <- downloadSpataObject("HumanKidneyVL")
getPlatform(object)

}
