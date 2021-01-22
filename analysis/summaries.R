
# Summaries for all responses ---------------------------------------------

# Load required packages if they don't 
if (!"dplyr" %in% .packages()) library(dplyr)
if (!"purrr" %in% .packages()) library(purrr)

# 1 Source functions ------------------------------------------------------
source("functions/summary_func.R")

# 2 Data ------------------------------------------------------------------

# 2.1 Import main data
main_data <- read.csv("data/main_data.csv")

# 2.2 Import response information
resp_info <- read.csv("data/response_info.csv")

# 2.2 Response codes
resp_code <- resp_info$Code

# 3 Summary for each response --------------------------------------------- 

# 3.2 Use sum_tables function to make summaries for all responses
# summaries <- sum_tables(resp_names, data = main_data, group_factor = DT)

sum_ls <- vector(mode = "list", length = length(resp_code))

for (i in 1:length(resp_code)) {
  
  temp_data <- select(main_data, DT, resp_code[i]) %>% 
    rename(resp = resp_code[i])
  
  sum_ls[[i]] <- sum_table(
    data = temp_data,
    group_factor = DT,
    response = resp
    )
}

# 4 Save each summary  ----------------------------------------------------
file_paths <- paste0("data/", resp_code, "_summary.csv")

walk2(sum_ls, file_paths, write.csv, row.names = FALSE)
