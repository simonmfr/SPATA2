% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create.R
\name{createGroupAnnotations}
\alias{createGroupAnnotations}
\title{Create spatial annotations from a group of data points}
\usage{
createGroupAnnotations(
  object,
  grouping,
  group,
  id,
  tags = NULL,
  tags_expand = TRUE,
  use_dbscan = TRUE,
  inner_borders = TRUE,
  eps = recDbscanEps(object),
  minPts = recDbscanMinPts(object),
  min_size = nObs(object) * 0.01,
  force1 = FALSE,
  method_outline = "concaveman",
  alpha = recAlpha(object),
  concavity = 2,
  overwrite = FALSE,
  verbose = NULL
)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{grouping}{Character value. The grouping variable containing the group
of interest.}

\item{group}{Character value. The group of interest.}

\item{id}{Character value. The ID of the spatial annotation. If \code{NULL},
the ID of the annotation is created by combining the string \emph{'spat_ann'} with
the index the new annotation has in the list of all annotations.}

\item{tags}{A character vector of tags for the spatial annotation.}

\item{tags_expand}{Logical value. If \code{TRUE}, the tags with which the image
annotations are tagged are expanded by the unsuffixed \code{id}, the \code{grouping},
the \code{group} and \emph{'createGroupAnnotations'}.}

\item{use_dbscan}{Logical value. If \code{TRUE}, the DBSCAN algorithm is used to identify
spatial clusters and outliers before the outline of the spatial annotation is drawn.}

\item{inner_borders}{Logical value. If \code{TRUE}, the algorithm checks whether the
annotation requires inner borders and sets them accordingly. If \code{FALSE}, only
an outer border is created.}

\item{eps}{Distance measure. Given to \code{eps} of \code{\link[dbscan:dbscan]{dbscan::dbscan()}}. Determines
the size (radius) of the epsilon neighborhood.}

\item{minPts}{Numeric value. Given to \code{\link[dbscan:dbscan]{dbscan::dbscan()}}. Determines the
number of minimum points required in the eps neighborhood for core points
(including the point itself)}

\item{min_size}{Numeric value. The minimum number of data points a dbscan cluster
must have in order not to be discarded as a spatial outlier.}

\item{force1}{Logical value. If \code{TRUE}, spatial sub groups identified by DBSCAN
are merged into one cluster. \strong{Note}: If \code{FALSE} (the default), the input for \code{ìd} is suffixed
with an index to label each spatial annotation created uniquely, regardless of
how many are eventually created. E.g. if \code{id = "my_ann"} and the algorithm
created two spatial annotations, they are named \emph{my_ann_1} and \emph{my_ann_2}.}

\item{method_outline}{Character value. The method used to create the outline
of the spatial annotations. Either \emph{'concaveman'} or \emph{'alphahull'}.

\itemize{
\item{\emph{'concaveman'}:}{ A fast algorithm that creates concave hulls with adjustable detail.
It captures more intricate shapes and is generally computationally efficient, but may produce
less smooth outlines compared to alpha shapes. \code{concavity} determines the level of detail.}
\item{\emph{'alphahull'}:}{ (BETA) Generates an alpha shape outline by controlling the boundary tightness
with the \code{alpha} parameter. Smaller \code{alpha} values produce highly detailed boundaries, while
larger values approximate convex shapes. It’s more precise for capturing complex edges but
can be computationally more intensive.}
}}

\item{alpha}{Numeric value. Given to \code{alpha} of \code{\link[alphahull:ahull]{alphahull::ahull()}}.
Default is \code{\link[=recAlpha]{platform dependent}}.}

\item{concavity}{Numeric value. Given to argument \code{concavity} of
\code{\link[concaveman:concaveman]{concaveman::concaveman()}}. Determines the relative measure of concavity.
1 results in a relatively detailed shape, Infinity results in a convex hull.
You can use values lower than 1, but they can produce pretty crazy shapes.}

\item{overwrite}{Logical value. Must be \code{TRUE} to allow overwriting.}

\item{verbose}{Logical. If \code{TRUE}, informative messages regarding
the computational progress will be printed.

(Warning messages will always be printed.)}
}
\value{
The updated input object, containing the added, removed or computed results.
}
\description{
Creates spatial annotations based on the spatial extent of a
group of data points (spots or cells). See details for more information.
}
\details{
The functions filters the coordinates data.frame obtained via \code{getCoordsDf()}
based on the input of argument \code{grouping} and \code{group}.

Following filtering, if \code{use_dbscan} is \code{TRUE}, the DBSCAN algorithm
identifies spatial outliers, which are then removed. Furthermore, if DBSCAN
detects multiple dense clusters, they can be merged into a single group
if \code{force1} is also set to \code{TRUE}.

It is essential to note that bypassing the DBSCAN step may lead to the inclusion
of individual data points dispersed across the sample. This results in an image
annotation that essentially spans the entirety of the sample, lacking the
segregation of specific variable expressions. Similarly, enabling \code{force1}
might unify multiple segregated areas, present on both sides of the sample, into one
group and subsequently, one spatial annotation encompassing the whole sample.
Consider to allow the creation of multiple spatial annotations (suffixed with an index)
and merging them afterwards via \code{mergeSpatialAnnotations()} if they are too
close together.

Lastly, the remaining data points are fed into either the concaveman or the alphahull algorithm on a
per-group basis. The algorithm calculates polygons outlining the groups
of data points. If \code{dbscan_use} is \code{FALSE}, all data points that remained after the
initial filtering are submitted to the algorithm. Subsequently, these polygons are
integrated into \code{addSpatialAnnotation()} along with the unsuffixed \code{id} and
\code{tags} input arguments. The ID is suffixed with an index for each group.
}
\section{Distance measures}{


The vignette on distance measures in SPATA2 has been replaced. Click
\code{\link[=concept_distance_measure]{here}} to read it.
}

\examples{

library(SPATA2)
library(tidyverse)

data("example_data")

object <- example_data$object_UKF275T_diet

object <-
 createGroupAnnotations(
   object = object,
   grouping = "bayes_space",
   group = "1",
   id = "bspace1",
   tags = "bspace_ann"
   )

 plotSurface(object, color_by = "bayes_space") +
   ggpLayerSpatAnnOutline(object, tags = "bspace_ann")

}
\references{
P. J. de Oliveira and A. C. P. F. da Silva (2012). alphahull:
Generalization of the convex hull of a sample of points in the plane. R package version 2.1.
\url{https://CRAN.R-project.org/package=alphahull}

Graham, D., & Heaton, D. (2018). concaveman: A very fast 2D concave hull algorithm.
R package version 1.1.0. \url{https://CRAN.R-project.org/package=concaveman}
}
\seealso{
\code{\link[=recDbscanEps]{recDbscanEps()}}, \code{\link[=recDbscanMinPts]{recDbscanMinPts()}}
}
