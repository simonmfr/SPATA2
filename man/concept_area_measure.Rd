% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/concept-documentation.R
\name{concept_area_measure}
\alias{concept_area_measure}
\title{Area measures}
\description{
Several functions in \code{SPATA2} have arguments that take \emph{area input}.
To specifically refer to an area the unit must be specified. There are
three ways to create valid input for these arguments.

To test if the input is a valid distance measure use \code{\link[=is_area]{is_area()}}.
}
\section{Pixel and undefined units}{


There are two valid input options to specify an area in pixel:

\itemize{
\item{numeric:}{ Single numeric values, e.g. \code{arg_input = c(2, 3.554, 69, 100.67)}. If no unit
is specified the input will be interpreted as pixels.}
\item{character:}{ Suffixed with \emph{'px'}, e.g. \code{arg_input = c('2px', '3.554px', '69px', '100.67px')}}
}

Note:
The unit pixel and its abbreviaton \emph{'px'} is also used for numeric values which refer
to area measures without any unit at all.

Furthermore, the unit pixel (px) is used for distances as well as for areas. If pixel
refers to a distance the pixel side length is meant. If pixel refers to an area the
number of pixels is meant.
}

\section{According to the Systeme international d`unites (SI)}{


Specifying areas in SI units e.g. \code{arg_input = c('2mm2', '4mm2')} etc.
requires the input to be a character as the unit must be provided as suffix.
Between the numeric value and the unit must be no empty space! Valid suffixes
can be obtained using the function \code{validUnitsOfAreaSI()}.
}

\section{As vectors of class \code{unit}}{


Behind the scenes \code{SPATA2} works with the \code{units} package. Input
is converted into vectors of class \code{units}. Therefore, input can be directly
provided this way: \code{arg_input = units::set_unit(x = c(2,4), value = 'mm2')}
Note that \emph{pixel} is not a valid unit in the \code{units} package. If you want
to specify the input in pixel you have to use input option 1. In pixel.
}

\seealso{
Click \code{\link[=concept_distance_measure]{here}} for an elaboration
on distance measures in SPATA2.
}
\keyword{internal}
