# Server R script for food expenditure app
#
# Bradley Pick January 17, 2018
#

server <- function(input, output) {
  
  ########################
  ## Reactive Variables ##
  ########################
  
  ## Inputs -- monitor inputs for update of data
  
  
  
  
  
  observeEvent(input$food, {})
  
  food <- eventReactive(input$food, {
    input$food
  })
  
  observeEvent(input$bar_year, {})
  
 bar_year <- eventReactive(input$bar_year, {
    input$bar_year
  })
  
  observeEvent(input$foodgroupID, {})
  
  group <- eventReactive(input$foodgroupID, {
    input$foodgroupID
  })
  
  observeEvent(input$geoInput, {})
  
  geo <- eventReactive(input$geoInput, {
    input$geoInput
  })
  
  ## Data -- update data based on changing inputs
  
  line_data <- reactive({
    
    line_data <- data %>% 
      filter(SUMMARY %in% food()) %>% 
      filter(GEO %in% geo())
        
    return(line_data)
    
  })
  
  bar_data <- reactive({
    
    if (group() == "Food purchased from restaurants") {
      summary_filter <- times
      bar_data <- data %>% 
        filter(SUMMARY %in% summary_filter) %>% 
        filter(GEO %in% geo()) %>% 
        mutate(SUMMARY = fct_recode(SUMMARY,
                                    Breakfast = "Restaurant breakfasts",
                                    Lunch = "Restaurant lunches",
                                    Dinner = "Restaurant dinners")) %>% 
        mutate(SUMMARY = fct_relevel(SUMMARY, c("Breakfast", "Lunch", "Dinner")))
    } else {
      summary_filter <- food_groups
      bar_data <- data %>% 
        filter(SUMMARY %in% summary_filter) %>% 
        filter(GEO %in% geo()) %>% 
        mutate(SUMMARY = fct_recode(SUMMARY,
                                    Bakery = "Bakery products",
                                    Grains = "Cereal grains and cereal products",
                                    Fruit = "Fruit, fruit preparations and nuts",
                                    Vegetables = "Vegetables and vegetable preparations",
                                    Dairy ="Dairy products and eggs",
                                    Meat = "Meat",
                                    Seafood = "Fish and seafood",
                                    Other = "Non-alcoholic beverages and other food products")) 
    }
    
    
    
    return(bar_data)
    
  })
  
  #####################
  ####### Plots #######
  #####################
  
  output$linePlot <- renderPlotly({
    
    if (food() == "Food expenditures") {
      fg <- ""
    } else {
      fg <- paste0(" on ", food())
    }
    
    l <- line_data() %>%
      mutate(GEO = fct_relevel(GEO, c("Canada", provinces))) %>% 
      ggplot(aes(x = Ref_Date, y = Value, colour = GEO)) +
      geom_line() +
      geom_point(aes(text=sprintf("Av. Expenditure: $%s<br>Date: %s<br>Location: %s",
                                  Value, Ref_Date, GEO))) +
      scale_colour_manual("Location", values = all_col) +
      scale_x_continuous("Year", 
                         breaks = min(data$Ref_Date):max(data$Ref_Date)) +
      scale_y_continuous("Dollars", labels = dollar_format()) +
      ggtitle(paste0("Average Annual Household Expenditure", fg)) +
      theme_bw()
    
    ggplotly(l, tooltip = "text")
    #l
  })
  
  
  output$barPlot <- renderPlotly({
    
    year <- as.numeric(bar_year())
    
    b <- bar_data() %>%
      mutate(GEO = fct_relevel(GEO, c("Canada", provinces))) %>% 
      filter(Ref_Date == year) %>%
      ggplot(aes(x = fct_reorder(SUMMARY, Value), y = Value, fill = GEO)) +
      geom_bar(aes(text=sprintf("Group: %s<br>Av. Expenditure: $%s<br>Location: %s", 
                                SUMMARY, Value, GEO)),
               position="dodge", stat="identity") +
      scale_fill_manual("Location", values = all_col) +
      scale_x_discrete("Group") +
      scale_y_continuous("Dollars", labels = dollar_format()) +
      ggtitle(paste0("Subgroup Expenditure Breakdown for ", year)) + 
      theme_bw() #+
      #theme(axis.text.x = element_text(angle = -15, hjust = 1, size=10))
    
    ggplotly(b, tooltip = "text")
    #b
    
  })
  
}
