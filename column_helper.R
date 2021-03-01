sf_311_kitty_wday <- sf_311_kitty %>% group_by(Opened_wday) %>% summarize("calls_by_day" = n())

# Code that creates the actual histogram. 
barfill <- "#4271AE"
barlines <- "#1F3552"

column_kitty <- ggplot(sf_311_kitty_wday, aes(x = Opened_wday, y = calls_by_day)) +
  geom_col(colour = barlines, fill = barfill) +   
  ggtitle("Service Calls Per Day") +
  scale_y_continuous(name = "Count", labels = scales::comma) +
  labs(x = "Day of the week") +
  theme_economist() +
  theme(legend.position = "bottom", legend.direction = "horizontal",
        legend.box = "horizontal",
        legend.key.size = unit(1, "cm"),
        plot.title = element_text(family="Tahoma"),
        text = element_text(family = "Tahoma", hjust = 0.5),
        axis.title = element_text(size = 12),
        legend.text = element_text(size = 9),
        legend.title=element_text(face = "bold", size = 9))
column_kitty