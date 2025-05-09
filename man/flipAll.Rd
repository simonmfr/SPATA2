% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f.R
\name{flipAll}
\alias{flipAll}
\alias{flipCaptureArea}
\alias{flipCoordinates}
\alias{flipCoordsDf}
\alias{flipImage}
\alias{flipSpatialAnnotations}
\alias{flipSpatialTrajectories}
\title{Mirror invert image and coordinates}
\usage{
flipAll(object, axis, verbose = FALSE)

flipCaptureArea(object, axis, verbose = NULL)

flipCoordinates(object, axis, verbose = FALSE)

flipCoordsDf(object, axis, verbose = FALSE)

flipImage(object, axis, img_name = NULL, verbose = FALSE)

flipSpatialAnnotations(object, axis, verbose = NULL)

flipSpatialTrajectories(object, axis, verbose = NULL)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{axis}{Character value. The axis around which the content is flipped.
Either \emph{'horizontal'}, \emph{'h'}, \emph{'vertical'} or \emph{'v'}.}

\item{verbose}{Logical. If \code{TRUE}, informative messages regarding
the computational progress will be printed.

(Warning messages will always be printed.)}

\item{img_name}{Character value. The name of the image of interest.
If \code{NULL}, the \link[=concept_active]{active} image is chosen by default. Either way, must
be one of \code{\link[=getImageNames]{getImageNames()}}.}
}
\description{
The \verb{flip*()} family mirror inverts the current image
or coordinates of spatial aspects or everything. See details
for more information.

\strong{NOTE:} \code{flipImage()} only flips the image and lets everything else as
is. Only use it if you want to flip the image because it is not aligned
with the spatial coordinates. If you want to flip the image
while maintaining alignment with the spatial aspects in the \code{spata2} object
use \code{flipAll()}!
}
\details{
The \verb{flip*()} functions can be used to flip the complete \code{SPATA2}
object or to flip single aspects.

\itemize{
\item{\code{flipAll()}:}{ Flips everything.}
\item{\code{flipImage()}:}{ Flips only the image.}
\item{\code{flipCoordinates()}:}{ Flips the coordinates data.frame, spatial annotations
and spatial trajectories.}
\item{\code{flipCoordsDf()}:}{ Flips the coordinates data.frame.}
\item{\code{flipSpatialAnnotations()}:}{ Flips spatial annotations.}
\item{\code{flipSpatialTrajectories()}:}{ Flips spatial trajectories.}
}
}
\examples{
library(SPATA2)
library(tidyverse)

data("example_data")

object <- example_data$object_UKF275T_diet

plotSurface(object, display_image = T)

object <- flipImage(object, axis = "h")

plotSurface(object, display_image = T)

object <- flipCoordinates(object, axis = "h")

plotSurface(object, display_image = T)

object <- flipAll(object, axis = "v")

plotSurface(object, display_image = T)


}
