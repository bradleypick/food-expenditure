# Server R script for food expenditure app
#
# Bradley Pick January 17, 2018
#
#
#

library(shiny)
library(readr)
library(plotly)

food_groups <- c("Bakery products",
                 "Cereal grains and cereal products",
                 "Fruit, fruit preparations and nuts",
                 "Vegetables and vegetable preparations",
                 "Dairy products and eggs",
                 "Meat",
                 "Fish and seafood",
                 "Non-alcoholic beverages and other food products")

data <- read_csv("../data/cansim-food-exp.csv")

server <- function(input, output) {
  
  output$donutPlot <- renderPlotly({
    data %>% 
      filter(SUMMARY %in% food_groups) %>% 
      filter(Ref_Date == input$yearInput) %>% 
      group_by(SUMMARY) %>% 
      plot_ly(labels = ~SUMMARY, values = ~Value) %>% 
      add_pie(hole = 0.5)
  })
  
}
