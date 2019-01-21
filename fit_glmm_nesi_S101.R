# The current R file is run in NeSI to get the results for several models and save them as .RData file
message("Fitting model for DataAnalysis_CF_104_6_v4.0.Rmd...")

#############################  Preparation  ##############################
# set the working directory
message("Setting the current working directory...")
setwd("S101/")

# load libraries
message("")
message("Loading the libraries...")
library(readr)
library(lme4)
library(lmerTest)

# load the data file
message("")
message("Loading the data file...")
load("df_clean_S101.RData")


#############################  Fitting the full model  ##############################
# # fit the full model
# message("")
# message(paste0(strrep("#", 80)))
# message("Fitting the full model...")
# glmm.full <- glmer(isCorrect ~ Experiment * Congruency * Alignment + 
#                      
#                      (1 + Experiment_D + Congruency_D + Alignment_D + 
#                         Experiment_Congruency + Experiment_Alignment + Congruency_Alignment +
#                         Experiment_Congruency_Alignment | Participant) +
#                      
#                      (1 + Experiment_D + Congruency_D + Alignment_D + 
#                         Experiment_Congruency + Experiment_Alignment + Congruency_Alignment +
#                         Experiment_Congruency_Alignment | Stimuli),
#                    
#                    data = df.clean,
#                    family = "binomial",
#                    verbose = TRUE,
#                    control=glmerControl(optCtrl=list(maxfun=1e6)))
# 
# # Save the glmm.full
# print("Saving the glmm.full ...")
# save(glmm.full, file = "S101_glmm_full.RData")


#############################  Fitting the reduced1 model  ##############################
# fit the reduced1 model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the reduced1 model...")
glmm.reduced1 <- glmer(isCorrect ~ Experiment * Congruency * Alignment + 
                           
                           (0 + Experiment_D + 
                                Experiment_Alignment + Congruency_Alignment +
                                Experiment_Congruency_Alignment | Participant) +
                           
                           (1 + Congruency_D + Alignment_D +
                                Experiment_Congruency + Congruency_Alignment +
                                Experiment_Congruency_Alignment | Stimuli),
                       
                       data = df.clean,
                       family = "binomial",
                       verbose = TRUE,
                       control=glmerControl(optCtrl=list(maxfun=1e6)))

# Save the glmm.reduced1
print("Saving the glmm.reduced1 ...")
save(glmm.full, file = "S101_glmm_reduced1.RData")


#############################  Fitting the reduced2 model  ##############################
# fit the reduced2 model
message("")
message(paste0(strrep("#", 80)))
message("Fitting the reduced2 model...")
glmm.reduced2 <- glmer(isCorrect ~ Experiment * Congruency * Alignment +
                           
                           (0 + Experiment_D +
                                Experiment_Congruency_Alignment | Participant) +
                           
                           (1 + Congruency_D + Alignment_D +
                                Congruency_Alignment +
                                Experiment_Congruency_Alignment | Stimuli),
                       
                       data = df.clean,
                       family = "binomial",
                       verbose = TRUE,
                       control=glmerControl(optCtrl=list(maxfun=1e6)))

# Save the glmm.reduced1
print("Saving the glmm.reduced1 ...")
save(glmm.full, file = "S101_glmm_reduced1.RData")




# # step for full model
# print("Reducing the full model...")
# lmm.raw.full.step <- step(lmm.raw.full)
# 
# # Reduced model
# lmm.raw.reduced <- get_model(lmm.raw.full.step)

# Save the variables
# print("Saving the variables...")
# save(glmm.full, file = "S101_full_fit.RData")

# versions of packages used
sessionInfo()