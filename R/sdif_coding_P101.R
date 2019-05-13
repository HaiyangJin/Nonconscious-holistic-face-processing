sdif_coding_P101 <- function (df) {
  # successive differences (backward difference coding)  MASS::contr.sdif
  df <- {
    df %>%
      mutate(
        View_C = if_else(Viewing == viewing.levels[1], -.5, if_else(Viewing == viewing.levels[2], .5, NaN)),
        Cover_C = if_else(CFS_Cover == "both", -.5, if_else(CFS_Cover == "test", .5, NaN)),
        Con_C = if_else(Congruency == congruency.levels[1], -.5, if_else(Congruency == congruency.levels[2], .5, NaN)),
        Ali_C = if_else(Alignment == alignment.levels[1], -.5, if_else(Alignment == alignment.levels[2], .5, NaN)),
        
        View_Con = View_C * Con_C, 
        View_Ali = View_C * Ali_C,
        Con_Ali = Con_C * Ali_C,
        View_Cover = View_C * Cover_C,
        Con_Cover = Con_C * Cover_C,
        Ali_Cover = Ali_C * Cover_C,
        
        View_Con_Ali = View_C * Con_C * Ali_C,
        View_Con_Cover = View_C * Con_C * Cover_C,
        View_Ali_Cover = View_C * Ali_C * Cover_C,
        Con_Ali_Cover = Con_C * Ali_C * Cover_C,
        
        View_Con_Ali_Cover = View_C * Con_C * Ali_C * Cover_C
        
      )}
  
  contrasts(df$Viewing) <- MASS::contr.sdif(nlevels(df$Viewing)) 
  contrasts(df$CFS_Cover) <- MASS::contr.sdif(nlevels(df$CFS_Cover)) 
  contrasts(df$Congruency) <- MASS::contr.sdif(nlevels(df$Congruency)) 
  contrasts(df$Alignment) <- MASS::contr.sdif(nlevels(df$Alignment)) 
  

  
  return(df)
}