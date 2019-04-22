# The current R file is run in NeSI to get the results for several models and save them as .RData file
message("Fitting model for P101_DataAnalysis.Rmd...")
jobid = Sys.getenv("SLURM_JOB_ID")
message(paste0("The corresponding *.out file is ", jobid, ".out"))

#############################  Preparation  ##############################
# set the working directory
message("Setting the current working directory...")
setwd("P101/")

# load libraries
message("")
message("Loading the libraries...")
library(tidyverse)
library(lme4)
library(lmerTest)

# load the data file
message("")
message("Loading the data file...")
load("P101_cf_clean.RData")
df.cf.rt <- {
    df.cf.all %>% 
        filter(isCorrect == 1) %>% 
        mutate(RT = if_else(ExpCode == "E1", reactionTime * 1000 + 300, reactionTime * 1000))
}

#############################  Fitting the maximal glmm model for RT ##############################
# fit the model for RT
message("")
message(paste0(strrep("#", 80)))
message("Fitting the glmm.max.rt model...")

glmm.max.rt <- glmer(reactionTime ~ Viewing * Congruency * Alignment + ExpCode +
                       (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali | Participant) +
                       (1 + Ali_D | Stimuli),
                     data = df.cf.rt,
                     family = poisson(link = "log"),
                     verbose = TRUE,
                     control = glmerControl(optCtrl = list(maxfun = 1e6)))

# Save the glmm.max.rt model
print("Saving the glmm.max.rt ...")
save(glmm.max.rt, file = "P101_rt_glmm_max.RData")

########### restart glmm.max from the current parameters ##########
# load("P101_glmm_max_rt.RData")
# source("get_pars.R")
# pars.max.rt <- get_pars(glmm.max.rt)
# glmm.max2.rt <- update(glmm.max.rt, start = pars.max.rt)
# 
# # Save the maximal2 model
# print("Saving the glmm.max2.rt ...")
# save(glmm.max2.rt, file = "P101_glmm_max2_rt.RData")


###### allFit for the maximal model #####
# glmm.max.rt <- glmer(RT ~ Viewing * Congruency * Alignment + ExpCode +
#                           (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali | Participant) +
#                           (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali | FaceGroup),
#                       data = df.cf.rt,
#                       family = "binomial"
#                       # verbose = TRUE
#                       )
# 
# message(paste0(strrep("#", 80)))
# message("Fitting with all available optimizers...")
# allfit.max.rt <- allFit(glmm.max.all.rt,
#                          verbose = TRUE,
#                          maxfun = 1e6
#                          )
# 
# # Save the allFit for the maximal model
# print("Saving the allfit.max.rt ...")
# save(allfit.max.rt, file = "P101_allfit_max_rt.RData")


#############################  Fitting the zcp glmm model for RT ##############################
# # fit the model for RT
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the zcp model...")
# 
# load("P101_glmm_max_rt.RData")
# 
# glmm.zcp.rt <- update(glmm.max.rt,
#                        formula = RT ~ Viewing * Congruency * Alignment + ExpCode +
#                            (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali || Participant) +
#                            (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali || FaceGroup)
#                        )
# 
# # Save the zcp model
# print("Saving the glmm.zcp.rt ...")
# save(glmm.zcp.rt, file = "P101_glmm_zcp_rt.RData")

########### restart glmm.zcp from the current parameters ##########
# load("P101_glmm_zcp_rt.RData")
# source("get_pars.R")
# pars.zcp.rt <- get_pars(glmm.zcp.rt)
# glmm.zcp2.rt <- update(glmm.zcp.rt, start = pars.zcp.rt)
# 
# # Save the zcp2 model
# print("Saving the glmm.zcp2.rt ...")
# save(glmm.zcp2.rt, file = "P101_glmm_zcp2_rt.RData")


#############################  Fitting the reduced glmm model for RT ##############################
# fit the model for RT
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the reduced model...")
# 
# load("P101_glmm_zcp_rt.RData")
# 
# glmm.rdc.rt <- update(glmm.zcp.rt,
#                        formula = RT ~ Viewing * Congruency * Alignment + ExpCode +
#                            (1 + View_D + View_Con + View_Ali + View_Con_Ali || Participant) + 
#                            (1 + Ali_D + View_Con || FaceGroup)
#                        )

# # Save the rdc model
# print("Saving the glmm.rdc.rt ...")
# save(glmm.rdc.rt, file = "P101_glmm_rdc_rt.RData")
# 
# ########### restart glmm.rdc from the current parameters ##########
# source("get_pars.R")
# pars.rdc.rt <- get_pars(glmm.rdc.rt)
# glmm.rdc2.rt <- update(glmm.rdc.rt, start = pars.rdc.rt)
# 
# # Save the rdc2 model
# print("Saving the glmm.rdc2.rt ...")
# save(glmm.rdc2.rt, file = "P101_glmm_rdc2_rt.RData")



#############################  Fitting the extended glmm model for RT ##############################
# # fit the model for RT
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the reduced model...")
# 
# load("P101_glmm_rdc_rt.RData")
# 
# glmm.etd.rt <- update(glmm.rdc.rt,
#                        formula = RT ~ Viewing * Congruency * Alignment + ExpCode +
#                            (1 + View_D + View_Con + View_Ali + View_Con_Ali | Participant) + 
#                            (1 + Ali_D + View_Con | FaceGroup)
# )
# 
# # Save the etd model
# print("Saving the glmm.etd.rt ...")
# save(glmm.etd.rt, file = "P101_glmm_etd_rt.RData")
# 
# ########### restart glmm.etd from the current parameters ##########
# source("get_pars.R")
# pars.etd.rt <- get_pars(glmm.etd.rt)
# glmm.etd2.rt <- update(glmm.etd.rt, start = pars.etd.rt)
# 
# # Save the etd2 model
# print("Saving the glmm.etd2.rt ...")
# save(glmm.etd2.rt, file = "P101_glmm_etd2_rt.RData")


# versions of packages used
sessionInfo()