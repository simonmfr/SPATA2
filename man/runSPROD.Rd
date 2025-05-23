% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/python-wrappers.R
\name{runSPROD}
\alias{runSPROD}
\title{De-noise expression data based on position and image information}
\usage{
runSPROD(
  object,
  img_name,
  mtr_name,
  mtr_name_new,
  dir_env,
  path_script = NULL,
  path_conda = find_path("conda.sh"),
  dir_temp = paste0("sprod_temp_", object@sample),
  del_temp = TRUE,
  assay_name = activeAssay(object),
  overwrite = FALSE,
  verbose = TRUE
)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{img_name}{Character. The name of the image to be used.}

\item{mtr_name}{Character. The name of the input matrix that is denoised}

\item{mtr_name_new}{Character. The name for the new processed (de-oised) matrix. Defaults to \code{paste0(mtr_name, "_sprod")}.}

\item{dir_env}{Character. The folder directory to the conda environment in which the python library sprod is installed.}

\item{path_script}{Character. The path to the \emph{.../sprod.py} script. By default, the directory of \code{dir_env} is searched.}

\item{path_conda}{Character. The path to the conda initialization script \emph{.../conda.sh}. By default, common paths are checked.}

\item{dir_temp}{Character. The folder directory for writing temporary files (defaults to "~/sprod_temp_\if{html}{\out{<object name>}}").}

\item{del_temp}{Logical. If \code{TRUE} (default), the temporary directory is deleted after processing.}

\item{assay_name}{Only relevant if the \code{SPATA2} object contains more than
one assay: Denotes the assay of interest and thus the
\link[=concept_molecular_modalities]{molecular modality} to use. Defaults to the active assay
as set by \code{\link[=activateAssay]{activateAssay()}}.}

\item{overwrite}{Logical value. Must be \code{TRUE} to allow overwriting.}

\item{verbose}{Logical. If \code{TRUE}, informative messages regarding
the computational progress will be printed.

(Warning messages will always be printed.)}
}
\value{
The updated input object, containing the added, removed or computed results.
}
\description{
A wrapper around the algorithm introduced by \emph{Wang et al. 2022} to denoise
expression data based on position and image information.

Note that this function creates a temporary folder.
}
\details{
This function runs the SPROD denoising algorithm on a given SPATA2 object by:
\itemize{
\item Creating a temporary directory (\code{dir_temp}) to store required input files (counts, spot metadata, and image).
\item Writing the counts matrix, spot metadata, and image to disk in \code{dir_temp}.
\item Executing the external SPROD Python script (\code{path_script}) via a system command that sources a conda environment (using \code{dir_env}).
\item Reading the denoised matrix from the expected output file and adding it to the SPATA2 object.
\item Storing additional results (e.g., intensity and texture features) in the assay’s analysis slot.
\item Deleting the temporary directory if \code{del_temp} is \code{TRUE}.
}
}
\note{
We recommend to set up a conda environment according to the tutorials at
https://github.com/yunguan-wang/SPROD.
}
\examples{
\dontrun{
  library(SPATA2)
  library(SPATAData)
  library(ggplot2)
  library(patchwork)

  spata_obj <- downloadSpataObject("T313")

  spata_obj <- normalizeCounts(spata_obj)

  spata_obj <- runSPROD(
    object = spata_obj,
    img_name = "lowres",
    mtr_name = "LogNormalize",
    mtr_name_new = "Sprod",
    dir_env = "dir/to/sprod_env",
    dir_temp = paste0("sprod_temp_", spata_obj@sample),
    del_temp = TRUE,
    overwrite = FALSE,
    verbose = TRUE
  )

  p1 <-
    plotSurface(spata_obj, color_by = "VEGFA", mtr_name = "LogNormalize") +
    labs(subtitle = "LogNormalize")

  p2 <-
    plotSurface(spata_obj, color_by = "VEGFA", mtr_name = "Sprod") +
    labs(subtitle = "Sprod De-Noised")

  plot(p1 + p2)

}

}
\references{
Wang, Y., Song, B., Wang, S. et al. Sprod for de-noising spatially resolved transcriptomics
data based on position and image information. Nat Methods 19, 950–958 (2022).
https://doi.org/10.1038/s41592-022-01560-w
}
