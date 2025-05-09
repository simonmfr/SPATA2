% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/u.R
\name{unloadImage}
\alias{unloadImage}
\alias{unloadImage,SPATA2-method}
\alias{unloadImage,SpatialData-method}
\alias{unloadImage,HistoImage-method}
\alias{unloadImages}
\alias{unloadImages,SPATA2-method}
\alias{unloadImages,SpatialData-method}
\title{Unload image slot content}
\usage{
unloadImage(object, ...)

\S4method{unloadImage}{SPATA2}(object, img_name = activeImage(object), verbose = NULL, ...)

\S4method{unloadImage}{SpatialData}(object, img_name, verbose = TRUE, ...)

\S4method{unloadImage}{HistoImage}(object, verbose = TRUE, ...)

unloadImages(object, ...)

\S4method{unloadImages}{SPATA2}(object, active = FALSE, verbose = TRUE)

\S4method{unloadImages}{SpatialData}(object, active = FALSE, verbose = TRUE)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{...}{Used to absorb deprecated arguments or functions.}

\item{img_name}{Character value. The name of the image to unload.}

\item{verbose}{Logical. If \code{TRUE}, informative messages regarding
the computational progress will be printed.

(Warning messages will always be printed.)}

\item{active.}{Logical value. If \code{FALSE}, the default,
the image from the active \code{HistoImage} is not unloaded.}
}
\value{
The updated input object, containing the added, removed or computed results.
}
\description{
Removes the image from slot @image of a \code{HistoImage}.
Useful for efficient data storing.

Not to be confused with \code{\link[=removeImage]{removeImage()}}!
}
\seealso{
\code{\link[=loadImage]{loadImage()}},\code{\link[=loadImages]{loadImages()}}, \code{\link[=getImageDir]{getImageDir()}}
}
