# Data Simulation  --------------------------------------------------------

if (!"purrr" %in% .packages()) library(purrr)
if (!"stringi" %in% .packages()) library(stringi)

set.seed(5) # For reproducibility

# Replicates per treatment
n <- 6

# Character vector with random strings for each individual 
code_ind <- stri_rand_strings(
  n = 2*n, 
  length = 3, 
  pattern = "[A-Z0-9]")

# Character vector with each diet category
diet <- c(rep(1, n), rep(2, n))

# Parameters for Response 1: mice weight (g)
# Assuming a significant difference
mu_wg  <- c(23, 19)    # Treatment means
sig_wg <- c(1.2, 1.1)  # Treatment standard deviations

# Response 1 vector
wg <- unlist(map2(mu_wg, sig_wg, rnorm, n = n)) 

# Parameters for Response 2: total cholesterol (mg/dL)
# Assuming a significant difference
mu_ch  <- c(210, 175)
sig_ch <- c(16, 10)

# Response 2 vector
ch <- unlist(map2(mu_ch, sig_ch, rnorm, n = n))

# Parameters for Response 3: glucose levels (mg/dL)
# Assuming a significant difference
mu_gl  <- c(150, 90)
sig_gl <- c(10, 9)

# Response 3 vector
gl <- unlist(map2(mu_gl, sig_gl, rnorm, n = n))

# Parameters for Response 4: protein apoD levels (pixel intensity) 
# Assuming a significant difference
mu_apd  <- c(2.1, 1.0)
sig_apd <- c(0.15, 0.5)

# Response 4 vector
apd <- unlist(map2(mu_apd, sig_apd, rnorm, n = n))

# Parameters for Response 5: relative expression of gene apoAI 
# (relative quantification)
# Assuming not significant difference
mu_api  <- c(1.0, 1.05)
sig_api <- c(0.4, 0.20)

# Response 5 vector
api <- unlist(map2(mu_api, sig_api, rnorm, n = n))

# Data frame with all responses -------------------------------------------

main_data <- data.frame(
  IND = code_ind,
  DT  = diet,
  WG  = round(wg, 2),
  CH  = round(ch, 2),
  GL  = round(gl, 2),
  PD  = round(apd, 2),
  PI  = round(api, 2)
)

write.csv(main_data, file = "data/main_data.csv", row.names = FALSE)

# Responses information ----------------------------------------------

# Response code
resp_code <- c("WG", "CH", "GL", "PD", "PI")

# Response description
resp_desc <- c("Weight", "Total cholesterol", 
              "Glucose levels", "apoD levels", "apoAI levels") 

# Response units
resp_units <- c("g", "mg/dL", "mg/dL", 
               "Pixel intensity", "Relative expression")

resp_inf <- data.frame(
  Code  = resp_code,
  Description = resp_desc,
  Units = resp_units
)

write.csv(resp_inf, file = "data/response_info.csv", row.names = FALSE)

# Variables info ----------------------------------------------------------

# Variables code
var_code <- c("IND", "DT")

# Variables description
var_desc <- c("Mouse individual code", "Diet type")

# Variables units
var_units  <- c("Not applicable", "1: high fat/cholesterol diet, 2: regular")

var_inf <- data.frame(
  Code = var_code,
  Description = var_desc,
  Units = var_units
)

write.csv(var_inf, file = "data/variable_info.csv", row.names = FALSE)


