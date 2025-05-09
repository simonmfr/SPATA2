% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/g.R
\name{ggpLayerZoom}
\alias{ggpLayerZoom}
\title{Set plot limits manually}
\usage{
ggpLayerZoom(
  object = NULL,
  xrange = NULL,
  yrange = NULL,
  expand_x = c(0, 0),
  expand_y = c(0, 0),
  round = 2,
  n_breaks = 5,
  unit = NULL,
  img_name = activeImage(object)
)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{xrange, yrange}{\link[=concept_distance_measure]{Distance vector} of length
two or \code{NULL}. If not \code{NULL}, specifies the x- and y-range to which
the spatial output is cropped. E.g. \code{xrange = c(200, 500)} results in
the two dimensional space being cropped from x-coordinate 200px up to
x-coordinate 500px. If \code{NULL}, the original range is used.}

\item{expand_x, expand_y}{Given to \code{expand} of \code{ggplot2::scale_x/y_continuous()}.}

\item{unit}{Character value. Overwrites the unit of the x- and y-axis. (If \code{NULL},
the defalt, the unit for the respective axis is taken from \code{xrange} and \code{yrange} input.)}

\item{img_name}{Character value. The name of the image of interest.
If \code{NULL}, the \link[=concept_active]{active} image is chosen by default. Either way, must
be one of \code{\link[=getImageNames]{getImageNames()}}.}
}
\value{
\code{ggpLayer*()}-functions return lists of \code{ggproto} objects
that can be added to ggplots via the \code{+} operator. In most of the cases
they are supposed to be added to plots created with the \code{plotSurface*()}
family.
}
\description{
Sets the limits on the x- and y-axis of a ggplot based on
manual input.
}
\examples{

library(SPATA2)
library(patchwork)

object <- loadExampleObject("UKF275T")

object <-
 createNumericAnnotations(
   object = object,
   variable = "HM_HYPOXIA",
   threshold = "kmeans_high",
   id = "hypoxia_ann",
   inner_borders = FALSE,
   force1 = TRUE
   )

# range of hypoxia annotation
hr <- getSpatAnnRange(object, id = "hypoxia_ann")

hr_ggpL <- ggpLayerSpatAnnOutline(object, ids = "hypoxia_ann")

plotSurface(object, "HM_HYPOXIA") + hr_ggpL

p_rect <-
 plotImage(object) +
 hr_ggpL +
 ggpLayerRect(object, xrange = hr$x, yrange = hr$y)

p_zoomed <-
 plotImage(object) +
 ggpLayerZoom(object, xrange = hr$x, yrange = hr$y)

p_rect + p_zoomed

}
