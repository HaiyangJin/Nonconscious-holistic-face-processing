# Save the plots for papers

tmpfn <- "E3-CF-RT"


res_value = 350
res_rela = 90
w = 650/res_rela*res_value
h = 402/res_rela*res_value

png(file= paste0(tmpfn, ".png") ,width=w,height=h, res = res_value)

#plot
rt.LinePlot.E3

dev.off()

  