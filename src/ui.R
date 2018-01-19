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
                       choices = geographies,
                       selected = geographies),
    
    checkboxGroupInput("foodgroupID", "Food Group", 
                       choices = food_groups,
                       selected = food_groups),
    
    uiOutput("moreControls")
    
    ),
  
  mainPanel(
    
    plotOutput("barPlot", width = "100%",
               hover = hoverOpts(id = "bar_hover", delay = 0)), 
    
    plotOutput("linePlot")
    
  )
  
)
