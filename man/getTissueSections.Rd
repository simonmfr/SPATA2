% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getN-Z.R
\name{getTissueSections}
\alias{getTissueSections}
\title{Obtain the names of tissue sections}
\usage{
getTissueSections(object)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}
}
\value{
A character vector of unique tissue sections, excluding "tissue_section_0".
}
\description{
Extracts unique tissue sections from the metadata of the given object.
}
\examples{

library(SPATA2)

object <- loadExampleObject("LMU_MCI", process = TRUE)

tissue_sections <- getTissueSections(object)

print(tissue_sections)

plotSurface(object, color_by = "tissue_section")

}
\seealso{
\code{\link[=identifyTissueOutline]{identifyTissueOutline()}}
}
