% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f.R
\name{filterDeaDf}
\alias{filterDeaDf}
\title{Postprocess DEA results}
\usage{
filterDeaDf(
  dea_df,
  max_adj_pval = 0.05,
  min_lfc = 0,
  n_highest_lfc = 25,
  n_lowest_pval = 25,
  across_subset = NULL,
  relevel = FALSE,
  return = "data.frame"
)
}
\arguments{
\item{dea_df}{A data.frame containing information about differentially expressed genes. Must contain the variables:

\describe{
\item{\emph{gene}}{Character. The differentially expressed genes.}
\item{\emph{cluster}}{Character. The clusters (or experimental groups) across which the analysis was performed.}
\item{\emph{avg_logFC}}{Numeric. The average log-fold change to which the belonging gene was differentially expressed..}
\item{\emph{p_val}}{Numeric. The p-values.}
\item{\emph{p_val_adj}}{Numeric. The adjusted p-values.}
}

Hint: Use the resulting data.frame of \code{SPATA::findDE()} or it's descendants as input.}

\item{max_adj_pval}{Numeric value. Sets the threshold for adjusted p-values. All genes
with adjusted p-values above that threshold are ignored.}

\item{min_lfc}{Numeric value. Sets the threshold for average log fold change. All genes
with an average log fold change below that threshold are ignored.}

\item{n_highest_lfc}{Numeric value. Affects the total number of genes that are kept. See details.}

\item{n_lowest_pval}{Numeric value. Affects the total number of genes that are kept. See details.}

\item{return}{Character value. Denotes the output type. One of \emph{'data.frame', 'vector'} or \emph{'list}}
}
\value{
Depends on input of argument \code{return}:

\itemize{
\item{ \code{return} = \emph{'data.frame'}: The filtered data.frame of \code{dea_df} with all its variables.}
\item{ \code{return} = \emph{'vector'}: A named vector of all genes that remain. Named by the experimental
group in which they were differently expressed.}
\item{ \code{return} = \emph{'list}: A list named according to the experimental groups. Every slot of that list is
a character vector containing the differently expressed genes of the respective experimental group.}
}
}
\description{
Processes the results of \code{getDeaResultsDf()}. See details.
}
\details{
The de-data.frame is processed such that the following steps are performed for every experimental
group.

\enumerate{
\item{Discards genes with \emph{avg_logFC}-values that are either infinite or negative}
\item{Discards genes with adjusted p-values above the threshold set with \code{max_adj_pval}}
\item{Discard genes with average log fold change below the treshold set with \code{min_lfc}}
\item{Slices the data.frame in order that for every experimental group:}
\enumerate{
\item{the n genes with the highest \emph{avg_logFC}-values are kept where n = \code{n_highest_lfc}}
\item{the n genes with the lowest \emph{p_val_adj}-values are kept where n = \code{n_lowest_pval}}
}
\item{Arranges the genes according to the highest \emph{avg_logFC}-values}
}
}
\keyword{internal}
