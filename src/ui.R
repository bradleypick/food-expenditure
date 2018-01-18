# UI R script for food expenditure app
#
# Bradley Pick January 17, 2018
#
#
#

library(shiny)
library(readr)


data <- read_csv("../data/cansim-food-exp.csv")

store_rest <- c("Food purchased from stores", 
                "Food purchased from restaurants")

food_groups <- c("Bakery products",
                 "Cereal grains and cereal products",
                 "Fruit, fruit preparations and nuts",
                 "Vegetables and vegetable preparations",
                 "Dairy products and eggs",
                 "Meat",
                 "Fish and seafood",
                 "Non-alcoholic beverages and other food products")

ui <- fluidPage(
  
  ## title
  titlePanel("Food expenditure data"),
  
  sidebarPanel(
    sliderInput("yearInput", "Price", min = 2010, max = 2016,
                value = 2010, sep=""), 
    width = 4),
  
  mainPanel(
    
    plotlyOutput("donutPlot"), 
    
    width = 10
    
  )
  
)
