% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create.R
\name{createNumericAnnotations}
\alias{createNumericAnnotations}
\title{Create spatial annotations based on numeric values}
\usage{
createNumericAnnotations(
  object,
  variable,
  threshold,
  id,
  tags = NULL,
  tags_expand = TRUE,
  use_dbscan = TRUE,
  inner_borders = TRUE,
  eps = recDbscanEps(object),
  minPts = recDbscanMinPts(object),
  force1 = FALSE,
  fct_incr = 1,
  min_size = nObs(object) * 0.01,
  method_outline = "concaveman",
  alpha = recAlpha(object),
  concavity = 2,
  method_gs = NULL,
  transform_with = NULL,
  overwrite = FALSE,
  verbose = NULL,
  ...
)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{variable}{Character value. The name of the numeric \link[=concept_variables]{variable} of interest.}

\item{threshold}{Character value. Determines the method and/or the threshold
by which the data points are filtered. Valid input options are \emph{'kmeans_high'},
\emph{'kmeans_low'} and operator-value combinations such as \emph{'>0.75'} or \emph{'<=0.5'}.
See details for more.}

\item{id}{Character value. The ID of the spatial annotation. If \code{NULL},
the ID of the annotation is created by combining the string \emph{'spat_ann'} with
the index the new annotation has in the list of all annotations.}

\item{tags}{A character vector of tags for the spatial annotation.}

\item{tags_expand}{Logical value. If \code{TRUE}, the tags with which the image
annotations are tagged are expanded by the unsuffixed \code{id}, the \code{variable},
the \code{threshold} and \emph{'createGroupAnnotations'}.}

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

\item{force1}{Logical value. If \code{TRUE}, spatial sub groups identified by DBSCAN
are merged into one cluster. \strong{Note}: If \code{FALSE} (the default), the input for \code{ìd} is suffixed
with an index to label each spatial annotation created uniquely, regardless of
how many are eventually created. E.g. if \code{id = "my_ann"} and the algorithm
created two spatial annotations, they are named \emph{my_ann_1} and \emph{my_ann_2}.}

\item{min_size}{Numeric value. The minimum number of data points a dbscan cluster
must have in order not to be discarded as a spatial outlier.}

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

\item{method_gs}{Character value. The method according to which gene sets will
be handled specified as a character of length one. This can be either 'mean
or one of 'gsva', 'ssgsea', 'zscore', or 'plage'. The latter four will be given to gsva::GSVA().}

\item{transform_with}{List or \code{NULL.} If list, can be used to transform continuous variables before usage.
Names of the list slots refer to the variable. The content of the slot refers to the transforming functions.
E.g if the variable of interest is \emph{GFAP} gene expression, the following would work:

\itemize{
\item{Single function:}{ \code{transform_with = log10}},
\item{Multiple functions:}{ \verb{transform_with = list(GFAP = list(log10, log2)}}
}

In case of plotting:
Useful if you want to apply more than one transformation on variables mapped to
plotting aesthetics. Input for \code{transform_with} is applied before the
respective \code{<aes>_trans} argument.}

\item{overwrite}{Logical value. Must be \code{TRUE} to allow overwriting.}

\item{verbose}{Logical. If \code{TRUE}, informative messages regarding
the computational progress will be printed.

(Warning messages will always be printed.)}

\item{...}{Additional slot content given to \code{methods::new()} when
constructing the \code{\link{SpatialAnnotation}} object.}
}
\value{
The updated input object, containing the added, removed or computed results.
}
\description{
Creates spatial annotations based on gene expression or any other
continous data variable (e.g. read counts, copy number alterations). See
details for more.
}
\details{
The function \code{createNumericAnnotations()} facilitates the mapping of expression values
associated with data points (spots or cells) to an image. This process is achieved by identifying
data points that meet the criteria set by the \code{threshold} input, encompassing them within a
polygon that serves as the foundation for creating a \code{SpatialAnnotation}. The annotation procedure,
based on the position of data points showcasing specific expression values, involves the following key steps.

\enumerate{
\item{Data point filtering:}{ The data points from the coordinates data.frame are selectively retained
based on the values of the variable specified in the \code{variable} argument. How the filtering
is conducted depends on \code{threshold}.}
\item{Grouping:}{ The remaining data points are organized into groups, a behavior influenced by the values
of \code{use_dbscan} and \code{force1} arguments.}
\item{Outlining:}{ Each group of data points is subject to the concaveman algorithm, resulting in
the creation of an outlining polygon.}
\item{Spatial annotation:}{ The generated concave polygons serve as the foundation for crafting spatial annotations.}
}

In-depth Explanation:
Initially, the coordinates data.frame is joined with the variable indicated in
the \code{variable} argument. Subsequently, the \code{threshold} input is applied.
Two primary methods exist for conducting thresholding. If \code{threshold} is
either \emph{'kmeans_high'} or \emph{'kmeans_low'}, the data points undergo clustering
based solely on their variable values, with \code{centers = 2}. Depending on
the chosen approach, the group of data points with the highest or lowest mean
is retained, while the other group is excluded.

Alternatively, the threshold can comprise a combination of a logical operator
(e.g., \code{'>'}, \code{'>='}, \code{'<='}, or \code{'<'}) and a numeric value.
This combination filters the data points accordingly. For instance, using
\code{variable = 'GFAP'} and \code{threshold = '> 0.75'} results in retaining
only those data points with a GFAP value of 0.75 or higher.

Following filtering, if \code{use_dbscan} is \code{TRUE}, the DBSCAN algorithm
identifies spatial outliers, which are then removed. Furthermore, if DBSCAN
detects multiple dense clusters, they can be merged into a single group
if \code{force1} is also set to \code{TRUE}.

It is essential to note that bypassing the DBSCAN step may lead to the inclusion
of individual data points dispersed across the sample. This results in a spatial
annotation that essentially spans the entirety of the sample, lacking the
segregation of specific variable expressions. Similarly, enabling \code{force1}
might unify multiple segregated areas, present on both sides of the sample, into one
group and subsequently, one spatial annotation encompassing the whole sample.
Consider to allow the creation of multiple spatial annotations (suffixed with an index)
and merging them afterwards via \code{\link[=mergeSpatialAnnotations]{mergeSpatialAnnotations()}} if they are too
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
library(patchwork)

data("example_data")

object <- example_data$object_UKF275T_diet

# create an image annotation based on the segregated area of
# high expression in hypoxia signatures
 object <-
   createNumericAnnotations(
     object = object,
     variable = "HM_HYPOXIA",
     threshold = "kmeans_high",
     id = "hypoxia",
     tags = "hypoxic"
   )

 # visualize both
 plotSurface(object, color_by = "HM_HYPOXIA") +
   legendLeft() +

 plotImage(object) +
   ggpLayerSpatAnnOutline(object, tags = c("hypoxic"))

}
\references{
P. J. de Oliveira and A. C. P. F. da Silva (2012). alphahull:
Generalization of the convex hull of a sample of points in the plane. R package version 2.1.
\url{https://CRAN.R-project.org/package=alphahull}

Graham, D., & Heaton, D. (2018). concaveman: A very fast 2D concave hull algorithm.
R package version 1.1.0. \url{https://CRAN.R-project.org/package=concaveman}
}
\seealso{
\code{\link[dbscan:dbscan]{dbscan::dbscan()}}, \code{\link[=recDbscanEps]{recDbscanEps()}}, \code{\link[=recDbscanMinPts]{recDbscanMinPts()}}, \code{\link[concaveman:concaveman]{concaveman::concaveman()}}
}
