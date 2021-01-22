
# T test analysis ---------------------------------------------------------

# Load required packages if they don't 
if (!"dplyr" %in% .packages()) library(dplyr)
if (!"purrr" %in% .packages()) library(purrr)

# 1 Source functions ------------------------------------------------------
source("functions/t_test_func.R")

# 2 Data ------------------------------------------------------------------

# 2.1 Import main Data
main_data <- read.csv(file = "data/main_data.csv")

# 2.2 Import response information
resp_info <- read.csv(file = "data/response_info.csv")

# 2.3 Response codes
resp_codes <- resp_info$Code

# 3 t-Test analysis on each response --------------------------------------

# 3.1 Define a character vector with the models
formulas  <- paste(resp_codes, "~ DT")

# 3.2 Apply t_test_fun on each response
ttest_ls <- vector(mode = "list", length = length(resp_codes))

for (i in 1:length(resp_codes)) {
  ttest_ls[[i]] <- ttest_func(
    response = resp_codes[i],
    model = formulas[i],
    data = main_data
    )
}

# 3.3 Join the list of data frames into one data frame
ttest_report <- Reduce(
  function(x, y, ...) full_join(x, y, by = "Info"),
  ttest_ls
)

# 4 Save the results data frame -------------------------------------------

write.csv(ttest_report, file = "data/ttest_report.csv", row.names = FALSE)
