% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/s.R
\name{saveSpataObject}
\alias{saveSpataObject}
\title{Save SPATA2 object with a default directory}
\usage{
saveSpataObject(object, dir = NULL, verbose = NULL, ...)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{dir}{Character value. The directory under which to store
the \code{SPATA2} object. If \code{NULL}, defaults to the directory set with \code{\link[=setSpataDir]{setSpataDir()}}.}

\item{verbose}{Logical. If \code{TRUE}, informative messages regarding
the computational progress will be printed.

(Warning messages will always be printed.)}

\item{...}{Used to absorb deprecated arguments or functions.}
}
\value{
Apart from their side effect (saving the object of interest) all three functions
return the provided, updated \code{SPATA2} object.
}
\description{
Saves the \code{\link{SPATA2}} object under a default directory.
}
\examples{
library(SPATA2)

data("example_data")

object <- example_data$object_UKF269T_diet

getSpataDir(object) # fails, no directory set

# opt 1
object <- setSpataDir(object, directory_spata = "my_folder/object_UKF269T.RDS")

saveSpataObject(object)

# opt 2
object <- saveSpataObject(object, directory_spata = "my_folder/object_UKF269T.RDS")

getSpataDir(object)

}
\seealso{
\code{\link[=setSpataDir]{setSpataDir()}}, \code{\link[=getSpataDir]{getSpataDir()}}
}
