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
message("Fitting the lmm.max.rt model...")

lmm.max.rt <- lmer(reactionTime ~ Viewing * Congruency * Alignment + ExpCode +
                          (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali | Participant),
                      data = df.cf.rt,
                      REML = FALSE,
                      verbose = TRUE,
                      control = lmerControl(optimizer = "bobyqa",
                                            optCtrl = list(maxfun = 1e6))
                      )

# Save the maximal model
print("Saving the lmm.max.rt ...")
save(lmm.max.rt, file = "P101_rt_lmm_max.RData")


#############################  Fitting the zcp lmm model for RT ##############################
# # fit the model for RT
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.zcp.rt model...")
# 
# load("P101_rt_lmm_max.RData")
# lmm.zcp.rt <- update(lmm.max.rt,
#                      formula = reactionTime ~ Viewing * Congruency * Alignment + ExpCode +
#                        (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali || Participant))
# 
# # Save the zcp model
# print("Saving the lmm.zcp.rt ...")
# save(lmm.zcp.rt, file = "P101_rt_lmm_zcp.RData")


#############################  Fitting the reduced lmm model for RT ##############################
# # fit the model for RT
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the reduced model...")
# 
# load("P101_rt_lmm_zcp.RData")
# lmm.zcp.rt.step <- step(lmm.zcp.rt, reduce.fixed = FALSE)
# 
# # Save the rdc model
# print("Saving the lmm.rdc.rt ...")
# save(lmm.zcp.rt.step, file = "P101_rt_lmm_zcp_step.RData")


#############################  Fitting the extended lmm model for RT ##############################
# # fit the model for RT
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the lmm.etd.rt model...")
# 
# load("P101_rt_lmm_zcp.RData")
# 
# lmm.etd.rt <- update(lmm.zcp.rt,
#                        formula = reactionTime ~ Viewing * Congruency * Alignment + ExpCode +
#                            (1 + View_D | Participant))
# 
# # Save the etd model
# print("Saving the lmm.etd.rt ...")
# save(lmm.etd.rt, file = "P101_rt_lmm_etd.RData")

# versions of packages used
sessionInfo()