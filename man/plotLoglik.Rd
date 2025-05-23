% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotH-M.R
\name{plotLoglik}
\alias{plotLoglik}
\title{Plot Bayes Space logliks}
\usage{
plotLoglik(object, elbow = TRUE)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}
}
\value{
A ggplot.
}
\description{
Visualizes the results of \code{BayesSpace::qTune()} to determine
the optimal number of clusters.
}
\details{
For this function to work the results of \code{\link[=runBayesSpaceClustering]{runBayesSpaceClustering()}}
are required.
}
\examples{
library(SPATA2)

data("example_data")

object <- example_data$object_UKF275T_diet

# this might take some time...
object <- runBayesSpaceClustering(object, name = "bspace", qs = 3:15)

plotLoglik(object)

}
