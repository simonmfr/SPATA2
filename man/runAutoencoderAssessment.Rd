% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/autoencoder.R
\name{assessAutoencoderOptions}
\alias{assessAutoencoderOptions}
\alias{runAutoencoderAssessment}
\title{Assessment of Neural Network Set Up}
\usage{
assessAutoencoderOptions(
  expr_mtr,
  activations,
  bottlenecks,
  layers = c(128, 64, 32),
  dropout = 0.1,
  epochs = 20,
  verbose = TRUE
)

runAutoencoderAssessment(
  object,
  activations,
  bottlenecks,
  layers = c(128, 64, 32),
  dropout = 0.1,
  epochs = 20,
  verbose = TRUE
)
}
\arguments{
\item{expr_mtr}{The expression matrix that is to be used as input for the neural network.}

\item{activations}{Character vector. Denotes the activation functions to be assessed.}

\item{bottlenecks}{Numeric vector. Denotes the different numbers of bottleneck neurons to be assessed.}

\item{layers}{Numeric vector of length 3. Denotes the number of neurons in the three hidden layers.
(default = c(128, 64, 32))}

\item{dropout}{Numeric value. Denotes the dropout. (defaults to 0.1)}

\item{epochs}{Numeric value. Denotes the epochs of the neural network. (defaults to 20)}

\item{verbose}{Logical. If \code{TRUE}, informative messages regarding
the computational progress will be printed.

(Warning messages will always be printed.)}

\item{object}{An object of class \code{\link{SPATA2}} or, in case of S4 generics,
objects of classes for which a method has been defined.}
}
\value{
\itemize{
\item{\code{runAutoencoderAssessment()}: The spata object containing the list that holds the total variance measured by \code{irlba::prcomp_irlba()} after each
combination of activations/bottlenecks as well as the additional set up.}
\item{\code{assessAutoencoderOptions()}:
The list that holds the total variance measured by \code{irlba::prcomp_irlba()} after each combination
of activations/bottlenecks as well as the additional set up.}
}
}
\description{
Assesses different neural network set ups regarding
the activation function and the number of bottleneck neurons.
}
\keyword{internal}
