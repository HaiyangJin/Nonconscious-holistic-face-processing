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
source("get_pars.R")

#############################  Fitting the maximal glmm model for response ##############################
# fit the model for response
message("")
message(paste0(strrep("#", 80)))
message("Fitting the glmm.max.resp model...")

glmm.max.resp <- glmer(isCorrect ~ Viewing * Congruency * Alignment * CFS_Cover + WithCatch +
                         (1 + View_C + Con_C + Ali_C + View_Con + View_Ali + Con_Ali + View_Con_Ali | Participant) +
                         (1 + View_C + Ali_C + Cover_C + View_Ali + View_Cover + Ali_Cover + View_Ali_Cover | Stimuli),
                       data = df.cf.all,
                       family = binomial(link = "logit"),
                       verbose = TRUE,
                       control = glmerControl(optCtrl = list(maxfun = 1e6)))

glmm.max1.resp <- re_fit(glmm.max.resp)

# Save the maximal model
print("Saving the glmm.max.resp ...")
save(glmm.max.resp, glmm.max1.resp, file = "P101_resp_glmm_max.RData")


#############################  Fitting the zcp glmm model for response ##############################
# # fit the model for response
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the zcp model...")
# 
# load("P101_resp_glmm_max.RData")
# glmm.zcp.resp <- update(glmm.max.resp,
#                         formula = isCorrect ~ Viewing * Congruency * Alignment * CFS_Cover + WithCatch + 
#                           (1 + View_C + Con_C + Ali_C + View_Con + View_Ali + Con_Ali + View_Con_Ali || Participant) +
#                           (1 + View_C + Ali_C + Cover_C + View_Ali + View_Cover + Ali_Cover + View_Ali_Cover || Stimuli))
# 
# # glmm.zcp1.resp <- re_fit(glmm.zcp.resp) glmm.zcp1.resp,
# 
# # Save the zcp model
# print("Saving the glmm.zcp.resp ...")
# save(glmm.zcp.resp, file = "P101_resp_glmm_zcp.RData")


#############################  Fitting the reduced glmm model for response ##############################
# # fit the model for response
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the reduced model...")
# 
# load("P101_resp_glmm_zcp.RData")
# glmm.rdc.resp <- update(glmm.zcp.resp,
#                        formula = isCorrect ~ Viewing * Congruency * Alignment + ExpCode +
#                          (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali || Participant) +
#                          (1 | Stimuli))
# 
# glmm.rdc1.resp <- re_fit(glmm.rdc.resp)
# 
# # Save the rdc model
# print("Saving the glmm.rdc.resp ...")
# save(glmm.rdc.resp, glmm.rdc1.resp, file = "P101_resp_glmm_rdc.RData")


#############################  Fitting the extended glmm model for response ##############################
# # fit the model for response
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the extended model...")
# 
# load("P101_resp_glmm_rdc.RData")
# glmm.etd.resp <- update(glmm.rdc.resp,
#                         formula = isCorrect ~ Viewing * Congruency * Alignment + ExpCode +
#                           (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali | Participant) +
#                           (1 | Stimuli),
#                         control = glmerControl(optCtrl = list(maxfun = 1e6)))
# 
# glmm.etd1.resp <- re_fit(glmm.etd.resp)
# 
# # Save the etd model
# print("Saving the glmm.etd.resp ...")
# save(glmm.etd.resp, glmm.etd1.resp, file = "P101_resp_glmm_etd.RData")


#############################  Fitting the extended2 glmm model for response ##############################
# # fit the model for response
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the extended2 model...")
# 
# load("P101_resp_glmm_etd.RData")
# glmm.etd2.resp <- update(glmm.etd.resp,
#                          formula = isCorrect ~ Viewing * Congruency * Alignment + ExpCode +
#                            (1 + View_D + Ali_D + View_Con + View_Ali + Con_Ali | Participant) +
#                            (1 | Stimuli),
#                          control = glmerControl(optCtrl = list(maxfun = 1e6)))
# 
# glmm.etd3.resp <- re_fit(glmm.etd2.resp)
# 
# # Save the etd model
# print("Saving the glmm.etd2.resp ...")
# save(glmm.etd2.resp, glmm.etd3.resp, file = "P101_resp_glmm_etd2.RData")


#############################  Fitting the extended glmm model for (allFit) response ##############################
# # fit the model for response
# message("")
# message(paste0(strrep("#", 80)))
# message("allFitting the extended model...")
# 
# glmm.etd0.resp <- glmer(isCorrect ~ Viewing * Congruency * Alignment + ExpCode +
#                           (1 + View_D + Con_D + View_Con + View_Ali + Con_Ali | Participant),
#                       data = df.cf.all,
#                       family = "binomial",
#                       verbose = TRUE
#                       )
# 
# glmm.etd.resp.allFit <- allFit(glmm.etd0.resp,
#                                maxfun = 1e6)
# 
# # Save the etd model
# print("Saving the glmm.etd.resp ...")
# save(glmm.etd.resp.allFit, file = "P101_resp_glmm_etd_allFit.RData")


# versions of packages used
sessionInfo()
