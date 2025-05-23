% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getN-Z.R
\name{getSpatialAnnotations}
\alias{getSpatialAnnotations}
\alias{getSpatialAnnotations,SPATA2-method}
\alias{getSpatialAnnotations,SpatialData-method}
\title{Obtain list of SpatialAnnotation objects}
\usage{
getSpatialAnnotations(object, ...)

\S4method{getSpatialAnnotations}{SPATA2}(
  object,
  ids = NULL,
  class = NULL,
  tags = NULL,
  test = "any",
  add_image = containsImage(object),
  expand = 0,
  square = FALSE,
  error = FALSE,
  ...
)

\S4method{getSpatialAnnotations}{SpatialData}(
  object,
  ids = NULL,
  class = NULL,
  tags = NULL,
  test = "any",
  add_image = containsImage(object),
  expand = 0,
  square = FALSE,
  error = FALSE,
  ...
)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{...}{Used to absorb deprecated arguments or functions.}

\item{class}{Character vector or \code{NULL}. If character, defines the subtypes
of spatial annotations to consider. Must be a combination of \emph{c('Group', 'Image'
'Numeric')}.}

\item{tags}{Character vector or \code{NULL}. If character, the tags for the image annotation
selection. See section \emph{Selection of spatial annotations} for more information.}

\item{test}{Character value. One of \emph{c('any'. 'all', 'identical', 'not_identical', 'none')}.
Specifies how input for \code{tags} is used to select spatial annotations.
See section \emph{Selection of spatial annotations} for more information.}

\item{add_image}{Logical. If TRUE, the area of the histology image that
is occupied by the annotated structure is added to the \code{SpatialAnnotation}
object in slot @image. Dimensions of the image can be adjusted with \code{square}
and \code{expand}.}

\item{expand}{Specifies image expansion. An image that is cropped based on an image
annotation centers around the image annotation. If \code{expand = 0}, the default, the dimensions of the image,
that is width/x-axis and height/y-axis, are set to include only the image annotation area
and nothing more. Using \code{expand}, the cropped image section can be adjusted. See section
\emph{Expansion of cropped image sections} for more information.}

\item{square}{Logical value. Most image annotations come in variable shapes and
have different horizontal and vertical diameters. Therefore, height and width of the image
section are usually not equal. If \code{square = TRUE}, the cropped section of the image that
contains the annotated structure is forced into a square: the bigger diameter of both is taken
as default. E.g. if the horizontal diameter of the image annotation is 1mm and the
vertical diameter is 1.5mm, the output image will have height and width of 1.5mm. That is,
in terms of coordinates, an x-range and a y-range of 1.5mm.

Processing of the image output depending on argument \code{expand} happens afterwards.}

\item{error}{Logical. If \code{TRUE} and the input is invalid the
function throws an error.}

\item{strictly}{Logical. If \code{TRUE}, only barcodes of spots that are strictly interior
to the area of an spatial annotation are added to the output. If \code{FALSE},
barcodes of spots that are on the relative interior of the area or are
vertices of the border are added, too.}
}
\value{
A list of objects of class \code{SpatialAnnotation}.
}
\description{
Extracts a list of objects of class \code{\link{SpatialAnnotation}}.
}
\note{
To test how the extracted image section looks like depending
on input for argument \code{square} and \code{expand} use
\code{plotSpatialAnnotations(..., encircle = FALSE)}.
}
\section{Expansion of cropped image sections}{


The argument \code{expand} is a versatile way, to specify how a cropped
image section is extracted. If you want the cropped image as is, specify
\code{expand = 0}. Else, there are multiple options. In general, \code{expand} takes
three kinds of values, namely percentages, distances and distance exclamations.

\itemize{
\item{Percentage:}{ A string suffixed with \emph{\%}. E.g. \code{expand = '50\%'}
adds 50\% of the distance from the center to the border of the image annotation
to the image frame.}
\item{Distance measures:}{ In pixel or European units of length. E.g. \code{expand =  list(x = '1mm')}
expands the x-axis on both sides with 1mm. \verb{expand = list(x = c('0.5mm', 1.5mm')}
expands the x-axis on the left side with 0.5mm and on the right side with 1.5mm.}
\item{Exclam distance measures:}{ Distance measure with an exclamation mark
suffix. E.g. \code{expand = '1mm!'} centers the image and forces an axis length of
1 millimeter. (Example 5) }
}

Depending on how the values are specified different parts of the image can be
expanded.

Single values, like \code{expand = 50}, are recycled: Every end of each image axis
is expanded by 50 pixel. (Example 2)

Vectors of length two, like \code{expand = c('1mm', '2mm')}, are recycled: The beginning
of each axis is expanded by 1 millimeter. The end of each axis is expanded by
2mm. (Example 3)

Named lists can be more precise. \code{expand = list(x = c('1mm', '0.5mm'), y = c('0.25mm', '1mm'))}.
Applies the vectors to expand the corresponding axis. (Example 4)

Using exclam input the side of the axis must not be specified as the
axis is fixed as a whole. E.g \code{expand = list(x = '1mm!', y = '2mm!')} results
in the same output as \verb{expand = list(x = c('1mm!', '1mm!'), y = c('2mm!', '2mm!')}.
}

\section{Selection of spatial annotations}{


Selection of spatial annotations via the arguments \code{ids}, \code{class}, \code{tags} and
\code{test} works in three steps:

First, if \code{ids} is a character it prefilters the annotations by ID and only
the specified ones are submitted to the next steps. If it is \code{NULL}, all
annotations are submitted to the next steps.

Secondd, if \code{class} is a character it filters the annotations remaining
after the first step by their class. If \code{NULL}, the step is skipped.

Third, if \code{tags} is a character it is used in combination with \code{test} to select
from the spatial annotations that remain after the second step based on the meta data
they are tagged with. There are multiple options:
\enumerate{
\item Argument \code{test} set to \emph{'any'} or \emph{1}: To be included, an image annotation
must be tagged with at least one of the input tags.
\item Argument \code{test} set to \emph{'all'} or \emph{2}: To be included, an image annotation
must be tagged with all of the input tags. Can contain tags that are not specified.
\item Argument \code{test} set to \emph{'identical'} or \emph{3}: To be included, an image annotation
must be tagged with all of the input tags. Can not be tagged with anything else.
\item Argument \code{test} set to \emph{not_identical} or \emph{4}: To be included, an image
annotation must \strong{not} be tagged with the combination of input tags.
\item Argument \code{test} set to \emph{'none'} or \emph{5}: To be included, an image annotation
must \strong{not} contain any of the input tags.
}

If \code{tags} is \code{NULL}, the step is skipped. Therefore, if \code{ids}, \code{class} and \code{tags}
are all NULL, which is the default, all annotations are selected as all subsetting
steps are skipped. Eventually, the remaining spatial annotations are submitted to
whatever the respective function does.
}

