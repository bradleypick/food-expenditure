# UI R script for food expenditure app
#
# Bradley Pick January 17, 2018
#

ui <- fluidPage(
  
  ## title
  titlePanel("Statistics Canada Annual Food Expenditure Data Explorer"),
  
  ## sidebar layput
  sidebarPanel(

    ## location input
    checkboxGroupInput("geoInput", "Location",
                       choices = c("Canada", geographies),
                       selected = c("Canada", "British Columbia", "Ontario")),
    
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
    
    height ="100%"
    
    ),
  
  mainPanel(
    
    ## plots
    plotlyOutput("linePlot", width = "100%", height = 300),
               #click = "line_click"),#clickOpts("line_click", clip= TRUE)),
    
    plotlyOutput("barPlot", width = "100%", height = 300)
    
  )
  
)
