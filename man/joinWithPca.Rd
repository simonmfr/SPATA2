% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/j.R
\name{joinWithPca}
\alias{joinWithPca}
\alias{joinWithTsne}
\alias{joinWithUmap}
\title{Join barcodes with additional variables}
\usage{
joinWithPca(object, spata_df, n_pcs = NULL, verbose = NULL, force = FALSE, ...)

joinWithTsne(object, spata_df, verbose = NULL, force = FALSE, ...)

joinWithUmap(object, spata_df, verbose = NULL, force = FALSE, ...)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{n_pcs}{Numeric value or \code{NULL}. If numeric, specifies the number of
principal components to use. If \code{NULL}, all principal components are used
(as computed with \code{\link[=runPCA]{runPCA()}}).}

\item{verbose}{Logical. If \code{TRUE}, informative messages regarding
the computational progress will be printed.

(Warning messages will always be printed.)}

\item{force}{Logical. Only relevant if the spata data.frame provided
already contains the variables that would be added with the function.
If set to TRUE, the variables are added anyway.}

\item{...}{Addtional arguments given to \code{dplyr::left_join()}.}
}
\value{
The input data.frame with the additional dimensional reduction
variables
}
\description{
These functions add dimensional reduction results
in form of additional variables to the provided spata data.frame.
}
