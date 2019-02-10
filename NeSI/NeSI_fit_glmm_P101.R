# The current R file is run in NeSI to get the results for several models and save them as .RData file
message("Fitting model for DataAnalysis_CF_104_6.Rmd...")
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
load("P101_104_106_clean.RData")


#############################  Fitting the glmm model for CFS ##############################
# fit the model for CFS
message("")
message(paste0(strrep("#", 80)))
message("Fitting the maximum model...")

glmm.max.acc <- glmer(isCorrect ~ Experiment * Congruency * Alignment + 
                          (1 + Exp_D + Con_D + Ali_D + Exp_Con + Exp_Ali + Con_Ali + Exp_Con_Ali | Participant) +
                          (1 + Exp_D + Con_D + Ali_D + Exp_Con + Exp_Ali + Con_Ali + Exp_Con_Ali | FaceGroup),
                      data = df.clean,
                      family = "binomial",
                      verbose = TRUE,
                      control=glmerControl(optCtrl=list(maxfun=1e6))
)

# Save the maximum model
print("Saving the glmm.max.acc ...")
save(glmm.max.acc, file = "E1046_glmm_max_acc.RData")



#############################  Fitting the glmm model for CFS ##############################
# # fit the model for CFS
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the model for CFS...")
# glmm.cfs <- glmer(isCorrect ~ Congruency * Alignment +
#                       (1 + Congruency * Alignment | Participant) +
#                       (1 + Congruency * Alignment | Stimuli),
#                   data = filter(df.clean, Experiment == "CFS"),
#                   family = "binomial",
#                   verbose = TRUE,
#                   control=glmerControl(optimizer = "nloptwrap",optCtrl=list(maxfun=1e6))
#                   )
# 
# # Save the glmm.cfs
# print("Saving the glmm.cfs ...")
# save(glmm.cfs, file = "P101_glmm_cfs.RData")


#############################  Fitting the glmm model for monocular  ##############################
# # fit the model for monocular
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the model for monocular...")
# glmm.mono <- glmer(isCorrect ~ Congruency * Alignment +
#                        (1 + Congruency * Alignment | Participant) +
#                        (1 + Congruency * Alignment | Stimuli),
#                    data = filter(df.clean, Experiment == "monocular"),
#                    family = "binomial",
#                    verbose = TRUE,
#                    control=glmerControl(optimizer = "nloptwrap",optCtrl=list(maxfun=1e6))
#                    )
# 
# # Save the glmm.mono
# print("Saving the glmm.mono ...")
# save(glmm.mono, file = "P101_glmm_mono.RData")


# versions of packages used
sessionInfo()