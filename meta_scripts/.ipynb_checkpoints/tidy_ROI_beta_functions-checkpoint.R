#functions

data_wide2long <- function(data, paramstr, roilabels){
  
  d <- data %>%
    select(ID, condition, starts_with(paramstr))
  
  names(d)[3:(3+length(roilabels)-1)] <- names(roilabels)
  
  
  
  
  d_long <- 
    pivot_longer(
      d, 
      cols = c(3:(3+length(roilabels)-1)), 
      names_to = "ROI") %>%
    separate(ROI,"-", into=c("Hemisphere", "ROI")) %>%
    separate(condition, "#",into = c("Hand","Time" ))%>%
    separate(Time, "_", into = c("Time"))%>%
    tidyr::extract(Hand, c("Hand", "Force"), "([LR])([064]+)")%>%
    mutate(
      Hand = if_else(Hand=="L", "Left_Hand", "Right_Hand"),
      Hemisphere = if_else(
        Hemisphere == "L", 
        "LH", 
        "RH"
      ), 
      Force = as.factor(Force)
    ) %>%
    mutate(Hand = as.factor(Hand),
           Hemisphere = as.factor(Hemisphere),
           Time = as.numeric(Time))
  
  
  return(d_long)
}


data_wide2long_notime <- function(data, paramstr, roilabels){
  #paramstr <- 'NZcount'
  #data <- dall_count
  d <- data %>%
    select(ID, condition, starts_with(paramstr))
  
  names(d)[3:(3+length(roilabels)-1)] <- names(roilabels)
  
  
  
  d_long <- 
    pivot_longer(
      d, 
      cols = c(3:(3+length(roilabels)-1)), 
      names_to = "ROI") %>%
    separate(ROI,"-", into=c("Hemisphere", "ROI")) %>%
    separate(condition, "_",into = c("Hand","Time" )) %>%
    tidyr::extract(Hand, c("Hand", "Force"), "([LR])([064]+)") %>%
    mutate(
      Hand = if_else(Hand=="L", "Left_Hand", "Right_Hand"),
      Hemisphere = if_else(
        Hemisphere == "L", 
        "LH", 
        "RH"
      ), 
      Force = as.factor(Force)
    ) %>%
    mutate(Hand = as.factor(Hand),
           Hemisphere = as.factor(Hemisphere))
  
  
  return(d_long)
}



roi_lineplot <- function(data){
  f <- ggplot(data = data, 
              aes(
                x = Time, 
                y = value, 
                color = interaction(Hand, Force))
  )+
    stat_summary(
      fun = median,
      geom  = "line",
      size = 1.5
    )+
    stat_summary(
      fun = median,
      geom  = "point",
      size = 3
    )+
    scale_x_continuous(
      breaks=seq(0,length(unique(data$Time))))+
    facet_grid(ROI ~ Hemisphere) +
    theme(legend.position="top",
          panel.background = element_blank(),
          axis.line = element_line(colour = "black")) +
    guides(color=guide_legend(title="Hand X Force")) +
    ylab('beta(%)')
  
  
  
  return(f)
  
}




roi_one_lineplot <- function(data, tistr, legflag){
  f <- ggplot(data = data, 
              aes(
                x = Time, 
                y = value, 
                color = Hemisphere)
  )+
    stat_summary(
      fun = median,
      geom  = "line", 
      linewidth = 2
    )+
    stat_summary(
      fun = median,
      geom  = "point"
    )+
    scale_x_continuous(
      breaks=seq(0,length(unique(data$Time))))+
    theme(#legend.position="Right",
      legend.position=c(.9, .8), 
      axis.text.x = element_text(size = 20),
      axis.text.y = element_tefxt(size = 20),
      axis.title.x = element_text(size = 24),
      axis.title.y = element_text(size = 24),
      plot.title = element_text(size = 30)) +
    ylab('beta(%)') +
    ggtitle(tistr)
  
  if (legflag != "none")  {
    f <- f+ guides(color=guide_legend(title="Hand X Force")) 
  } else {
    f <- f + guides(color = legflag)
  }
  
  
  
  
  return(f)
  
}



#tallying BOLD across time window
roi_colplot <- function(data){
  f <- ggplot(data = data, 
              aes(
                x = Hemisphere, 
                y = value, 
                fill = interaction(Force, Hand))
  )+
    stat_summary(
      fun = median,
      geom  = "col", 
      position=position_dodge()
    )+
    facet_grid(ROI ~ .) +
    theme(legend.position="top")
  
  
  
  return(f)
  
}


