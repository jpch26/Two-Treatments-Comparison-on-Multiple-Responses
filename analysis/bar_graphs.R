
# Bar Graphs   ------------------------------------------------------------

## Load required packages if they don't 
if (!"ggplot2" %in% .packages()) library(ggplot2)
if (!"purrr" %in% .packages()) library(purrr)

# 1 Source functions and global theme -------------------------------------
source("functions/bar_graph_func.R")
source("analysis/graph_theme.R")

# 2 Data -----------------------------------------------------------------

# 2.1 Import response information
resp_info <- read.csv("data/response_info.csv")

# 2.2 Response codes
resp_code <- resp_info$Code

# 2.3 File paths with the summary names
file_paths <- paste0("data/", resp_code, "_summary.csv")

# 2.4 Import summaries in a list
summaries <- map(file_paths, read.csv)

# 3 Bar graph for each response ------------------------------------------ 

# 3.1 Response units for y labs
resp_units <- resp_info$Units

# 3.2 Response names for main titles
resp_names <- resp_info$Description

# 3.3 Apply bar_graph function to each summary in summaries list

graphs <- vector(mode = "list", length = length(resp_code))

for (i in 1:length(resp_code)) {
  graphs[[i]] <- bar_graph(
    data = summaries[[i]], 
    x = DT, y = mean, 
    err_bar = sd, x_lab = "Diet",
    y_lab = resp_units[i], main_title = resp_names[i]
    )
}

# 4 Save each graph ------------------------------------------------------

# File paths with graph names
graph_paths <- paste0("graphs/", resp_code, "_bargraph.jpeg")

# Save each graph
walk2(graph_paths, graphs, ggsave)

# 5 Optional: Combine graphs ----------------------------------------------
if (!"ggpubr" %in% .packages()) library(ggpubr)

figure <- ggarrange(graphs[[1]], graphs[[2]], graphs[[3]], 
                    graphs[[4]], graphs[[5]], nrow = 2, ncol = 3)

ggsave(filename = "graphs/bar_figure.jpeg", plot = figure,
       units = "cm", width = 15, height = 10, scale = 1.5)

