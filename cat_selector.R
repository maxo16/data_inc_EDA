# This will be a little helper script that will initialize the kitty data frame based on the chosen cat. 
# Should it instead be a helper function that returns the kitty data frame??? 

kitty_finder <- function(cat_num) {

  kitty <- summary_by_category$Category[cat_num]

  # Creates the filtered data frame. 
  return(filter(sf_311, Category == kitty))
}