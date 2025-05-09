% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/contains.R
\name{containsVersion}
\alias{containsVersion}
\title{Checks availability of slot @version}
\usage{
containsVersion(object, check_not_empty = FALSE)
}
\arguments{
\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}

\item{check_not_empty}{Logical value. If \code{TRUE}, tests additionally if
the slot content is not empty.}
}
\value{
Logical value.
}
\description{
Tests if slot @version exists.
}
\keyword{internal}
