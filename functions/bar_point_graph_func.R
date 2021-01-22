
# Bar point graph function --------------------------------------------------

bar_point_graph <- function(data_1, data_2, x, y_1, err_bar = sd, y_2, 
                            x_lab = " ", y_lab = " ", main_title = "") {
  graph <- ggplot(
    data = data_1, 
    aes(x = as.factor({{ x }}), y = {{ y_1 }})
  ) +
    geom_col(
      width = 0.2, 
      color = "black", 
      fill = "royalblue1"
    ) +
    geom_errorbar(
      aes(ymin = {{ y_1 }} - {{ err_bar }}, 
          ymax = {{ y_1 }} + {{ err_bar }}), 
      width = 0.05
    ) +
    geom_point(
      data = data_2, 
      aes(x = {{ x }}, y = {{ y_2 }}),
      color = "red3"
    ) +
    xlab(x_lab) +
    ylab(y_lab) +
    ggtitle(main_title)
  
  return(graph)
}