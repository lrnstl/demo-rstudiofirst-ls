#Tidyverse notes and pivoting

#"tidy" data has a technical definition: 
#"Tidy data is defined as data where

##each variables form a column,

##each observation forms a row, and

##each cell is a single measurement"

#This allows data sets to have standardized formats, so that the same tools can 
#be used for different data sets, rather than creating analysis tools from scratch
#each time

#install.packages("tidyverse")
#install.packages("fivethirtyeight") <- The fivethirtyeight R package contains a
#dataset called drinks. This dataset was compiled as part of a FiveThirtyEight 
#article that explored (among other things) which countries consumes the most 
#alcohol. Let’s look at a subset of the data:
library(fivethirtyeight)
library(tidyverse)

drinks_tbl1 <- as_tibble(drinks) %>% 
  select(-total_litres_of_pure_alcohol) #removes total liters variable

head(drinks_tbl1) #view the first few rows of the data

#exercise: is this data tidy or untidy? would this change depending on what you
#were trying to do with the data? Try to make a ggplot that separates the number
#of servings of alcohol consumed per person in 2010 by the type of drink (beer, 
#wine, spirits) on the x-axis, and the number of countries in each of these groups
# an image of the desired plot is tidydata_drinksbycountry_exampleplot.jpeg in 
#the example images folder

# Pivoting

#this is a method to make untidy data tidy. 
#pivot_longer() uses information from columns to make new rows
#pivot_wider() uses information in rows to create new columns

##example of pivoting wider

#Here is an example of (artificial) data that is currently in “long” format, 
#looking grades before and after active learning was incorporated into their 
#math and science lectures
grades_long <- tibble(
  student_id = c(1, 1, 1, 1, 2, 2,2, 2, 3, 3, 3, 3),
  time = c("Before", "After", "Before", "After", "Before", "After", "Before", "After", "Before", "After", "Before", "After"),
  subject = c("Math", "Math", "Science", "Science", "Math", "Math", "Science","Science",  "Math", "Math", "Science", "Science"),
  score = c(85, 86, 92, 92, 78, 82, 88, 89, 95, 94, 90, 90)
)

head(grades_long)
#This data is technically tidy, but in order for us to analyse it longitudinally
#(across time), it is better to have the time points "before" and "after" as 
#their own columns, so we will pivot

#pivot_wider() has 3 required arguments: 
#### id_cols: the set of columns that uniquely identifies each observation
### names_from: the column that contains the names for the new variables
## values_from: the column where the values get pulled from

#If id_cols is not specified, the function will pivot every column except the 
#names_from and values_from. 
#all columns not called in the function will be dropped

#for example, in order to make new, separate columns for "before" and "after":
grades_wide <- grades_long %>% #assign new variable
  pivot_wider(names_from = time, #get column names from time
              values_from = score, #fill in values from score
              names_prefix = "Scores_") #add "scores_" to new column names

head(grades_wide)

#for demo, now we pivot grades_wide back to grades long:

grades_wide%>%
    pivot_longer(cols=c("Scores_Before", "Scores_After"), #columns to reduces
                 names_to = "time", #name of new column to store info from column titles
                 values_to = "scores") #name of new column to store values

#example of pivoting longer

#consider a tibble:
# A tibble: 3 × 3 of WHO data on tuberculosis cases in different years in different countries

who_wide<- tibble(country = c(" Afghanistan", "Brazil", "China"),
       `1999` = c(745, 37737, 212258),
      `2000` = c(2666, 80488, 213766))
#if we want to plot the years on an x-axis to look at the cases over time, then 
#we need to make a column identifying each observation by year
#IE, we want to turn the information of the column names into values of a new column,
#so that we can treat them as variables
#pivot_longer()
#   cols = the column(s) to be expanded into rows
#   names_to = the name of the new column(s)
#   values_to = the new column that contains the values contained in our old columns
who_long <- who_wide %>% pivot_longer(cols = c('1999', '2000'), #pivot these columns
                                      names_to = "year", #new column name is year
                                      values_to = "cases") #use cases as the values of the column

who_long

#example of pivot longer when column names contain multiple variables
who_demo <- who2 %>% 
  select(country, year, starts_with("sp")) %>%
  rename_with(function(x) 
    str_remove(x, pattern="sp_"), 
    starts_with("sp")) %>% 
  filter(year %in% c(1999, 2000)) %>% 
  filter(country %in% c("Afghanistan", "Brazil", "China"))

head(who_demo)
# each column is identified by a gender (m/f) and an age range (014\1524\2534\3544\4554\5564\65)
#if we want to compare gender and age across years and country, then we need to pull those values
#out of columns and into rows

#our new columns will be: country, year, gender, age range, case count
#so how do we make 2 new columns out of 1 column title?
#the names_sep argument identifies which parts of the info go into which column

who_demo %>% 
  pivot_longer(cols = !(country:year), # all columns aside from country to year
                          names_to = c("gender", "age"), #new columns named age and gender
                          names_sep = "_", #current gender and age are a single variable separated by _
                          values_to = "cases") #use the cases column for the values
#you can use ".value" in place of new column names to have the columns populate from the separated segments. See worksheet 4, question 2.3 solution

