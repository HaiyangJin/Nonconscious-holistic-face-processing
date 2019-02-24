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

#############################  Fitting the maximal lmm model for RT ##############################
# fit the model for RT
message("")
message(paste0(strrep("#", 80)))
message("Fitting the maximal model...")

lmm.max.rt <- lmer(reactionTime ~ Viewing * Congruency * Alignment + ExpCode +
                          (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali | Participant) +
                          (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali | FaceGroup),
                      data = df.cf.rt,
                      REML = FALSE,
                      verbose = TRUE,
                      control = lmerControl(optCtrl = list(maxfun = 1e6))
                      )

# Save the maximal model
print("Saving the lmm.max.rt ...")
save(lmm.max.rt, file = "P101_lmm_max_rt.RData")

########### restart lmm.max from the current parameters ##########
# load("P101_lmm_max_rt.RData")
# source("get_pars.R")
# pars.max.rt <- get_pars(lmm.max.rt)
# lmm.max2.rt <- update(lmm.max.rt, start = pars.max.rt)
# 
# # Save the maximal2 model
# print("Saving the lmm.max2.rt ...")
# save(lmm.max2.rt, file = "P101_lmm_max2_rt.RData")


###### allFit for the maximal model #####
# lmm.max.rt <- glmer(isCorrect ~ Viewing * Congruency * Alignment + ExpCode +
#                           (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali | Participant) +
#                           (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali | FaceGroup),
#                       data = df.cf.rt,
#                       family = "binomial"
#                       # verbose = TRUE
#                       )
# 
# message(paste0(strrep("#", 80)))
# message("Fitting with all available optimizers...")
# allfit.max.rt <- allFit(lmm.max.all.rt,
#                          verbose = TRUE,
#                          maxfun = 1e6
#                          )
# 
# # Save the allFit for the maximal model
# print("Saving the allfit.max.rt ...")
# save(allfit.max.rt, file = "P101_allfit_max_rt.RData")


#############################  Fitting the zcp lmm model for RT ##############################
# fit the model for RT
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the zcp model...")
# 
# load("P101_lmm_max_rt.RData")
# 
# lmm.zcp.rt <- update(lmm.max.rt,
#                        formula = isCorrect ~ Viewing * Congruency * Alignment + ExpCode +
#                            (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali || Participant) +
#                            (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali || FaceGroup)
#                        )
# 
# # Save the zcp model
# print("Saving the lmm.zcp.rt ...")
# save(lmm.zcp.rt, file = "P101_lmm_zcp_rt.RData")

########### restart lmm.zcp from the current parameters ##########
# load("P101_lmm_zcp_rt.RData")
# source("get_pars.R")
# pars.zcp.rt <- get_pars(lmm.zcp.rt)
# lmm.zcp2.rt <- update(lmm.zcp.rt, start = pars.zcp.rt)
# 
# # Save the zcp2 model
# print("Saving the lmm.zcp2.rt ...")
# save(lmm.zcp2.rt, file = "P101_lmm_zcp2_rt.RData")


#############################  Fitting the reduced lmm model for RT ##############################
# fit the model for RT
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the reduced model...")
# 
# load("P101_lmm_zcp_rt.RData")
# 
# lmm.rdc.rt <- update(lmm.zcp.rt,
#                        formula = isCorrect ~ Viewing * Congruency * Alignment + ExpCode +
#                            (1 + View_D + View_Con + View_Ali + View_Con_Ali || Participant) + 
#                            (1 + Ali_D + View_Con || FaceGroup)
#                        )

# # Save the rdc model
# print("Saving the lmm.rdc.rt ...")
# save(lmm.rdc.rt, file = "P101_lmm_rdc_rt.RData")
# 
# ########### restart lmm.rdc from the current parameters ##########
# source("get_pars.R")
# pars.rdc.rt <- get_pars(lmm.rdc.rt)
# lmm.rdc2.rt <- update(lmm.rdc.rt, start = pars.rdc.rt)
# 
# # Save the rdc2 model
# print("Saving the lmm.rdc2.rt ...")
# save(lmm.rdc2.rt, file = "P101_lmm_rdc2_rt.RData")



#############################  Fitting the extended lmm model for RT ##############################
# # fit the model for RT
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the reduced model...")
# 
# load("P101_lmm_rdc_rt.RData")
# 
# lmm.etd.rt <- update(lmm.rdc.rt,
#                        formula = isCorrect ~ Viewing * Congruency * Alignment + ExpCode +
#                            (1 + View_D + View_Con + View_Ali + View_Con_Ali | Participant) + 
#                            (1 + Ali_D + View_Con | FaceGroup)
# )
# 
# # Save the etd model
# print("Saving the lmm.etd.rt ...")
# save(lmm.etd.rt, file = "P101_lmm_etd_rt.RData")
# 
# ########### restart lmm.etd from the current parameters ##########
# source("get_pars.R")
# pars.etd.rt <- get_pars(lmm.etd.rt)
# lmm.etd2.rt <- update(lmm.etd.rt, start = pars.etd.rt)
# 
# # Save the etd2 model
# print("Saving the lmm.etd2.rt ...")
# save(lmm.etd2.rt, file = "P101_lmm_etd2_rt.RData")


# versions of packages used
sessionInfo()