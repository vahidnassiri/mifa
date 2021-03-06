# Computing covariance matrix of incomplete data using multiple imputation by
# Multivariate Imputation by Chained Equations (MICE) method.
mifa.cov <- function(data.miss,n.factor,M,maxit.mi = 5,method.mi='pmm',
                   alpha = 0.05,rep.boot=NULL,ci=FALSE){
  # Please make sure the 'mice' package is installed. Use install.packages("mice")
  # to install it.
  # The input variable:
  # data.miss: the dataset contaning missing values, the missing values should be
  # shown with NA.
  # n.factor: a vector indicating number of factor should be used to compute
  # proportion of explained variance or construct confidence intervals.
  # M: the number of generated imputations, for more information see
  # R documentations for mice package.
  # maxit.mi: a scalar giving the number of iterations for each imputation,
  # for more information see R documentations for mice package. The default is
  # set as 5.
  # method.mi : the method which should be used for imputation. It can be a string
  # or a vector of strings of the size equal to number of items. for more information see
  # R documentations for mice package. The default is set is 'pmm'.
  # alpha: the significance level for constructing confidence intervals
  # ci: A logical variable indicaring whether a confidence interval should be
  # constructed for proportion of explianed variance or not. The default value is FALSE.
  N=dim(data.miss)[1]
  require(mice)
  library(mice)
  imputed_mice = mice(data.miss, m=M, maxit=maxit.mi,method=method.mi,print=FALSE)
  ### Begin: Implementing the sequantial imputation:
  # checking if everything is imputed
  method.levels.mi=levels(imputed_mice$loggedEvents$meth)
  if ('constant' %in% method.levels.mi){
    stop('Probably at least one column with constant observed part.')
  }
  # extracting imputed datasets
  comp.mice=NULL
  mi.na=rep(0,M)
  for (i in 1:M){
    comp.mice[[i]]=complete(imputed_mice,i)
    mi.na[i]=sum(is.na(comp.mice[[i]]))
  }
  # implementing sequential imputations in case that some of the columns are not
  # imputed due to collinearity, etc.
  while (sum(mi.na)>0){
    for (i in 1:M){
      imp.tmp=mice(comp.mice[[i]], m=1, maxit=maxit.mi,method=method.mi,print=FALSE)
      comp.mice[[i]]=complete(imp.tmp,1)
      mi.na[i]=sum(is.na(comp.mice[[i]]))
    }
  }
  ### Eend: Implementing the sequantial imputation:
  # Now estimating covariance matrix based on imputed values
  cov.mice.imp=NULL
  prop.exp=rep(0,M)
  for (i in 1:M){
    cov.tmp=cov(comp.mice[[i]])
    cov.mice.imp[[i]]=cov.tmp
  }
  # Combining the estimated covariance from different imputations
  cov.mice=Reduce('+',cov.mice.imp)/M
  # computing the eigenvalues of the combined covariance matrix
  eig.cov.mice=eigen(cov.mice)$values
  # computing the proportion of explained variance for number of factors
  # indicated by n.factor.
  exp.var.mice=(cumsum(eig.cov.mice)/sum(eig.cov.mice))[n.factor]
  # If ci==TRUE the parametric (Fieller) and non-parametric (Bootstrap)
  # confidence intervals are constructed here.
  if (ci==TRUE){
    ci.mice.fieller=try(ci.mifa.fieller(cov.mice.imp,n.factor,alpha,N))
    if (is.numeric(rep.boot)==FALSE){
      stop('You have set ci=TRUE, please set the number of bootstrap sub-samples, rep.boot')
    }
    ci.mice.bootstrap=try(ci.mifa.bootstrap(data.miss,n.factor,rep.boot,method.mi,maxit.mi,alpha))
    return(list(cov.mice=cov.mice,cov.mice.imp=cov.mice.imp,exp.var.mice=exp.var.mice,
                ci.mice.fieller=ci.mice.fieller,ci.mice.bootstrap=ci.mice.bootstrap))
  }
  if (ci==FALSE){
    return(list(cov.mice=cov.mice,cov.mice.imp=cov.mice.imp,exp.var.mice=exp.var.mice))
  }
}
