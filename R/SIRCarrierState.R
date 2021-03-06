#' SIR model with carrier state (2.7).
#' @description Solves a SIR model with carrier state.
#' @param pars \code{\link{vector}} with 6 values: the per capita death, transmission, infectious-recovery and carrier-recovery  rates, the proportion of reduction in transmission from carriers compared with infectious and the proportion of infectious that become carriers. The names of these values must be "mu", beta", "gamma", "Gamma", "epsilon" and "rho", respectively.
#' @param init \code{\link{vector}} with 4 values: the initial proportion of proportion of susceptibles, infectious, carriers and recovered. The names of these values must be "S", "I", "C" and "R", respectively.
#' @param time time sequence for which output is wanted; the first value of times must be the initial time.
#' @param ... further arguments passed to \link[deSolve]{ode} function.
#' @details This is the R version of program 2.7 from page 44 of "Modeling Infectious Disease in humans and animals" by Keeling & Rohani.
#' 
#' All parameters must be positive and S + I + C + R <= 1.
#' @return \code{\link{list}}. The first element, \code{*$model}, is the model function. The second, third and fourth elements are the vectors (\code{*$pars}, \code{*$init}, \code{*$time}, containing the \code{pars}, \code{init} and \code{time} arguments of the function. The fifth element \code{*$results} is a \code{\link{data.frame}} with up to as many rows as elements in time. First column contains the time. Second to fifth column contain the proportion of susceptibles, infectious, cariers and recovered.
#' @references Keeling, Matt J., and Pejman Rohani. Modeling infectious diseases in humans and animals. Princeton University Press, 2008.
#' @seealso \link[deSolve]{ode}.
#' @export
#' @examples 
#' # Parameters and initial conditions.
#' parameters <- c(mu = 1 / (50 * 365), beta = 0.2, 
#'                     gamma = 0.1, Gamma = 0.001, 
#'                     epsilon = 0.1, rho = 0.4)
#' initials <- c(S = 0.1, I = 1e-4, C = 1e-3, R = 1 - 0.1 - 1e-4 - 1e-3)
#' 
#' # Solve the system.
#' sir.carrier.state <- SIRCarrierState(pars = parameters,
#'                                      init = initials, time = 0:60)
#' PlotMods(sir.carrier.state)
#' 
SIRCarrierState <- function(pars = NULL, init = NULL, time = NULL, ...) {
  if (is.null(pars)) {
    stop("undefined 'pars'")
  }
  if (is.null(pars)) {
    stop("undefined 'inits'")
  }
  if (is.null(pars)) {
    stop("undefined 'time'")
  }
  function1 <- function(pars = NULL, init = NULL, time = NULL) {
    function2 <- function(time, init, pars) {
      with(as.list(c(init, pars)), {
        dS <- mu - beta * S * (I + epsilon * C) - mu * S
        dI <- beta * S * (I + epsilon * C) - gamma * I - mu * I
        dC <- gamma * rho * I - Gamma * C - mu * C
        dR <- gamma * (1 - rho) * I + Gamma * C - mu * R
        list(c(dS, dI, dC, dR))
      })
    }
    init <- c(init['S'], init['I'], init['C'], init['R'])
    output <- ode(times = time, 
                  func = function2, 
                  y = init, parms = pars, ...)
    return(output)
  }
  
  output <- function1(pars = pars, init = init, time = time)
  return(list(model = function1,
              pars = pars,
              init = init,
              time = time,
              results = as.data.frame(output)))
}