% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/runA-Z.R
\name{runKmeansClustering}
\alias{runKmeansClustering}
\title{Clustering with Kmeans}
\usage{
runKmeansClustering(
  object,
  ks,
  methods_kmeans = "Hartigan-Wong",
  prefix = "K",
  naming = "{method_kmeans}_k{k}",
  n_pcs = NULL,
  overwrite = TRUE,
  ...
)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{ks}{Numeric vector. Denotes all options for k-clusters over which
to iterate. Values <1 are discarded. (Givent o \code{centers} of \code{stats::kmeans()}).}

\item{methods_kmeans}{A character vector of kmeans methods. Should be one
or more of \emph{c("Hartigan-Wong", "Lloyd", "Forgy", "MacQueen")}. (Given to \code{algorithm}
of \code{stats::kmeans()}).}

\item{naming}{A \code{\link[glue:glue]{glue::glue()}} instruction on how to name the resulting cluster variables.
use \emph{method_kmeans} to refer to the method and \emph{k} for the value of k.}

\item{n_pcs}{Integer value. The number of principal components to use for
the clustering.}

\item{overwrite}{Logical value. Must be \code{TRUE} to allow overwriting.}

\item{...}{Additional arguments given to \code{\link[stats:kmeans]{stats::kmeans()}}.}
}
\value{
The updated input object, containing the added, removed or computed results.
}
\description{
A wrapper around the Kmeans clustering algorithm. Iterates over all
combinations of \code{ks} and \code{methods_kmeans} and stores the resulting clustering
variables in the feature data.frame.
}
\examples{
library(SPATA2)

data("example_data")

object <- example_data$object_UKF269T_diet

object <- runPCA(object, n_pcs = 20)

object <- runKmeansClustering(object, ks = 3:10, n_pcs = 20)

getFeatureNames(object)

}
\seealso{
\code{\link[=getFeatureDf]{getFeatureDf()}}, \code{\link[=getFeatureNames]{getFeatureNames()}}, \code{\link[=getGroupingOptions]{getGroupingOptions()}},
\code{\link[=getGroupNames]{getGroupNames()}}
}
