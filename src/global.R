# Global script where all calls to 
# libraries, loading of data, 
# and non-reactive variables live
#
# Bradley Pick January 18, 2018
#

library(shiny)
library(shinythemes)
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

data <- data %>% 
  mutate(SUMMARY = fct_recode(SUMMARY, "All food expenditures"="Food expenditures"))


food_groups <- c("Bakery products",
                 "Cereal grains and cereal products",
                 "Fruit, fruit preparations and nuts",
                 "Vegetables and vegetable preparations",
                 "Dairy products and eggs",
                 "Meat",
                 "Fish and seafood",
                 "Non-alcoholic beverages and other food products")

bakery <- c("Bread and unsweetened rolls and buns",
            "Cookies and crackers",
            "Other bakery products")

cereal <- c("Rice and rice mixes",
            "Pasta products",
            "Other cereal grains and cereal products")

fruit <- c("Fresh fruit",
           "Preserved fruit and fruit preparations",
           "Nuts and seeds")

vegetables <- c("Fresh vegetables",
                "Frozen and dried vegetables",
                "Canned vegetables and other vegetable preparations")

dairy <- c("Cheese",
           "Milk",
           "Butter", 
           "Ice cream and ice milk (including novelties)", 
           "Other dairy products",
           "Eggs and other egg products")

meat <- c("Beef", 
          "Pork", 
          "Poultry",
          "Other meat and poultry",
          "Processed meat")

seafood <- c("Fresh or frozen fish",
             "Canned fish or other preserved fish",
             "Seafood and other marine products")

other <- c("Non-alcoholic beverages and beverage mixes",
           "Sugar and confectionery",
           "Margarine, oils and fats (excluding butter)",
           "Condiments, spices and vinegars",
           "Infant food",
           "Frozen prepared food",
           "Soup (except infant soup)",
           "Ready-to-serve prepared food",
           "Snack food",
           "Other food preparations")

subgroups <- list(food_groups, bakery, cereal, fruit, vegetables, dairy, meat, seafood, other)
names(subgroups) <- c("All food expenditures", food_groups)

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

provinces <- c("British Columbia",
               "Alberta",
               "Saskatchewan",
               "Manitoba", 
               "Ontario",
               "Quebec",
               "New Brunswick",
               "Prince Edward Island",
               "Nova Scotia",
               "Newfoundland and Labrador")

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
all_col <- c("Canada" = "#000000", "British Columbia" = "#E69F00", 
            "Alberta" = "#56B4E9", "Saskatchewan" = "#009E73", 
            "Manitoba" = "#CC79A7", "Ontario" = "#0072B2",
            "Quebec" = "#D55E00", "New Brunswick" = "#CC79A7",
            "Prince Edward Island" = "#E6CB00",
            "Nova Scotia" = "#9999CC",
            "Newfoundland and Labrador" = "#66CC99")


