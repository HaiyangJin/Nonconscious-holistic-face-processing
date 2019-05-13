dummy_coding_P101 <- function (df) {
  df <- {
    df %>% 
      mutate(
        View_C = if_else(Viewing == viewing.levels[1], 0, if_else(Viewing == viewing.levels[2], 1, NaN)),
        Con_C = if_else(Congruency == congruency.levels[1], 0, if_else(Congruency == congruency.levels[2], 1, NaN)),
        Ali_C = if_else(Alignment == alignment.levels[1], 0, if_else(Alignment == alignment.levels[2], 1, NaN)),
        
        View_Con = View_C * Con_C, 
        View_Ali = View_C * Ali_C,
        Con_Ali = Con_C * Ali_C,
        
        View_Con_Ali = View_C * Con_C * Ali_C
      )
  }
  return(df)
}