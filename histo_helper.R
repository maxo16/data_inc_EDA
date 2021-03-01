# Okay, so as long as the category of interest is a global variable, it can just refer to it there. Don't need to worry about passing in a variable as an argument. 

# The "math" for the histogram
# This orders the data frame by date.
sf_311_kitty <- arrange(sf_311_kitty, Opened)

# Create a lag variable between calls. That's the next thing I'm interested in. 
sf_311_kitty <- sf_311_kitty %>% mutate(time_diff = Opened - lag(Opened), diff_secs = as.numeric(time_diff, units = 'secs'))


# This is just a good column to have, makes sorting based on statistical criteria a little easier.
sf_311_kitty <- sf_311_kitty %>% mutate(diff_z_score = scale(diff_secs))


# Code that creates the actual histogram. 
barfill <- "#4271AE"
barlines <- "#1F3552"

hist_kitty <- ggplot(sf_311_kitty, aes(x = diff_secs)) +
  geom_histogram(aes(y = ..count..), binwidth = 60,
                 colour = barlines, fill = barfill) +
  scale_x_continuous(name = "Time between service call (s)",
                     breaks = seq(0, 1200, 120),
                     limits=c(0, 1200)) +
  scale_y_continuous(name = "Count", labels = scales::comma) +
  ggtitle("Frequency histogram of time between service calls") +
  theme_economist() +
  theme(legend.position = "bottom", legend.direction = "horizontal",
        legend.box = "horizontal",
        legend.key.size = unit(1, "cm"),
        plot.title = element_text(family="Tahoma"),
        text = element_text(family = "Tahoma", hjust = 0.5),
        axis.title = element_text(size = 12),
        legend.text = element_text(size = 9),
        legend.title=element_text(face = "bold", size = 9))
hist_kitty

