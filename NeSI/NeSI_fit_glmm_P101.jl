# the inforamtion for the packages used
using Pkg
println(repeat("#", 50))
show(Pkg.status())
println("")
println(repeat("#", 50))

# load packages
using CSV, DataFrames, MixedModels

# read the data file
df = CSV.read("P101/P101_cf_clean.csv")
show(df)

# fit the linear mixed models
glmm_formula = @formula(isCorrect ~ Viewing * Congruency * Alignment + ExpCode +
  (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali | Participant) +
  (1 + View_D + Con_D + Ali_D + View_Con + View_Ali + Con_Ali + View_Con_Ali | FaceGroup))

@time glm1 = fit(GeneralizedLinearMixedModel, glmm_formula, df, Bernoulli())

@time glm2 = fit!(GeneralizedLinearMixedModel(glmm_formula, df, Bernoulli()))


println(glm1)

# save the theta values
CSV.write("P101_max_theta.csv", DataFrame(theta = glm1.theta), writeheader = true)
