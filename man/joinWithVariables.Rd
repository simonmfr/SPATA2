% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/j.R
\name{joinWithVariables}
\alias{joinWithVariables}
\title{Join data with variables}
\usage{
joinWithVariables(
  object,
  variables,
  spata_df = getCoordsDf(object),
  smooth = FALSE,
  smooth_span = NULL,
  normalize = NULL,
  uniform_variables = "keep",
  verbose = NULL,
  ...
)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{variables}{Character vector. The names of the \emph{\link[=concept_variables]{data variables}}
of interest.}

\item{smooth}{Logical. If TRUE, a loess fit is used to smooth the values.}

\item{smooth_span}{Numeric value. Controls the degree of smoothing.
Given to argument \code{span} of \code{stats::loess()}.}

\item{normalize}{Logical. If set to TRUE values will be scaled to 0-1.

Hint: Variables that are uniformly expressed can not be scaled and are discarded.}

\item{verbose}{Logical. If \code{TRUE}, informative messages regarding
the computational progress will be printed.

(Warning messages will always be printed.)}

\item{...}{Used to absorb deprecated arguments or functions.}
}
\value{
A data frame containing spatial data joined with additional variables.
}
\description{
Joins data.frames of the \code{SPATA2} objects \link[=concept_observations]{observations} with additional
\link[=concept_variables]{variables}, such as molecular data, signatures, and meta features.
}
\details{
This function joins spatial data from \code{spata_df} with additional variables specified in 'variables'.
It retrieves molecular data, signatures, and meta features from the provided object and adds them to the spatial data frame.
Additionally, it can perform smoothing and normalization on numeric variables if desired. The 'uniform' parameter determines
how variables with uniform values are handled.
}
\note{
This function replaces the old \code{joinWith()}, \code{joinWithGenes()}, \code{joinWithFeatures()} functions!
}
\examples{
# Join spatial data with molecular and/or meta features

library(SPATA2)

object <- loadExampleObject("UKFT275", process = TRUE, meta = TRUE)

coords_df <- getCoordsDf(object)

joined_data <- joinWithVariables(object, spata_df = coords_df, variables = c("GFAP", "bayes_space", "HM_HYXPOXIA"))

}
\seealso{
\code{\link[=getVarTypeList]{getVarTypeList()}}, \code{\link[=getMolTypeList]{getMolTypeList()}}, \code{\link[=getSignatureTypeList]{getSignatureTypeList()}}, \code{\link[=getMetaDf]{getMetaDf()}}
}
