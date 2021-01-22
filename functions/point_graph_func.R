
# Point graph function ----------------------------------------------------

point_graph <- function(data = NULL, x, y, fun, add_stat = FALSE, 
                        x_lab = " ", y_lab = " ", main_title = "") {
  
  graph <- ggplot(
    data = data, 
    aes(x = as.factor({{ x }}), y = {{ y }})
    ) +
    geom_point() +
    xlab(x_lab) +
    ylab(y_lab) +
    ggtitle(main_title)
  
  if (isTRUE(add_stat)) {
    graph <- graph +
      stat_summary(
        fun = fun, geom = "crossbar", 
        width = 0.2, col = "blue"
      ) 
  }
  
  return(graph)
}

# Bar Point graph function ------------------------------------------------

bar_point_graph <- function() {}
