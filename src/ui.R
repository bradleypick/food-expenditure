# UI R script for food expenditure app
#
# Bradley Pick January 17, 2018
#

ui <- fluidPage(
  
  ## title
  titlePanel("Canadian Food Expenditure Data Explorer"),
  
  ## sidebar layput
  sidebarPanel(
    
    selectInput("food", "Food Categories",
                choices = c("Food expenditures", food_groups),
                selected = "Food expenditures",
                selectize=FALSE,
                size=10),
    
    checkboxInput("subGroups", 
                  label=c("Show Location Options"),
                  value=FALSE),

    
    
    #actionButton("randfood", label = "Random Food"),
    
    

    conditionalPanel(
      condition = "input.subGroups",
      ## location input
      checkboxGroupInput("geoInput", "Location",
                         choices = c("Canada", provinces),
                         selected = c("Canada", provinces))
                     ),
    
    ## food group input
    radioButtons("foodgroupID", "Food purchased from:", 
                       choices = list("Stores" = store_rest[1],
                                      "Restaurants" = store_rest[2]),
                       selected = store_rest[1]),
    
    ## year input
    selectInput("bar_year", label = "Year of Subgroup Breakdown", 
                choices = min(data$Ref_Date):max(data$Ref_Date), 
                selected = 2016),
    
    uiOutput("moreControls"), 
    
    height =300, width=3
    
    ),
  
  mainPanel(
    plotlyOutput("linePlot", width = 800),
    plotlyOutput("barPlot", width = 800)
  
    # tabsetPanel(
    #   tabPanel("Compare over time", plotlyOutput("linePlot", width = 800)),
    #   tabPanel("Compare across food groups", plotlyOutput("barPlot"))
    )
    
  
  
)
