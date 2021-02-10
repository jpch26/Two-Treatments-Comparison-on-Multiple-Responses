
# Main Script -------------------------------------------------------------

# Preferably, before you run this script restart your R session: 
# Ctrl+Shift+F10 if you are using RStudio

# Packages

library(dplyr)   # To summarize data and another tasks
library(ggplot2) # To make graphs
library(purrr)   # Easier iteration
library(ggpubr)  # To combine gg plots
library(stringi) # To assign random strings on data simulation

# 1 Simulate the  data
source("analysis/data_simulation.R")

# 2 T-test to compare response means between treatments
source("analysis/t_test_analysis.R")

# 3 Summary for each response grouping by treatment
source("analysis/summaries.R")

# 4 Graphs for each response grouping by treatment 

source("analysis/graph_theme.R")
source("analysis/bar_point_graphs.R")
source("analysis/bar_graphs.R")
source("analysis/point_graphs.R")

# 5 Session Info 
capture.output(sessionInfo(), file = "Session_Info.txt")
