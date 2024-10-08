% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/d.R
\name{downloadFromPublication}
\alias{downloadFromPublication}
\title{Download data from publications}
\usage{
downloadFromPublication(pub, sample_name)
}
\arguments{
\item{pub}{Character value. The publication of interest.}

\item{id}{Character value. The id of the data object of interest.}
}
\value{
Depends argument input.
}
\description{
Downloads processed data as used in publications revolving
around SPATA2. See details for valid input options.
}
\details{
The following data can be downloaded.

From \emph{Kueckelhaus et al., 2024} with \code{pub = 'Kueckelhaus_et_al_2024'}.

\itemize{
\item{id = 'UKF313T'}{An object of class \code{SPATA2} containing human glioblastoma Visium data.}
\item{id = 'UKF269T'}{An object of class \code{SPATA2} containing human glioblastoma Visium data.}
\item{id = 'UKF265C'}{An object of class \code{SPATA2} containing human neocortex Visium data.}
\item{id = 'MCI_LMU'}{An object of class \code{SPATA2} containing injured mouse cortex Visium data.}
}
}
\examples{

  # download the processed SPATA2 object from sample UKF313T from Kueckelhaus et al., 2024.
 objectT313 <- downloadFromPublication(pub = "kueckelhaus_et_al_2024", what = "UKF313T")

}
\keyword{internal}
