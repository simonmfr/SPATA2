% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/initiateSpataObject.R
\name{initiateSpataObjectVisium}
\alias{initiateSpataObjectVisium}
\title{Initiate an object of class \code{SPATA2} from platform Visium}
\usage{
initiateSpataObjectVisium(
  sample_name,
  directory_visium,
  mtr = "filtered",
  img_active = "lowres",
  img_ref = "hires",
  resize_images = NULL,
  unload = TRUE,
  verbose = TRUE
)
}
\arguments{
\item{sample_name}{Character. The name of the sample.}

\item{directory_visium}{Character. The directory containing the Visium output files.}

\item{mtr}{Character. Specifies which matrix to use, either "filtered" or "raw". Default is "filtered".}

\item{img_active}{Character. The active image to use, either "lowres" or "hires". Default is "lowres".}

\item{img_ref}{Character. The reference image to use, either "lowres" or "hires". Default is "hires".}

\item{resize_images}{A named list of numeric values between 0-1 used to resize
the respective image as indicated by the slot name. E.g \code{resize_images = list(hires = 0.5)}
resizes the hires image to 50\% of its original scale.}

\item{unload}{Logical value. If \code{TRUE}, every image except for the active image
is \link[=unloadImages]{unloaded.}}

\item{verbose}{Logical. If \code{TRUE}, informative messages regarding
the computational progress will be printed.

(Warning messages will always be printed.)}
}
\value{
A \code{SPATA2} object containing data from the Visium platform. More precise,
depending on the set up used to create the raw data it is of either spatial method:

\itemize{
\item{\code{\link{VisiumSmall}}}{: Visium data set with capture area of 6.5mm x 6.5mm.}
\item{\code{\link{VisiumLarge}}}{: Visium data set with capture area of 11mm x 11m. }
}

In any case, the output is an object of class \code{SPATA2}.
}
\description{
This function initiates a \code{\link{SPATA2}} object with data generated
using the 10x Genomics Visium platform.
}
\details{
The function requires a directory containing the output files from a 10x Genomics Visium experiment
specified with the argument \code{directory_visum}. This directory (below denoted as \strong{~}) must include the following files
and sub-directories:

\itemize{
\item \emph{~/filtered_feature_bc_matrix.h5} or \emph{raw_feature_bc_matrix.h5}: The HDF5 file containing the filtered or raw feature-barcode matrix, respectively.
\item \emph{~/spatial/tissue_lowres_image.png} or \emph{spatial/tissue_hires_image.png}: The low-resolution or high-resolution tissue image.
\item \emph{~/spatial/scalefactors_json.json}: A JSON file containing the scale factors for the images.
\item \emph{~/spatial/tissue_positions_list.csv} or \emph{/~spatial/tissue_positions.csv}: A CSV file containing the tissue positions and spatial coordinates.
}
The function will check for these files and process them to create a \code{SPATA2} object. It reads the count matrix, loads the spatial data,
and initializes the \code{SPATA2} object with the necessary metadata and settings.
}
\section{Gene and Protein Expression}{

This function also supports reading coupled gene expression and protein expression data. It expects the input directory to contain an HDF5
file that includes separate datasets for gene expression and protein expression. The function uses \code{\link[Seurat:Read10X_h5]{Seurat::Read10X_h5()}} with \code{unique.features = TRUE}, to read in
data and, if the result is a list, it assumes that it contains gene and protein expression. This scenario is handled as follows:

\itemize{
\item Gene expression data is extracted from the "Gene Expression" dataset in the HDF5 file and stored in an assay named \emph{gene}.
\item Protein expression data is extracted from the "Antibody Capture" dataset in the HDF5 file \emph{protein}.
}

The function ensures that molecule names do not overlap by normalizing the names:

\itemize{
\item Gene expression molecule names remain in upper case (human data) or title case (mouse data).
\item Protein expression molecule names are forced to lowercase.
}

This naming convention prevents any overlap and ensures that each molecule type is uniquely
identified in the resulting \code{SPATA2} object, which contains two assays. One of molecular
modality \emph{gene} and of of molecular modality \emph{protein}.
}

\section{Row and column indices}{

Visium spot coordinates come with column and row indices. The functions \code{initiateSpataObjectVisium()}
and \code{initiateSpataObjectVisiumHD()} ensure that \emph{col} aligns with the direction of the x-coordinates and
that \emph{row} aligns with the direction of the y-coordinates. If they do not, they are adjusted accordingly.
Hence, these variables should not be used as keys for data merging.
}

\seealso{
\code{\link[=flipAll]{flipAll()}} to revert the effect of a horizontally flipped sample. (SPATA2 works
in cartesian coordinate system, in which images are displayed, too. Therefore, samples are
displayed "upside-down" when compared to the image in your folder.)
}
