
# Summary function --------------------------------------------------------

sum_table <- function(data = NULL, group_factor, response) {
  
  sum <- data %>% 
    group_by({{ group_factor }}) %>% 
    summarise(
      min    = min({{ response }}),
      max    = max({{ response }}),
      range  = max - min,
      mean   = round(mean({{ response }}), 2), 
      median = round(median({{ response }}), 2),
      sd     = round(sd({{ response }}), 2),
      cv     = round((sd / mean) * 100, 2)
    )
  
  return(sum)
}

# Summaries function -------------------------------------------------------

sum_tables <- function(response_names = "", data = NULL, 
                       group_factor) {
  
  tables <- map(
    response_names, 
    ~sum_table(
      data, 
      response = .data[[.x]], 
      group_factor = {{ group_factor }}
      )
    )
  
  return(tables)
}


