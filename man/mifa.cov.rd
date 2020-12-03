% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mifa.cov.R
\name{mifa.cov}
\alias{mifa.cov}
\title{Compute covariance matrix of incomplete data using multiple imputation}
\usage{
mifa.cov(
  data.miss,
  n.factor,
  M,
  maxit.mi = 5,
  method.mi = "pmm",
  alpha = 0.05,
  rep.boot = NULL,
  ci = FALSE
)
}
\arguments{
\item{data.miss}{Dataset with missing values coded as \code{NA}.}

\item{n.factor}{Vector indicating number of factors to be used to compute
proportion of explained variance or construct confidence intervals.
The minimum length of this vector is 1 and its maximum length is
the number of items.}

\item{M}{Number of generated imputations. See \code{\link[mice:mice]{mice::mice()}}.}

\item{maxit.mi}{A scalar giving the number of iterations for each imputation,
for more information see R documentations for mice package. The default is 5.}

\item{method.mi}{Method used for imputation. It can be a
string or a vector of strings of the size equal to number of items.
The default is \code{"pmm"}, i.e., predictive mean matching. See \code{\link[mice:mice]{mice::mice()}}.}

\item{alpha}{Significance level for constructing confidence intervals.}

\item{rep.boot}{number of bootstrap samples to use for bootstrap confidence
intervals. If \code{ci = TRUE} then \code{rep.boot} must be specified.}

\item{ci}{A logical variable indicating whether a confidence interval should
be constructed for proportion of explained variance or not. The default value
is \code{FALSE}.}
}
\value{
A list:
\describe{
\item{cov.mice}{The estimated covariance matrix of the incomplete data
using multiple imputations.}
\item{cov.mice.imp}{A list containing th estimated covariance matrix for
each of M imputed data.}
\item{exp.var.mice}{A vector containing the estimated proportions of
explained variance for each of specified n.factor components.}
\item{ci.mice.fieller}{A matrix containing the estimated Fieller's
confidence interval for proportion of explained variance for each of
specified n.factor components. NULL, if \code{ci = FALSE}.}
\item{ci.mice.bootstrap}{A matrix containing the estimated bootstrap
confidence interval for proportion of explained variance for each of
specified n.factor components. NULL, if \code{ci = FALSE}.}
}
}
\description{
Compute covariance matrix of incomplete data using multiple imputation.
For multiple imputation, Multivariate Imputation by Chained Equations
(MICE) from the \link{mice} package is used.
}
\references{
Nassiri, V., Lovik, A., Molenberghs, G., & Verbeke, G. (2018).
On using multiple imputation for exploratory factor analysis of incomplete
data. Behavioral Research Methods 50, 501–517.
\url{https://doi.org/10.3758/s13428-017-1013-4}
}
\seealso{
\code{\link[=ci.mifa.bootstrap]{ci.mifa.bootstrap()}}, \code{\link[=ci.mifa.fieller]{ci.mifa.fieller()}}, \code{\link[mice:mice]{mice::mice()}}
}
