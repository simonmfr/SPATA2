% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/g.R
\name{ggpLayerSpatAnnRect}
\alias{ggpLayerSpatAnnRect}
\title{Add a rectangular around an spatial annotation}
\usage{
ggpLayerSpatAnnRect(object, ids, expand = "25\%", ...)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{expand}{Specifies image expansion. An image that is cropped based on an image
annotation centers around the image annotation. If \code{expand = 0}, the default, the dimensions of the image,
that is width/x-axis and height/y-axis, are set to include only the image annotation area
and nothing more. Using \code{expand}, the cropped image section can be adjusted. See section
\emph{Expansion of cropped image sections} for more information.}

\item{...}{Used to absorb deprecated arguments or functions.}
}
\value{
A ggplot.
}
\description{
Adds a rectangular to the surface plot that visualizes
the spatial extent of the cropped image section as plotted by
\code{plotImageAnnotations()}.
}
