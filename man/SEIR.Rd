% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SEIR.R
\name{SEIR}
\alias{SEIR}
\title{SEIR model (2.6).}
\usage{
SEIR(pars = NULL, init = NULL, time = NULL, ...)
}
\arguments{
\item{pars}{\code{\link{vector}} with 4 values: the per capita death rate (and the population level birth rate), the transmission rate, the movement form exposed to infectious and the recovery rate. The names of these values must be "mu", "beta", "sigma" and "gamma", respectively.}

\item{init}{\code{\link{vector}} with 3 values: the initial proportion of proportion of susceptibles, exposed, infectious and recovered. The names of these values must be "S", "E", "I" and "R", respectively.}

\item{time}{time sequence for which output is wanted; the first value of times must be the initial time.}

\item{...}{further arguments passed to \link[deSolve]{ode} function.

 All parameters must be positive and S + E + I + R <= 1.}
}
\value{
\code{\link{list}}. The first element, \code{*$model}, is the model function. The second, third and fourth elements are the vectors (\code{*$pars}, \code{*$init}, \code{*$time}, containing the \code{pars}, \code{init} and \code{time} arguments of the function. The fifth element \code{*$results} is a \code{\link{data.frame}} with up to as many rows as elements in time. First column contains the time. Second to fifth column contain the proportion of susceptibles, exposed, infectious and recovered.
}
\description{
Solves a SEIR model with equal births and deaths.
}
\details{
This is the R version of program 2.6 from page 41 of "Modeling Infectious Disease in humans and animals" by Keeling & Rohani.
}
\examples{
# Parameters and initial conditions.
parameters <- c(mu = 1 / (70 * 365), beta = 520 / 365,
                    sigma = 1 / 14, gamma = 1 / 7)
initials <- c(S = 0.1, E = 1e-04, I = 1e-04, R = 1 - 0.1 - 1e-4 - 1e-4)

# Solve and plot.
seir <- SEIR(pars = parameters, init = initials, time = 0:(60 * 365))
PlotMods(seir)
}
\references{
Keeling, Matt J., and Pejman Rohani. Modeling infectious diseases in humans and animals. Princeton University Press, 2008.
}
\seealso{
\link[deSolve]{ode}.
}
