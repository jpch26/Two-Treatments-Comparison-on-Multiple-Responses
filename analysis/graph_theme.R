# Set a global theme for all graphs ------------------------------------------

theme_set(
  theme_classic() +
    theme(axis.text.x = element_text(color = "black", size = 13),
          axis.text.y = element_text(color = "black", size = 13),
          axis.title = element_text(color = "black", size = 15),
          plot.title=element_text(size=15, face = "italic"))
)
