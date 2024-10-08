% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/r.R
\name{renameMolecularAssay}
\alias{renameMolecularAssay}
\title{Rename molecular assay}
\usage{
renameMolecularAssay(
  object,
  assay_name,
  new_assay_name,
  set_signatures = FALSE
)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{assay_name}{The name of the assay to be renamed.}

\item{new_assay_name}{The new name of the assay.}

\item{set_signatures}{Logical value. If \code{TRUE}, the slot @signatures of the assay is
populated with a new list. The function checks if the value for \code{new_assay_name} is
a known \link[=concept_molecular_modalites]{molecular modality} of SPATA2. If this
is the case, the corresponding list of signatures is set into the slot. Else, an
empty list is used.}
}
\value{
The updated input object, containing the added, removed or computed results.
}
\description{
Renames a molecular assay. Note that the name of an assay also defines it's molecular modality.
Only rename if you know what you are doing.
}
