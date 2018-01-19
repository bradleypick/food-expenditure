# UI R script for food expenditure app
#
# Bradley Pick January 17, 2018
#

ui <- fluidPage(
  
  ## title
  titlePanel("Statistics Canada Household Food Expenditure data"),
  
  sidebarPanel(
    
    sliderInput("yearInput", "Year", min = 2010, max = 2016,
                value = c(2010, 2016), sep=""),
    
    #actionButton("action", label = "Details for selected year:"),
    
    
    checkboxGroupInput("geoInput", "Geography",
                       choices = c("Canada", geographies),
                       selected = c("Canada", "British Columbia", "Ontario")),
    
    radioButtons("foodgroupID", "Food purchased from:", 
                       choices = list("Stores" = store_rest[1],
                                      "Restaurants" = store_rest[2]),
                       selected = store_rest[1]),
    
    verbatimTextOutput("info"),
    
    uiOutput("moreControls"), 
    
    height ="100%"
    
    ),
  
  mainPanel(
    
    
    
    plotOutput("linePlot", width = "100%", height = 300,
               click = clickOpts("line_click", clip= TRUE)),
    
    plotOutput("barPlot", width = "100%")
    
    
    
    
    
  )
  
)
