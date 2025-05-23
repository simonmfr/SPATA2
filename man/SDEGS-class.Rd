% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/S4-documentation.R
\docType{class}
\name{SDEGS-class}
\alias{SDEGS-class}
\alias{SDEGS}
\title{The \code{SDEGS}-class}
\description{
S4 class that serves as a container for results of detection of spatially
differentially expressed genes (SDEGs) as suggested by \emph{Zeng et al. 2023}.
Contains the results of \code{\link[=findSDEGS]{findSDEGS()}}
}
\section{Slots}{

\describe{
\item{\code{coordinates}}{data.frame. Data.frame of four variables \emph{barcodes}, \emph{x}, \emph{y},
\emph{bins_dist} to visualize the testing set up.}

\item{\code{dea_1v1}}{list. List of data.frames each containing the differentially
expressed genes for the circle bin vs. \emph{Control} according to which the slot containing
the data.frame is named (as returned by \code{Seurat::FindMarkers()}).}

\item{\code{dea_all}}{data.frame.  Data.frame of DEA testing as returned by \code{Seurat::FindAllMarkers()}.}

\item{\code{spat_ann}}{SpatialAnnotation. The spatial annotation based on which
the testing was conducted.}

\item{\code{spatial_parameters}}{list. List of three slots named \emph{binwidth}, \emph{distance},
\emph{n_bins_dist} as was set up using the corresponding parameters.}

\item{\code{sample}}{character. Name of the sample to which the results belong.}
}}

\references{
This is an R-implementation of the approach suggested by
Zeng, H., Huang, J., Zhou, H. et al. Integrative in situ mapping of single-cell
transcriptional states and tissue histopathology in a mouse model of Alzheimer's
disease. Nat Neurosci 26, 430-446 (2023).
}
\seealso{
\code{\link[=findSDEGS]{findSDEGS()}}
}
\keyword{internal}
