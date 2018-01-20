# Global script where all calls to 
# libraries, loading of data, 
# and non-reactive variables live
#
# Bradley Pick January 18, 2018
#

library(shiny)
library(readr) 
library(dplyr)
library(ggplot2)
library(forcats)
library(scales)
library(plotly)

data <- read_csv("./cansim-food-exp.csv",
                 col_types = cols(Ref_Date = col_integer(),
                                  GEO = col_character(),
                                  STAT = col_character(),
                                  SUMMARY = col_character(),
                                  Value = col_number()))


food_groups <- c("Bakery products",
                 "Cereal grains and cereal products",
                 "Fruit, fruit preparations and nuts",
                 "Vegetables and vegetable preparations",
                 "Dairy products and eggs",
                 "Meat",
                 "Fish and seafood",
                 "Non-alcoholic beverages and other food products")

geographies <- c("British Columbia",
                 "Prairie Region",
                 "Ontario",
                 "Quebec",
                 "Atlantic Region")

atlantic_region <- c("Newfoundland and Labrador",
                     "Prince Edward Island",
                     "Nova Scotia",
                     "New Brunswick")

prairie_region <- c("Manitoba", 
                    "Saskatchewan", 
                    "Alberta")

store_rest <- c("Food purchased from stores", 
                "Food purchased from restaurants")

times <- c("Restaurant dinners", 
           "Restaurant lunches", 
           "Restaurant breakfasts")


## colourblind friendly palette from:
## http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/

cbbPalette <- c("Canada" = "#000000", "British Columbia" = "#E69F00", 
                "Prairie Region" = "#56B4E9", "Ontario" = "#009E73", 
                "Quebec" = "#CC79A7", "Atlantic Region" = "#0072B2")


