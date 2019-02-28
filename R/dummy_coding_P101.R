dummy_coding_P101 <- function (df) {
  df <- {
    df %>% 
      mutate(
        View_D = if_else(Viewing == viewing.levels[1], 0, if_else(Viewing == viewing.levels[2], 1, NaN)),
        Con_D = if_else(Congruency == congruency.levels[1], 0, if_else(Congruency == congruency.levels[2], 1, NaN)),
        Ali_D = if_else(Alignment == alignment.levels[1], 0, if_else(Alignment == alignment.levels[2], 1, NaN)),
        
        View_Con = View_D * Con_D, 
        View_Ali = View_D * Ali_D,
        Con_Ali = Con_D * Ali_D,
        
        View_Con_Ali = View_D * Con_D * Ali_D
      )
  }
  return(df)
}