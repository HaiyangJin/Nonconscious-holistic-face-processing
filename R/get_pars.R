# get pars
get_pars <- function(lmm) {
    
    if (isLMM(lmm)) {
        pars <- getME(lmm,"theta")
    } else {
        ## GLMM: requires both random and fixed parameters
        pars <- getME(lmm, c("theta","fixef"))
    }
    return(pars)
} 
