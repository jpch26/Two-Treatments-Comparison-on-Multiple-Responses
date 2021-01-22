
# T-test function ---------------------------------------------------------

# Perform a t-test given a response name, a model and data

ttest_func <- function(response = "", model = NULL, data = NULL, 
                        alpha = 0.05, ...) {
  
  # Convert to a formula if the given model is a character
  if (!class(model) == "formula") {
    model <- as.formula(model)
  }
  
  ## Determine if variances are equal through a F test
  ## Store the logical value to use in t.test
  var_equal_pvalue <- var.test(model, data)$p.value
  var_equal        <- var_equal_pvalue > alpha
  
  ## Perform a t test given the model and data arguments
  resp_tt <- t.test(
    model, data = data, conf.level = 1 - alpha, 
    var.equal = var_equal, ...
    )
  
  # Convert the t-test object to a character vector
  resp_tt <- unlist(resp_tt)
  
  # Convert to a data frame     
  resp_tt <- data.frame(
    c("Statistic t", "df", "p value", "Conf. lim. inf.", "Conf. lim. sup.",
      "Group 1 mean", "Group 2 mean", "Null hypotesis value", "Standard error",
      "Alternative", "Method", "Model", "Var. equal p value"), 
    c(unname(resp_tt), var_equal_pvalue)
    )
  
  # Rename columns
  names(resp_tt) <- c("Info", response)
  
  # Convert results elements, when is applicable, to a numeric element 
  # !is.na(as.numeric(...)) produces a warning message,
  # so I used suppressWarnings to avoid this messages
  suppressWarnings(
    num_elements <- !is.na(as.numeric(resp_tt[[response]]))
  )
  resp_tt[[response]][num_elements] <- round(
    as.numeric(resp_tt[[response]][num_elements]), 2
  ) 
  
  # Return the t-test
  return(resp_tt)
}
