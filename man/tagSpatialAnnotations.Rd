% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/t.R
\name{tagSpatialAnnotations}
\alias{tagSpatialAnnotations}
\alias{tagSpatialAnnotations,SPATA2-method}
\alias{tagSpatialAnnotations,SpatialData-method}
\title{Tag spatial annotations}
\usage{
tagSpatialAnnotations(object, ...)

\S4method{tagSpatialAnnotations}{SPATA2}(object, ids, tags, opt = "add")

\S4method{tagSpatialAnnotations}{SpatialData}(object, ids, tags, opt = "add")
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{...}{Used to absorb deprecated arguments or functions.}

\item{ids}{A character vector of IDs naming the spatial annotations that are
affected by the changes.}

\item{tags}{A character vector of tags.}

\item{opt}{A character string specifying the kind of adjustment: either \emph{'add'} to
add tags to existing tags or \emph{'set'} to replace existing tags with the new ones.}
}
\value{
The updated input object, containing the added, removed or computed results.
}
\description{
Adjusts tags of spatial annotations.
}
\examples{
library(SPATA2)

data("example_data")

object <- example_data$object_UKF313T_diet

plotSpatialAnnotations(object)
getSpatAnnTags(object, simplify = FALSE)

object <- tagSpatialAnnotations(object, ids = c("necrotic_edge", "necrotic_edge2"), tags = "edge")

getSpatAnnTags(object, simplify = FALSE)
}
