# UI R script for food expenditure app
#
# Bradley Pick January 17, 2018
#

ui <- fluidPage(theme = shinytheme("flatly"),
  
  ## title
  titlePanel("What do Canadians Eat?"),
  
  ## sidebar layout
  sidebarPanel(
    
    ## food group selector
    selectInput("food", "Food Categories",
                choices = c("All food expenditures", food_groups),
                selected = "All food expenditures",
                selectize=FALSE,
                size=9),
    
    ## geography selector
    checkboxGroupInput("geoInput", "Location",
                        choices = c("Canada", provinces),
                        selected = c("Canada", "British Columbia", 
                                     "Ontario", "Nova Scotia")),

    
    ## year of subgroup breakdown selector
    selectInput("bar_year", label = "Year of Subgroup Breakdown", 
                choices = min(data$Ref_Date):max(data$Ref_Date), 
                selected = 2016),
    
    uiOutput("moreControls"), 
    
    height =300, width=3
    
    ),
  
  mainPanel(
    plotlyOutput("linePlot", width = 800),
    plotlyOutput("barPlot", width = 800)
  
    )
    
  
  
)
