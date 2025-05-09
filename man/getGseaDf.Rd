% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getA-G.R
\name{getGseaDf}
\alias{getGseaDf}
\title{Obtain enrichment data.frame}
\usage{
getGseaDf(
  object,
  across,
  across_subset = NULL,
  method_de = NULL,
  n_gsets = Inf,
  signif_var = "fdr",
  signif_threshold = 1,
  stop_if_null = TRUE
)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{across}{Character value or NULL. Specifies the grouping variable of interest.

Use \code{getGroupingOptions()} to obtain all variable names that group the
barcode spots of your object in a certain manner.}

\item{across_subset}{Character vector or NULL. Specifies the particular groups
of interest the grouping variable specified in argument \code{across} contains.

If set to NULL all of them are chosen. You can prefix groups you are NOT interested in
with a \emph{'-'}. (Saves writing if there are more groups you are interested in
than groups you are not interested in.)

Use \code{getGroupNames()} to obtain all valid input options.}

\item{method_de}{Character value. Denotes the method to according to which the de-analysis is performed.
Given to argument \code{test.use} of the \code{Seurat::FindAllMarkers()}-function. Run \code{SPATA::dea_methods}
to obtain all valid input options.}

\item{n_gsets}{Numeric value. Maximal number of gene sets whose results are included.
The first \code{n_gsets} are included starting with the one with the lowest significance value.}

\item{signif_var}{Character value. Determines what to be considered while checking
for significance. Either \emph{'pval'} (p-Value) or \emph{'fdr'} (False Discovery Rate).}

\item{signif_threshold}{Numeric value. Significance values below \code{signif_threshold}
are not included.}
}
\value{
Data.frame that contains results of gene set enrichment
analysis.
}
\description{
Extracts results from a gene set enrichment analysis
in form of a data.frame.
}
