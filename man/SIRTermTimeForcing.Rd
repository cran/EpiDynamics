% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SIRTermTimeForcing.R
\name{SIRTermTimeForcing}
\alias{SIRTermTimeForcing}
\title{SIR model with corrected term-time forcing (P 5.2).}
\usage{
SIRTermTimeForcing(
  pars = NULL,
  init = NULL,
  term.times = terms,
  cicles = 10,
  low.term.first = TRUE,
  ...
)
}
\arguments{
\item{pars}{\code{\link{list}} with 4 values: the mean transmission rate, a scalar (or a \code{\link{vector}} to create bifurcations) with the amplitude of sinusoidal forcing, the removal recovery rate, and the per capita death rate. The names for these values must be: "beta0", "beta1", "gamma", and "mu", respectively. All parameters must be positive and beta1 <= 1.}

\item{init}{\code{\link{vector}} with 3 values: the initial proportion of proportion of susceptibles, infectious and recovered. The names of these values must be "S", "I" and "R", respectively. S + I + R <= 1.}

\item{term.times}{\code{\link{vector}} indicating the term times (see details and example).}

\item{cicles}{value indicating how many times \code{term.times} must be simulated (see details and example).}

\item{low.term.first}{logical. If \code{TRUE} (default), the first term-time is considered -1, the second 1, the tirth -1 and so on. When \code{FALSE}, the first term-time is 1, the second -1, and so on (see example).}

\item{...}{further arguments passed to \link[deSolve]{ode} function.}
}
\value{
\code{\link{list}}. The first element, \code{*$model}, is the model function. The second, third and fourth elements are vectors (\code{*$pars}, \code{*$init}, \code{*$time}, respectively) containing the \code{pars}, \code{init} and \code{time} arguments of the function. The fifth element \code{*$results} is a \code{\link{data.frame}} with up to as many rows as elements in time. First column contains the time. Second, third and fourth columns contain the proportion of susceptibles, infectious and recovered.
}
\description{
Solves a SIR model  with corrected term-time forcing of the transmission rate.
}
\details{
This is the R version of program 5.2 from page 171 of "Modeling Infectious Disease in humans and animals" by Keeling & Rohani.

This model is based on the behaviour os measles and other child-hood diseases. Transmission rate is low during term == -1 (e.g. holydas term) and high during term == 1 (e.g. school term). We can define the year as the temporal unit of \code{cicles} and each cicle is composed by a \code{term-time} sequence (see example).
}
\examples{
## Parameters and initial conditions.
initials <- c(S = 1/17, I = 1e-4, R = 1 - 1/17 - 1e-4)
parameters <- list(beta0 = 17 / 13, beta1 = 0.25,
                gamma = 1 / 13, mu = 1 / (50 * 365))

## Term-times and cycles
# In a year-unit cicle, holidays happen for example
# between days 1 and 6, 101 and 115, 201 and 251,
# 301 and 307 and 308 and 365. 
# Setting low.term.first == TRUE (default) we define the
# previous term-times as low terms.
# Simulate 10 years.
terms <- c(1, 6, 100, 115, 200, 251, 300, 307, 356, 365)
cicles <- 10

# Solve and plot.
sir.term.time.forcing <- SIRTermTimeForcing(pars = parameters,
                                            init = initials,
                                            term.times = terms,
                                            cicles = 10)
PlotMods(sir.term.time.forcing)

# Solve bifurcation dynamics for 20 years.
# If the number of time-units per cicle (e.g. days) times
# the number of cicles (e.g. number of days) is less
# than 3650, bifurcation dynamics are solved for 3650
# time-steps
parameters2 <- list(beta0 = 17 / 13,
                beta1 = seq(0, 0.3, by = 0.001),
                gamma = 1 / 13, mu = 1 / (50 * 365))
# Uncomment the following lines (running it takes more than a few seconds):
# bifur <- SIRTermTimeForcing(pars = parameters2, init = initials,
#                             term.times = terms, cicles = 10)
# PlotMods(bifur, bifur = TRUE)
}
\references{
Keeling, Matt J., and Pejman Rohani. Modeling infectious diseases in humans and animals. Princeton University Press, 2008.
}
\seealso{
\link[deSolve]{ode}.
}
