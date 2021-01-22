
# Point graphs ------------------------------------------------------------

# Load required packages if they don't -----------------------------------
if (!"ggplot2" %in% .packages()) library(ggplot2)
if (!"purrr" %in% .packages()) library(purrr)
if (!"dplyr" %in% .packages()) library(dplyr)

# 1 Source functions and global theme ------------------------------------
source("functions/point_graph_func.R")
source("analysis/graph_theme.R")

# 2 Import data ----------------------------------------------------------

# 2.1 Main data
main_data <- read.csv("data/main_data.csv")

# 2.2 Data info
resp_info <- read.csv("data/response_info.csv") 

# 3 Make bar graph for each response -------------------------------------- 

# 3.1 Response codes for selections
resp_code <- resp_info$Code

# 3.1 Response units for y labs
resp_units <- resp_info$Units

# 3.2 Response names for main titles
resp_names <- resp_info$Varible

# 3.3 Apply point_graph function to each response
graphs <- vector(mode = "list", length = length(resp_code))
for (i in 1:length(resp_code)) {
  
  # Subset main data
  sub_data <- select(main_data, DT, resp_code[i]) %>% 
    rename(resp = resp_code[i])
  
  # Make the point graph
  graphs[[i]] <- point_graph(
    data = sub_data,
    x = DT,
    y = resp,
    x_lab = "Diet",
    y_lab = resp_units[i],
    main_title = resp_names[i],
    add_stat = TRUE,
    fun = median
  )
}

# 4 Save each graph -------------------------------------------------------

# File paths with the response codes as names 
graph_paths <- paste0("graphs/", resp_code, "_pointgraph.jpeg")

# Save each graph
walk2(graph_paths, graphs, ggsave)

# 5 Optional: Combine graphs ----------------------------------------------
if (!"ggpubr" %in% .packages()) library(ggpubr)

figure <- ggarrange(graphs[[1]], graphs[[2]], graphs[[3]], 
                    graphs[[4]], graphs[[5]], nrow = 2, ncol = 3)

ggsave(filename = "graphs/point_figure.jpeg", plot = figure,
       units = "cm", width = 15, height = 10, scale = 1.5)

