% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dev.R
\name{addMoleculeCoordinates}
\alias{addMoleculeCoordinates}
\title{Add molecule coordinates}
\usage{
addMoleculeCoordinates(
  object,
  coordinates = NULL,
  assay_name = activeAssay(object)
)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{coordinates}{A data frame containing the coordinates to be added. The data frame must contain the following variables:
\itemize{
\item \emph{molecule} or \emph{<assay_name>} Identifier for the molecules. E.g. if
\item \emph{x_orig} or \emph{x}:  x-coordinates (original or to be scaled back to original).
\item \emph{y_orig} or \emph{y}: y-coordinates (original or to be scaled back to original).
}}

\item{assay_name}{Only relevant if the \code{SPATA2} object contains more than
one assay: Denotes the assay of interest and thus the
\link[=concept_molecular_modalities]{molecular modality} to use. Defaults to the active assay
as set by \code{\link[=activateAssay]{activateAssay()}}.}
}
\value{
The updated input object, containing the added, removed or computed results.
}
\description{
Adds or updates the molecule coordinates for a specified assay in the given object.
}
\details{
This function processes the provided coordinates data frame to ensure
it contains the necessary variables (\code{molecule} or the assay name, \code{x} or \code{x_orig},
and \code{y} or \code{y_orig}). If only the scaled coordinates (\code{x} and \code{y}) are provided,
they are scaled back to the original coordinate frame using the image scale factor.
The resulting data frame is then nested by the assay modality and integrated into
the molecular metadata variables of the object.

Results are stored in a nested column in the molecular meta variable data.frame
called \emph{coords}.
}
\seealso{
\code{\link[=getMolecularCoordinates]{getMolecularCoordinates()}}, \code{\link[=getMetaVarDf]{getMetaVarDf()}}
}
