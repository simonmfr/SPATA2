% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/b.R
\name{background_white}
\alias{background_white}
\title{Remove Background and Set it to White}
\usage{
background_white(image, percentile = 1)
}
\arguments{
\item{image}{An input image that you want to process.}

\item{percentile}{Numeric value between 0 and 100 (inclusive) specifying the percentile
threshold for background color determination. If bigger than 0, it determines
the \strong{top} percentile of colors to identify as background based on the frequency
they appear in the image. This can improve identifying tissue pixels in images
where the edge between tissue and background is continuous rather than sharp
and thus difficult to identify using computational approaches. It follows the
hypothesis that the background consists of many pixels of equal color while
the tissue consists of pixels of heterogenous colors.

Values between 0-100 are valid. Usually values between 0.5-2.5 work well.
Test resuls with \code{\link[=plotPixelContent]{plotPixelContent()}}.}
}
\value{
A modified version of the input image with the background removed, where
background pixels are set to white. The result is typically an image with
the main subject isolated against a white background.
}
\description{
This function processes an input image to remove the background by setting
pixels with colors considered part of the background to white. It's particularly
useful for isolating the main subject of an image by eliminating distracting
background elements. The degree of background removal is controlled by the
\code{percentile} parameter, which determines the threshold for considering colors as
part of the background.
}
\details{
If \code{percentile} is not 0, the \code{\link[=background_white]{background_white()}} function processes the
image by identifying the most frequently occurring colors setting their RGB values
to 1, effectively turning them white (assuming that the image is in grayscale,
with 1 representing white). The \code{percentile} parameter allows you to adjust the
sensitivity of the background removal, allowing for more precise isolation of the main subject.
}
\examples{

library(EBImage)

# Load an image and remove the background with default settings (99th percentile)
image <- getImage(object)

image_proc <- background_white(img, percentile = 1)

plot(image)
plot(image_proc)

}
\keyword{internal}
