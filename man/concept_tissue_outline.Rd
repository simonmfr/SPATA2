% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/concept-documentation.R
\name{concept_tissue_outline}
\alias{concept_tissue_outline}
\title{Tissue Outline}
\description{
The tissue outline provides information about the spatial boundaries of tissue
analyzed. It is represented by detailed polygons that outline the tissue edge. If
the tissue contained by the \code{\link{SPATA2}} object is one single continuous section,
only one polygon is required. If the tissue contains multiple sections, multiple
polygons are required.

Every single polygon required to outline the tissue is represented by a data.frame
in which each row corresponds to a vertex of this polygon. The columns provide
the x- and y-coordinates of the vertices.

The tissue outline is computed by the function \code{\link[=identifyTissueOutline]{identifyTissueOutline()}}.
There are two ways to outline the tissue indicated by the argument \code{method}.
The concept behind either method is elaborated on in the two following
sections \emph{Tissue outline - Image} for \code{method = 'image'} and
\emph{Tissue outline - Observations} for \code{method = 'obs'}.
}
\note{
A \code{SPATA2} object can contain both, a tissue outline based on the
it's observations and on the image (or multiple images for that matter). The
tissue outline based on the observations is stored in slot @outline of
the \code{\link{SpatialData}} object. The tissue outline based on an image lives
in slot @outline of the \code{\link{HistoImage}} container of the respective image (which
in turn lives in @slot images of the \code{\link{SpatialData}} object next to the other
\code{\link{HistoImage}} containers.)
}
\section{Tissue outline - Image}{

The tissue outline based on the image requires the results of \code{\link[=identifyPixelContent]{identifyPixelContent()}}
which assigns each pixel of an image to one of the following categories:

\itemize{
\item{Tissue segment:}{ A contiguous tissue section valid for downstream analyis.}
\item{Tissue fragment:}{ A contiguous tissue section that might not be big enough to
be included in downstream analysis.}
\item{Artifcat:}{ Objects on the image that are likely to be artifacts.}
\item{Background:}{The background.}
}

Pixels or pixel groups that are categorized as belonging to tissue segments are
included in the computation of the tissue outline. Therefore the resulting
tissue outline as obtained by \code{\link[=getTissueOutlineDf]{getTissueOutlineDf()}} with \code{method = 'image'}
corresponds to the spatial extent of what was identified as tissue by the image
processing of \code{\link[=identifyPixelContent]{identifyPixelContent()}}.
}

\section{Tissue outline - Observations}{

All \code{SPATA2} objects contain molecular data mapped to \emph{\link[=concept_observations]{observations}},
e.g. barcoded spots, barcoded beads or cells. Several platforms, such as
MERFISH or XENIUM do not provide an image. In this scenario, the outline is computed
as the polygons required to appropriately outline the tissue based on the position
of these data points.
}

\seealso{
\code{\link[=identifyPixelContent]{identifyPixelContent()}}, \code{\link[=identifyTissueOutline]{identifyTissueOutline()}}, \code{\link[=identifySpatialOutliers]{identifySpatialOutliers()}},
\code{\link[=getTissueOutlineDf]{getTissueOutlineDf()}}
}
\keyword{internal}
