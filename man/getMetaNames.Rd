% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getA-G.R, R/getH-M.R
\name{getFeatureNames}
\alias{getFeatureNames}
\alias{getMetaNames}
\title{Obtain metadata column names}
\usage{
getFeatureNames(object, of_class = NULL, ...)

getMetaNames(object, of_class = NULL, ...)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{of_class}{Character vector. Specify the class(es) a metadata entry must be of for
its name to be returned.}

\item{...}{Used to absorb deprecated arguments or functions.}
}
\value{
A named character vector of the variables in the metadata slot (excluding 'sample').
}
\description{
Extracts names of entries from the meta data.frame.
}
