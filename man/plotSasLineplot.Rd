% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotN-S.R
\name{plotSasLineplot}
\alias{plotSasLineplot}
\title{Plot SAS lineplot}
\usage{
plotSasLineplot(
  object,
  variables,
  ids = idSA(object),
  distance = "dte",
  resolution = recSgsRes(object),
  core = FALSE,
  angle_span = c(0, 360),
  smooth_span = 0.2,
  smooth_se = TRUE,
  unit = getSpatialMethod(object)@unit,
  bcs_exclude = character(0),
  clrp = NULL,
  clrp_adjust = NULL,
  line_color = NULL,
  line_size = 1.5,
  display_facets = TRUE,
  nrow = NULL,
  ncol = NULL,
  border_linealpha = 0.75,
  border_linecolor = alpha("white", 0),
  border_linesize = 1,
  border_linetype = "solid",
  display_eval = FALSE,
  eval_size = line_size * 2.5,
  ggpLayers = list(),
  verbose = NULL,
  ...
)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{variables}{Character vector. The numeric variables to be included in
the screening process. Makre sure that the correct matrix is active in the
respective assays.}

\item{ids}{Character vector. Specifies the IDs of the spatial annotations of interest.}

\item{distance}{\code{\link[=concept_distance_measure]{Distance measure}}. Specifies
the distance from the border of the spatial annotation to the \emph{horizon} in
the periphery up to which the screening is conducted. Defaults to a distance
that covers the whole tissue section the spatial annotation is located
on using \code{\link[=distToEdge]{distToEdge()}}. (This distance must not be exceeded.)}

\item{resolution}{\link[=concept_distance_measure]{Distance measure}. The resolution
with which the expression gradient is inferred. Defaults are platform specific.
See more in detail section of \code{\link[=recSgsRes]{recSgsRes()}}.}

\item{angle_span}{Numeric vector of length 2. Confines the area screened by
an angle span relative to the center of its closest spatial annotation.}

\item{smooth_span}{Numeric value. Controls the degree of smoothing.
Given to argument \code{span} of \code{stats::loess()}.}

\item{unit}{Character value. The unit in which the distance
to the spatial annotation is displayed on the x-axis.

If \code{FALSE}, plots the bin numbers instead.}

\item{bcs_exclude}{Character value containing the barcodes of observations to be excluded
from the analysis.}

\item{clrp}{Character value. Specifies the color palette to be used to represent
groups of discrete variables. Run \code{validColorPalettes()} to obtain valid
input options.}

\item{clrp_adjust}{Named character vector or NULL. If character, it adjusts the
color palette that is used to represent the groups. Names of the input vector must refer
to the group and the respective named element denotes the color with which to
represent the group.}

\item{line_color}{Character. Affects color of the main lines of the plot.}

\item{line_size}{Numeric value. Specifies the thicknes of the lines with which
the trajectory dynamics are displayed.}

\item{display_facets}{Logical. If set to TRUE sub plots for every specified gene, gene-set
or feature are displayed via \code{ggplot2::facet_wrap()}}

\item{nrow, ncol}{Numeric values or NULL. Used to arrange multiple plots.}

\item{border_linealpha, border_linecolor, border_linesize, border_linetype}{Given
to \code{ggplot2::geom_vline()}. Adjusts appearance of the vertical line that
represents the border of the spatial annotation.}

\item{ggpLayers}{List of \code{ggproto}-objects that are added to each plot.
Skim \code{ggpLayer*()}-functions for more options.}

\item{verbose}{Logical. If \code{TRUE}, informative messages regarding
the computational progress will be printed.

(Warning messages will always be printed.)}

\item{...}{Needed arguments that depend on the input/unit combination. If
one of both is \emph{'px'}, argument \code{object} must be specified.}

\item{facet_by}{Either \emph{'variables'} or \emph{'bins_angle'}.
If \emph{'bins_angle'} length of \code{variables} must be one.}

\item{display_border}{Logical value. If \code{TRUE}, displays a vertical line
to highlight where the border of the spatial annotation runs.}
}
\value{
A ggplot.
}
\description{
Plots expression changes against the distance to
a spatial annotation using lineplots.
}
\section{Distance measures}{


The vignette on distance measures in SPATA2 has been replaced. Click
\code{\link[=concept_distance_measure]{here}} to read it.
}

\examples{
library(SPATA2)
library(ggplot2)

data("example_data")

object <- loadExampleObject("UKF313T", process = TRUE, meta = TRUE)

ids <- getSpatAnnIds(object, tags = c("necrotic", "compr"), test = "identical")

# visualize with lines
plotSasLineplot(object, ids = ids, variables = c("VEGFA", "HM_HYPOXIA", "RCTM_TCR_SIGNALING", "CD74")) +
  labs(x = "Distance to Necrosis")

# visualize with ridgeplots
plotSasRidgeplot(object, ids = ids, variables = c("VEGFA", "HM_HYPOXIA", "RCTM_TCR_SIGNALING", "CD74")) +
  labs(x = "Distance to Necrosis")

# visualize with a heatmap
plotSasHeatmap(object, ids = ids, variables = c("VEGFA", "HM_HYPOXIA", "RCTM_TCR_SIGNALING", "CD74")) +
  labs(x = "Distance to Necrosis")

}
