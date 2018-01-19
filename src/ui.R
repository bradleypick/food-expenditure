# UI R script for food expenditure app
#
# Bradley Pick January 17, 2018
#

ui <- fluidPage(
  
  ## title
  titlePanel("Statistics Canada Food Expenditure data"),
  
  sidebarPanel(
    
    sliderInput("yearInput", "Year", min = 2010, max = 2016,
                value = c(2010, 2016), sep=""), 
    
    checkboxGroupInput("geoInput", "Geography",
                       choices = c("Canada", geographies),
                       selected = "Canada"),
    
    checkboxGroupInput("foodgroupID", "Food Group", 
                       choices = store_rest,
                       selected = store_rest),
    
    uiOutput("moreControls")
    
    ),
  
  mainPanel(
    
    plotOutput("linePlot", width = "100%",
               click = "line_click"),
    
    verbatimTextOutput("info"),
    
    plotOutput("barPlot", width = "100%")
    
    
    
    
    
  )
  
)
