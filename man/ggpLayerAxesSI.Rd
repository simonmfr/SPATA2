% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/g.R
\name{ggpLayerAxesSI}
\alias{ggpLayerAxesSI}
\title{Display axes with SI units of length}
\usage{
ggpLayerAxesSI(
  object,
  unit = getSpatialMethod(object)@unit,
  which = c("x", "y"),
  breaks = NULL,
  add_labs = TRUE,
  round = 2,
  xrange = NULL,
  yrange = NULL,
  ...
)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{unit}{The desired unit. Defaults to the unit
in which the original size of the image of the spatial method is
provided. Obtain valid input options with \code{validUnitsOfLengthSI()}.}

\item{which}{One or two of \emph{'x'} and \emph{'y'}. Specifies
for which axes the transformation is performed. Defaults to both.}

\item{breaks}{Specifies where the breaks are set. Labels are plotted in the unit
specified in \code{unit}. Valid input:

\itemize{
\item{\code{NULL}:}{ No specification. Five breaks are set equally distributed. Does not work with STS/IAS related plots as
the range is taken from the whole image.}
\item{\code{vector}:}{ Vector of distance measures. Breaks are set for axes denoted in \code{which}. (Defaults to both, x and y.)}
\item{\code{list}:}{ List with slots \emph{x} and \emph{y}. Vector of distance measures to set each axis specifically.}
}}

\item{add_labs}{Logical. If \code{TRUE}, adds x- and y-labs to the plot.}

\item{round}{Numeric value or \code{FALSE}. If numeric, given to \code{digits}
of \code{base::round()}. Rounds transformed values before they are returned.}

\item{xrange, yrange}{\link[=concept_distance_measure]{Distance vector} of length
two or \code{NULL}. If not \code{NULL}, specifies the x- and y-range to which
the spatial output is cropped. E.g. \code{xrange = c(200, 500)} results in
the two dimensional space being cropped from x-coordinate 200px up to
x-coordinate 500px. If \code{NULL}, the original range is used.}

\item{...}{Used to absorb deprecated arguments or functions.}

\item{expand}{Specifies how the axis are expanded. Using \code{expand} of \code{ggplot2::scale_x/y_continuous()}.
Valid input:

\itemize{
\item{\code{NULL} or \code{TRUE}:}{ No specification. Default is used.}
\item{\code{FALSE}:}{ No expansion.}
\item{\code{vector}:}{ Numeric vector of length two. Input is set for axes denoted in \code{which}. (Defaults to both, x and y.)}
\item{\code{list}:}{ List with slots \emph{x} and \emph{y}. Numeric vector of length two, used for each axis specifically.}
}}

\item{breaks_x, breaks_y}{Deprecated in favor of \code{breaks}.}

\item{frame_by}{Deprecated. Use \verb{ggplayerFrame*()} - functions.}

\item{xlim, ylim}{Vectors of length two. Distance measures that set the limits
on the respective axes.}
}
\value{
\code{ggpLayer*()}-functions return lists of \code{ggproto} objects
that can be added to ggplots via the \code{+} operator. In most of the cases
they are supposed to be added to plots created with the \code{plotSurface*()}
family.
}
\description{
Performs necessary transformations to display axes of
surface plots and STS/IAS line- or ridgeplots with SI units of length.
}
\details{
Several functions in \code{SPATA2} have arguments that take \emph{distance input}.
To specifically refer to a distance the unit must be specified. There are
three ways to create valid input for these arguments.

\strong{1. In pixel:}

There are two valid input options to specify the distance in pixel:

\itemize{
\item{numeric:}{ Single numeric values, e.g. \code{arg_input <- c(2, 3.554, 69, 100.67)}. If no unit
is specified the input will be interpreted as pixels.}
\item{character:}{ Suffixed with \emph{'px'}, e.g. \code{arg_input <- c('2px', '3.554px', '69px', '100.67px')}}
}

Note: The unit pixel (px) is used for distances as well as for areas. If pixel
refers to a distance the pixel side length is meant. If pixel refers to an area the
number of pixels is meant.

\strong{2. According to the Systeme international d`unites (SI):}

Specifying distances in SI units e.g. \code{arg_input <- c('2mm', '4mm')} etc.
requires the input to be a character as the unit must be provided as suffix.
Between the numeric value and the unit must be no empty space! Valid suffixes
can be obtained using the function \code{validUnitsOfLengthSI()}.

\strong{3. As vectors of class \code{unit}:}

Behind the scenes \code{SPATA2} works with the \code{units} package. Input
is converted into vectors of class \code{units}. Therefore, input can be directly
provided this way: \code{arg_input <- units::set_unit(x = c(2,4), value = 'mm')}
Note that \emph{pixel} is not a valid unit in the \code{units} package. If you want
to specify the input in pixel you have to use input option 1. In pixel.
}
\examples{

library(SPATA2)

data("example_data")

object <- loadExampleObject("UKF275T")

 containsPixelScaleFactor(object) # must be TRUE

 # no axes specification
 plotSurface(object, color_by = "METRN") +
  ggpLayerThemeCoords()

 # in millimeters
 plotSurface(object, color_by = "METRN") +
  ggpLayerThemeCoords() +
  ggpLayerAxesSI(object, unit = "mm")


 # in millimeters set specifically
 my_breaks <- str_c(1:7, "mm")

 print(my_breaks)

 # breaks can be a vector of distance values
 plotSurface(object, color_by = "METRN") +
  ggpLayerThemeCoords() +
  ggpLayerAxesSI(object, unit = "mm", breaks = my_breaks, add_labs = TRUE)

 # or a list of vectors of distance values for each axis
 plotSurface(object, color_by = "METRN") +
  ggpLayerThemeCoords() +
  ggpLayerAxesSI(object, unit = "mm", breaks = list(x = my_breaks, y = str_c(2:5, "mm")), add_labs = TRUE)


}
