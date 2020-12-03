% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mifa.cov.R
\name{mifa.cov}
\alias{mifa.cov}
\title{Compute covariance matrix of incomplete data}
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
\item{data.miss}{Dataset with missing values. Missing values should be
shown with NA.}

\item{n.factor}{Vector indicating number of factor should be used to compute
proportion of explained variance or construct confidence intervals.}

\item{M}{Number of generated imputations, for more information see R
documentations for mice package.}

\item{maxit.mi}{A scalar giving the number of iterations for each imputation,
for more information see R documentations for mice package. The default is 5.}

\item{method.mi}{the method which should be used for imputation. It can be a
string or a vector of strings of the size equal to number of items. for more
information see R documentations for mice package. The default is 'pmm'.}

\item{alpha}{Significance level for constructing confidence intervals}

\item{rep.boot}{number of bootstrap samples to use for bootstrap confidence
intervals}

\item{ci}{A logical variable indicating whether a confidence interval should
be constructed for proportion of explained variance or not. The default value
is FALSE.}
}
\value{
A list:
`cov.mice` covariance matrix based on imputed values,
`cov.mice.imp` Combined estimated covariance from different imputations,
`exp.var.mice` proportion of explained variance for n.factor factors,
`ci.mice.fieller parametric` (Fieller) confidence intervals (parametric)
`ci.mice.bootstrap` bootstrap confidence intervals (non-parametric).
Confidence intervals are NULL, if ci = FALSE.
}
\description{
Compute covariance matrix of incomplete data using multiple imputation by
Multivariate Imputation by Chained Equations (MICE) method.
}
