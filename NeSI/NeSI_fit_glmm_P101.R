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


#############################  Fitting the maximal glmm model for CFS ##############################
# fit the model for CFS
message("")
message(paste0(strrep("#", 80)))
message("Fitting the maximal model...")

glmm.max.acc <- glmer(isCorrect ~ Task * Congruency * Alignment + ExpCode +
                          (1 + Task_D + Con_D + Ali_D + Task_Con + Task_Ali + Con_Ali + Task_Con_Ali | Participant) +
                          (1 + Task_D + Con_D + Ali_D + Task_Con + Task_Ali + Con_Ali + Task_Con_Ali | FaceGroup),
                      data = df.cf.all,
                      family = "binomial",
                      verbose = TRUE,
                      control = glmerControl(optCtrl = list(maxfun = 1e6))
                      )

# Save the maximum model
print("Saving the glmm.max.acc ...")
save(glmm.max.acc, file = "P101_glmm_max_acc.RData")


#############################  Fitting the zcp glmm model for CFS ##############################
# # fit the model for CFS
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the zcp model...")
# 
# load("P101_glmm_max_acc.RData")
# 
# glmm.zcp.acc <- update(glmm.max.acc,
#                        formula = isCorrect ~ Task * Congruency * Alignment + ExpCode + 
#                            (1 + Task_D + Con_D + Ali_D + Task_Con + Task_Ali + Con_Ali + Task_Con_Ali || Participant) + 
#                            (1 + Task_D + Con_D + Ali_D + Task_Con + Task_Ali + Con_Ali + Task_Con_Ali || FaceGroup)
#                        )
# 
# # Save the zcp model
# print("Saving the glmm.zcp.acc ...")
# save(glmm.zcp.acc, file = "P101_glmm_zcp_acc.RData")


# versions of packages used
sessionInfo()