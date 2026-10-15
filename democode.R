# view the first few rows of mtcars dataset
head(Lead_Fingerprint_Study_2024)

# calculate the average mpg among all cars, save it as a variable
mean_ppm <- mean(Lead_Fingerprint_Study_2024$ppm)

# print the mean mpg
mean_ppm


#more stuff here


#load packages
library(dplyr)
library(knitr)
library(ggplot2)
library(RColorBrewer)
library(datasets)
install.packages("kableExtra")
library(kableExtra)
#hergoasdislghaos
mtcars %>% 
  ggplot(aes(x = hp, y = mpg)) #aes()=aesthetic. horsepower on x-axis, mpg on y-axis
#this hasn't plotted anything because we haven't specified what type of plot (geometric)
mtcars %>% 
  ggplot(aes(x = hp, y = mpg)) + # '+' adds a layer to the graph, while %>% pipes together *different tasks*
  geom_point() # function for a scatterplot
#to color the points according to a different variable, go back into the aes function and add color

mtcars %>% 
  ggplot(aes(x = hp, y = mpg, color = cyl)) + 
  geom_point()
#this produces a gradient. R assumes the cylinder values can be any value, rather than specific integers. In fact, the number of cylinders is a categorical value!
mtcars %>% 
  mutate(cyl=as.factor(cyl)) %>%  #this mutate as.factor will treat cyl as categorical (don't forget to pipe into the graph!)
  ggplot(aes(x = hp, y = mpg, color = cyl)) + 
    geom_point()

#to specify a color set, use RColorBrewer package. "Set2" should be more color blind friendly
mtcars %>% 
  mutate(cyl = as.factor(cyl)) %>%
  ggplot(aes(x = hp, y = mpg, color = cyl)) + 
  geom_point() + # notice the added '+'
  scale_color_brewer(palette = "Set2") 
#to change the shape of the points, go back to aes function and set the shape to desired variable. In this case, cylinders:
mtcars %>% 
  mutate(cyl = as.factor(cyl)) %>%
  ggplot(aes(x = hp, y = mpg, color = cyl, shape = cyl)) + 
  geom_point() + 
  scale_color_brewer(palette = "Set2") 
#to edit the axis titles, use 'xlab' and 'ylab' functions
mtcars %>% 
  mutate(cyl = as.factor(cyl)) %>%
  ggplot(aes(x = hp, y = mpg, color = cyl, shape = cyl)) + 
  geom_point() + 
  scale_color_brewer(palette = "Set2") +
  xlab("Horsepower")+
  ylab("Miles Per Gallon")
#edit the legend as well, using 'labs()'
mtcars %>% 
  mutate(cyl = as.factor(cyl)) %>%
  ggplot(aes(x = hp, y = mpg, color = cyl, shape = cyl)) + 
  geom_point() + 
  scale_color_brewer(palette = "Set2")  +
  xlab("Horsepower") + 
  ylab("Miles Per Gallon") +
  labs(color = "Number of Cylinders", shape = "Number of Cylinders") #have to rename both, otherwise it will split the legend, assuming shape and color mean different things
#add 'theme_minimal' to get rid of gray background. theme_classic also gets rid of grid
mtcars %>% 
  mutate(cyl = as.factor(cyl)) %>%
  ggplot(aes(x = hp, y = mpg, color = cyl, shape = cyl)) + 
  geom_point() + 
  scale_color_brewer(palette = "Set2")  +
  xlab("Horsepower") + 
  ylab("Miles Per Gallon") +
  labs(color = "Number of Cylinders", shape = "Number of Cylinders") +
  theme_classic()
# to add a title: ggtitle("...")
mtcars %>% 
  mutate(cyl = as.factor(cyl)) %>%
  ggplot(aes(x = hp, y = mpg, color = cyl, shape = cyl)) + 
    geom_point() + 
    scale_color_brewer(palette = "Set2")  +
    xlab("Horsepower") + 
    ylab("Miles Per Gallon") +
    labs(color = "Number of Cylinders", shape = "Number of Cylinders") +
    theme_minimal() + 
    ggtitle("Relationship between Number of Cylinders, Miles per Gallon, \nand Horsepower on the mtcars Dataset")
#The \n in the title is a special character that allows the line to break and fit on this size of plot.
###change size of points in geom_plot function
mtcars %>% 
  mutate(cyl = as.factor(cyl)) %>%
  ggplot(aes(x = hp, y = mpg, color = cyl, shape = cyl)) + 
  geom_point(size=3) +
  scale_color_brewer(palette = "Set2")  +
  xlab("Horsepower") + 
  ylab("Miles Per Gallon") +
  labs(color = "Number of Cylinders", shape = "Number of Cylinders") +
  theme_minimal() 

#Common Types of Plots

###geom_point(): scatterplot

###geom_line(): line plot

###geom_bar(): bar chart

###geom_histogram(): histogram

###geom_boxplot(): box plot

###geom_smooth(): adds a smooth trend line (various methods) (different from a normal trend line)

#examples

#lineplots
# Inspect the data
head(co2_df)

# How does atmospheric CO2 concentration change over time?

ggplot(co2_df, aes(x=date, y=concentration)) +
  geom_point(alpha = 0.2) +
  geom_line() + 
  labs(x = "Date", y = "CO2 Concentration")

##barplots
# Inspect the data
islands_df

# What are the largest 12 island landmasses on Earth?

ggplot(islands_df, aes(x = landmass, y = size)) +
  geom_bar(stat = "identity") +
  coord_flip() + 
  labs(x = 'Landmass', y = 'Size')

##histograms
##life expectancy of continents from gapminder_2016 dataset
#simple version
ggplot(gapminder_2016) +
  geom_histogram() +
  labs(x = "Life Expectancy", y = "Count")
install.packages("gapminder")
library(gapminder)
head(gapminder)
arrange(gapminder, desc(year))
install.packages("dslabs")
library(dslabs)
library(gapminder_2016)
head(gapminder_2016)
