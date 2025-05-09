% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getN-Z.R
\name{getStsDf}
\alias{getStsDf}
\title{Obtain spatial trajectory screening data.frame}
\usage{
getStsDf(
  object,
  variables,
  id = idST(object),
  resolution = recSgsRes(object),
  width = NULL,
  unit = getDefaultUnit(object),
  ro = c(0, 1),
  bcs_exclude = NULL,
  format = "wide",
  control = NULL,
  verbose = FALSE,
  ...
)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{variables}{Character vector. All numeric variables to be included in
the screening process.}

\item{resolution}{\link[=concept_distance_measure]{Distance measure}. The resolution
with which the expression gradient is inferred. Defaults are platform specific.
See more in detail section of \code{\link[=recSgsRes]{recSgsRes()}}.}

\item{width}{Distance measure. The width of the trajectory frame. Defaults
to the trajectory length.}

\item{unit}{Character value. Specifies the desired unit in
which \link[=concept_distance_measure]{distance measures}
or  \link[=concept_area_measure]{area measures} are provided.
Run \code{\link[=validUnitsOfLength]{validUnitsOfLength()}} or \code{\link[=validUnitsOfArea]{validUnitsOfArea()}} for valid
input options.}

\item{ro}{The numeric range to which the output gradients is scaled. Defaults
to c(0,1).}

\item{bcs_exclude}{Character value containing the barcodes of observations to be excluded
from the analysis.}

\item{format}{Character value. Either \emph{'long'} or \emph{'wide'}. Defaults to
\emph{'wide'}. If \emph{'wide'} each variable gets a column.  If \emph{'long'}, the data.frame
is organized such that a column called \emph{variables} contains the variable names
and a column called \emph{'values'} contains the values.}

\item{control}{A list of arguments as taken from \code{\link[stats:loess.control]{stats::loess.control()}}.
Default setting is stored in \code{SPATA2::sgs_loess_control}.}

\item{verbose}{Logical. If \code{TRUE}, informative messages regarding
the computational progress will be printed.

(Warning messages will always be printed.)}

\item{...}{Used to absorb deprecated arguments or functions.}
}
\value{
Data.frame.
}
\description{
Extracts a data.frame of inferred gradients related to the
course of a trajectory.
}
