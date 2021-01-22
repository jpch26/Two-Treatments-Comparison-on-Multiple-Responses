# Bar graph function ------------------------------------------------------

bar_graph <- function(data = NULL, x = x, y = y, err_bar = err_bar, 
                      x_lab = "", y_lab = "", main_title = "", ...) {
  graph <- ggplot(
    data = data, 
    aes(x = as.factor({{ x }}), y = {{ y }})
  ) +
    geom_col(
      width = 0.2, 
      color = "black", 
      fill = "royalblue1"
    ) +
    geom_errorbar(
      aes(ymin = {{ y }} - {{ err_bar }}, 
          ymax = {{ y }} + {{ err_bar }}), 
      width = 0.05
    ) +
    xlab(x_lab) +
    ylab(y_lab) +
    ggtitle(main_title)
  
  return(graph)
}