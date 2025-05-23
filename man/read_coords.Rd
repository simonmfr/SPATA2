% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/r.R
\name{read_coords}
\alias{read_coords}
\alias{read_coords_merfish}
\alias{read_coords_slide_seq_v1}
\alias{read_coords_visium}
\alias{read_coords_xenium}
\title{Read coordinate data.frames}
\usage{
read_coords(...)

read_coords_merfish(dir_coords)

read_coords_slide_seq_v1(dir_coords)

read_coords_visium(dir_coords)

read_coords_xenium(dir_coords)
}
\arguments{
\item{dir_coords}{Character value. Directory to the coordinates data.frame.}
}
\value{
Data.frame of at least five columns:
\itemize{
\item{\emph{barcodes}:}{ Character. Unique identifier of each observation.}
\item{\emph{x_orig}:}{ Numeric. x-coordinates of the original input.}
\item{\emph{y_orig}:}{ Numeric. y-coordinates of the original input.}
\item{\emph{col}:}{ Integer. Column index.}
\item{\emph{row}:}{ Integer. Row index.}
}
}
\description{
Reads in coordinates data.frame from various platforms.
}
