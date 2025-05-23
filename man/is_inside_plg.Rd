% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/i.R
\name{is_inside_plg}
\alias{is_inside_plg}
\title{Check if a Point is Inside a Polygon}
\usage{
is_inside_plg(point, polygon_df, strictly = TRUE)
}
\arguments{
\item{point}{A numeric vector with two elements representing the x (first value) and y (second value) coordinates of the point.}

\item{polygon_df}{A data frame with columns 'x' and 'y', containing the vertices of the polygon.}

\item{strictly}{Logical, indicating whether the point must strictly lie inside the polygon (TRUE) or might be part of
the polygon boundary (FALSE).}
}
\value{
Logical value indicating whether the point is inside the polygon.
}
\description{
This function determines whether a given point lies inside a polygon defined by its vertices.
}
\examples{
point <- c(2, 3)
polygon_df <- data.frame(x = c(1, 3, 3, 1), y = c(1, 1, 4, 4))
is_inside_plg(point, polygon_df) # Returns TRUE

}
\seealso{
\code{\link[sp:point.in.polygon]{sp::point.in.polygon()}}
}
\keyword{internal}
