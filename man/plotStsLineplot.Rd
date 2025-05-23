% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotN-S.R
\name{plotStsLineplot}
\alias{plotStsLineplot}
\alias{plotStsRidgeplot}
\title{Plot STS line- and ridgeplot}
\usage{
plotStsLineplot(
  object,
  variables,
  id = idST(object),
  width = getTrajectoryLength(object, id),
  unit = getSpatialMethod(object)@unit,
  smooth_span = 0.2,
  smooth_se = TRUE,
  line_color = NULL,
  line_size = 1.5,
  clrp = NULL,
  clrp_adjust = NULL,
  display_facets = TRUE,
  display_eval = FALSE,
  eval_size = 4,
  ggpLayers = NULL,
  ncol = NULL,
  nrow = NULL,
  verbose = NULL,
  ...
)

plotStsRidgeplot(
  object,
  variables,
  id = idST(object),
  width = getTrajectoryLength(object, id),
  unit = getSpatialMethod(object)@unit,
  smooth_span = 0.2,
  smooth_se = TRUE,
  line_color = NULL,
  line_size = 1.5,
  clrp = NULL,
  clrp_adjust = NULL,
  display_eval = FALSE,
  eval_size = 4,
  ggpLayers = NULL,
  ncol = NULL,
  nrow = NULL,
  verbose = NULL,
  ...
)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{variables}{Character vector. The names of the \emph{\link[=concept_variables]{data variables}}
of interest.}

\item{unit}{Character value. Specifies the desired unit in
which \link[=concept_distance_measure]{distance measures}
or  \link[=concept_area_measure]{area measures} are provided.
Run \code{\link[=validUnitsOfLength]{validUnitsOfLength()}} or \code{\link[=validUnitsOfArea]{validUnitsOfArea()}} for valid
input options.}

\item{smooth_span}{Numeric value. Controls the degree of smoothing.
Given to argument \code{span} of \code{stats::loess()}.}

\item{line_color}{Character. Affects color of the main lines of the plot.}

\item{line_size}{Numeric value. Specifies the thicknes of the lines with which
the trajectory dynamics are displayed.}

\item{clrp}{Character value. Specifies the color palette to be used to represent
groups of discrete variables. Run \code{validColorPalettes()} to obtain valid
input options.}

\item{clrp_adjust}{Named character vector or NULL. If character, it adjusts the
color palette that is used to represent the groups. Names of the input vector must refer
to the group and the respective named element denotes the color with which to
represent the group.}

\item{display_facets}{Logical. If set to TRUE sub plots for every specified gene, gene-set
or feature are displayed via \code{ggplot2::facet_wrap()}}

\item{ggpLayers}{List of \code{ggproto}-objects that are added to each plot.
Skim \code{ggpLayer*()}-functions for more options.}

\item{nrow, ncol}{Numeric values or NULL. Used to arrange multiple plots.}

\item{verbose}{Logical. If \code{TRUE}, informative messages regarding
the computational progress will be printed.

(Warning messages will always be printed.)}

\item{...}{Additional arguments given to \code{ggplot2::facet_wrap()} if argument
\code{display_facets} is set to TRUE.}
}
\value{
A ggplot.
}
\description{
Displays values along a trajectory direction with
a smoothed lineplot or ridgeplot.
}
\examples{
library(SPATA2)

data("example_data")

object <- example_data$object_UKF269T_diet

object <- normalizeCounts(object, activate = TRUE)

genes <- c("EGFR", "MBP", "MAG", "SNAP25")

plotStsHeatmap(object, id = "horizontal_mid", variables = genes)

plotStsLineplot(object, id = "horizontal_mid", variables = genes)

plotStsRidgeplot(object, id = "horizontal_mid", variables = genes)

}
