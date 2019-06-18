  res_value = 350
  res_rela = 90
  w = 650/res_rela*res_value
  h = 402/res_rela*res_value
  
  png(file= paste0(tmpfn, ".png") ,width=w,height=h, res = res_value)
  
  #plot
  d.ColuPlot.E1
  
  dev.off()
