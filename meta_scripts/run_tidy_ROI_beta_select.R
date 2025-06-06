#!/usr/bin/env Rscript
#synopsis: Rscript run_tidy_ROI_beta.R 226 R-L


require(rio)
require(dplyr)
require(stringr)
require(ggplot2)
#require(d3heatmap)
require(heatmaply)
require(tidyr)

source('tidy_ROI_beta_functions.R')
args <- c('254','R-L')

# Define number of participants
# /media/tcnl/data2/GRIPFORCE/out/afni/subject_results/group_results
# test.CSPLINzero.3dMEMA_N=222.R-L.results

NrSubj <- args[1] #Sample size (e.g., 226)
contr <- args[2] # condition (e.g., R-L)
resdir <- '../out/afni/subject_results/group_results'
meanfpths <- list.files(
  path=sprintf("%s/test.CSPLINzero.3dMEMA_N=%s.%s.results", 
               resdir,NrSubj, contr),
  pattern ='.*#[0-9]+_Coef.*info.txt',
  full.names = T)
countfpths <- list.files(
  path=sprintf("%s/test.CSPLINzero.3dMEMA_N=%s.%s.results", 
               resdir, NrSubj, contr),
  pattern ='count.txt',
  full.names = T)


meanfns <- list.files(
  path=sprintf("%s/test.CSPLINzero.3dMEMA_N=%s.%s.results", 
               resdir, NrSubj, contr),
  pattern ='.*#[0-9]+_Coef.*info.txt')

countfns <- list.files(
  path=sprintf("%s/test.CSPLINzero.3dMEMA_N=%s.%s.results", 
               resdir, NrSubj, contr),
  pattern ='count.txt')


#roiname <- sub("(.{8}).*", "\\1", fns)
roiname <- strsplit(meanfns, '=')
roiname_count <- strsplit(countfns, '=')

dall_coef <- tibble()
dall_count <- tibble()
for (i in seq(1,length(meanfpths))){
  message(roiname[[i]][1])
  d <- import(meanfpths[i]) %>%
    mutate(condition = roiname[[i]][1]) %>%
    select(-File) %>%
    rename_with(~str_replace(.,"NZcount","NZcountRL"))
  dall_coef <- rbind(dall_coef, d)
}


for (i in seq(1,length(countfpths))){
  message(roiname_count[[i]][1])
  d <- import(countfpths[i]) %>%
    mutate(condition = roiname_count[[i]][1]) %>%
    select(-File) %>%
    rename_with(~str_replace(.,"NZcount","NZcountRL"))
  
  
  
  dall_count <- rbind(dall_count, d)
}


dall_coef <- dall_coef %>% 
  rename(ID = `Sub-brick`)
dall_coef <- dall_coef %>%  mutate(ID = str_extract(ID,"[0-9]{4}"))

dall_count <- dall_count %>% 
  rename(ID = `Sub-brick`)
dall_count <- dall_count %>%  mutate(ID = str_extract(ID,"[0-9]{4}"))

## Notes on ROI names (as of N= 222, 2023/01/05)
# - group mask q=.001, NN1 (t = 4.0098)
# - individual p = .01 t = 2.25983
# 1 L_PMC, Left Precentral/Postcentral
# 2 R_PMC, Right Precentral/Postcentral
# 3 L_Cereb_V_VI Left V_VI (cerebellum)
# 4 R_Cereb_V_VI Right V_VI (cerebellum)
# 5 R_insula, Right Insula
# 6 L_SMA, Left SMA
# 7 L_insula, Right insula
# 8 R_SMA, Right SMA

#as of 2023-01-07 N=222, p = 8.3-5e, q = .001
roilabels <- list(
  "L-PMC" = 2,
  "R-PMC" = 1,
  "L-Cereb_V_VI" = 3,
  "R-Cereb_V_VI" = 5,
  "L-SMA" = 7,
  "R-insula"= 4,
  "L-insula" = 8,
  "R-SMA" = 6)


data <- dall_coef
d_mean_long <- data_wide2long(dall_coef, 'NZMean', roilabels)

# for exporting data

d_mean_long_summ <- d_mean_long %>% 
  filter(Time %in% seq(3,7)) %>%
  group_by(ID, Hand, Force, Hemisphere, ROI)%>%
  summarise(value = mean(value))


d_sigma_long <- data_wide2long(dall_coef, 'NZsigma', roilabels)
d_count_long <- data_wide2long_notime(dall_count,'NZcount', roilabels)

d_count_long_summ <-  d_count_long %>%
  group_by(ID, Hand, Force, Hemisphere, ROI)%>%
  summarise(value = mean(value))
# Export for the feature list
rio::export(d_count_long_summ, 
            file=sprintf("ROI_features/R-L_voxel_count_N=%s.csv",NrSubj))
rio::export(d_mean_long_summ, 
            file=sprintf("ROI_features/R-L_beta_N=%s.csv", NrSubj))

#various data summary
d_mean_long_cereb <- d_mean_long %>%
  filter(str_detect(ROI, "Cereb"))
d_mean_long_PMC <- d_mean_long %>%
  filter(str_detect(ROI, "PMC"))
d_mean_long_SMA <- d_mean_long %>%
  filter(str_detect(ROI, "SMA"))

d_mean_long_PMC_cereb <- d_mean_long %>%
  filter(str_detect(ROI, "PMC|Cereb"))

# count data doesn't distinguish Time, therefore use the summ outcome to reduce the data
d_count_long_cereb <- d_count_long_summ %>%
  filter(str_detect(ROI, "Cereb"))
d_count_long_PMC <- d_count_long_summ %>%
  filter(str_detect(ROI, "PMC"))
d_count_long_SMA <- d_count_long_summ %>%
  filter(str_detect(ROI, "SMA"))
d_count_long_insula <- d_count_long_summ %>%
  filter(str_detect(ROI, "insula"))


#various line plots

line_mean <- roi_lineplot(d_mean_long)
line_sigma <- roi_lineplot(d_sigma_long)
line_count <- roi_lineplot(d_count_long)


# various column plots
col_mean <- roi_colplot(d_mean_long_summ)
col_count <- roi_colplot(d_count_long_summ)
col_count_cereb <- roi_colplot(d_count_long_cereb)
col_count_PMC <- roi_colplot(d_count_long_PMC)
col_count_SMA <- roi_colplot(d_count_long_SMA)
col_count_insula <- roi_colplot(d_count_long_insula)

# use show(<fig_handle>) to see the graphs
show(line_mean)

