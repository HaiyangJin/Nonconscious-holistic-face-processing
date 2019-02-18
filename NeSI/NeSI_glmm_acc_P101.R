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


#############################  Fitting the maximal glmm model for accuracy ##############################
# fit the model for accuracy
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the maximal model...")
# 
# glmm.max.acc <- glmer(isCorrect ~ Viewing * Congruency * Alignment + ExpCode +
#                           (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali | Participant) +
#                           (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali | FaceGroup),
#                       data = df.cf.all,
#                       family = "binomial",
#                       verbose = TRUE,
#                       control = glmerControl(optCtrl = list(maxfun = 1e6))
#                       )
# 
# # Save the maximal model
# print("Saving the glmm.max.acc ...")
# save(glmm.max.acc, file = "P101_glmm_max_acc.RData")

########### restart glmm.max from the current parameters ##########
# load("P101_glmm_max_acc.RData")
# source("get_pars.R")
# pars.max.acc <- get_pars(glmm.max.acc)
# glmm.max2.acc <- update(glmm.max.acc, start = pars.max.acc)
# 
# # Save the maximal2 model
# print("Saving the glmm.max2.acc ...")
# save(glmm.max2.acc, file = "P101_glmm_max2_acc.RData")


###### allFit for the maximal model #####
# glmm.max.all.acc <- glmer(isCorrect ~ Viewing * Congruency * Alignment + ExpCode +
#                           (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali | Participant) +
#                           (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali | FaceGroup),
#                       data = df.cf.all,
#                       family = "binomial"
#                       # verbose = TRUE
#                       )
# 
# message(paste0(strrep("#", 80)))
# message("Fitting with all available optimizers...")
# allfit.max.acc <- allFit(glmm.max.all.acc,
#                          verbose = TRUE,
#                          maxfun = 1e6
#                          )
# 
# # Save the allFit for the maximal model
# print("Saving the allfit.max.acc ...")
# save(allfit.max.acc, file = "P101_allfit_max_acc.RData")


#############################  Fitting the zcp glmm model for accuracy ##############################
# fit the model for accuracy
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the zcp model...")
# 
# load("P101_glmm_max_acc.RData")
# 
# glmm.zcp.acc <- update(glmm.max.acc,
#                        formula = isCorrect ~ Viewing * Congruency * Alignment + ExpCode +
#                            (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali || Participant) +
#                            (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali || FaceGroup)
#                        )
# 
# # Save the zcp model
# print("Saving the glmm.zcp.acc ...")
# save(glmm.zcp.acc, file = "P101_glmm_zcp_acc.RData")

########### restart glmm.zcp from the current parameters ##########
# load("P101_glmm_zcp_acc.RData")
# source("get_pars.R")
# pars.zcp.acc <- get_pars(glmm.zcp.acc)
# glmm.zcp2.acc <- update(glmm.zcp.acc, start = pars.zcp.acc)
# 
# # Save the zcp2 model
# print("Saving the glmm.zcp2.acc ...")
# save(glmm.zcp2.acc, file = "P101_glmm_zcp2_acc.RData")


#############################  Fitting the reduced glmm model for accuracy ##############################
# fit the model for accuracy
message("")
message(paste0(strrep("#", 80)))
message("Fitting the reduced model...")

load("P101_glmm_zcp_acc.RData")

glmm.rdc.acc <- update(glmm.zcp.acc,
                       formula = isCorrect ~ Viewing * Congruency * Alignment + ExpCode +
                           (1 + View_D + View_Con + View_Ali + View_Con_Ali || Participant) + 
                           (1 + Ali_D + View_Con || FaceGroup)
                       )

# Save the rdc model
print("Saving the glmm.rdc.acc ...")
save(glmm.rdc.acc, file = "P101_glmm_rdc_acc.RData")

########### restart glmm.rdc from the current parameters ##########
source("get_pars.R")
pars.rdc.acc <- get_pars(glmm.rdc.acc)
glmm.rdc2.acc <- update(glmm.rdc.acc, start = pars.rdc.acc)

# Save the rdc2 model
print("Saving the glmm.rdc2.acc ...")
save(glmm.rdc2.acc, file = "P101_glmm_rdc2_acc.RData")



#############################  Fitting the extended glmm model for accuracy ##############################
# fit the model for accuracy
message("")
message(paste0(strrep("#", 80)))
message("Fitting the reduced model...")

load("P101_glmm_rdc_acc.RData")

glmm.etd.acc <- update(glmm.rdc.acc,
                       formula = isCorrect ~ Viewing * Congruency * Alignment + ExpCode +
                           (1 + View_D + View_Con + View_Ali + View_Con_Ali | Participant) + 
                           (1 + Ali_D + View_Con | FaceGroup)
)

# Save the etd model
print("Saving the glmm.etd.acc ...")
save(glmm.etd.acc, file = "P101_glmm_etd_acc.RData")

########### restart glmm.etd from the current parameters ##########
source("get_pars.R")
pars.etd.acc <- get_pars(glmm.etd.acc)
glmm.etd2.acc <- update(glmm.etd.acc, start = pars.etd.acc)

# Save the etd2 model
print("Saving the glmm.etd2.acc ...")
save(glmm.etd2.acc, file = "P101_glmm_etd2_acc.RData")


# versions of packages used
sessionInfo()