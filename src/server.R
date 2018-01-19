# Server R script for food expenditure app
#
# Bradley Pick January 17, 2018
#

server <- function(input, output) {
  
  line_data <- reactive({
    
    data %>% 
      filter(Ref_Date >= min(input$yearInput)) %>% 
      filter(Ref_Date <= max(input$yearInput)) %>%
      filter(SUMMARY %in% input$foodgroupID) %>% 
      filter(GEO %in% input$geoInput)
        
      
    
  })
  
  bar_data <- reactive({
    
    data %>% 
      filter(Ref_Date >= min(input$yearInput)) %>% 
      filter(Ref_Date <= max(input$yearInput)) %>%
      filter(SUMMARY %in% food_groups) %>% 
      filter(GEO %in% geographies)
    
  })
  
  output$barPlot <- renderPlot({

    bar_data() %>%
      filter(Ref_Date - x_loc() < 10) %>% 
      ggplot(aes(x = SUMMARY, y = Value)) +
      geom_bar(aes(fill = GEO), position="dodge", stat="identity") +
      scale_fill_brewer("Geography", palette = "Dark2") +
      scale_x_discrete("Group") +
      scale_y_continuous("Dollars") +
      theme_bw() +
      theme(axis.text.x = element_text(angle = 35, hjust = 1, size=10))


  })
  
  output$info <- renderText({
    
    if (!is.null(input$line_click)) {
      loc <- input$line_click
      paste0(loc$x, " ", round(loc$y, 2))
    } else {
      paste0("NULL")
    }
    
  })
  
  observeEvent(input$line_click, {
    cat("Showing", input$line_click$x, "rows\n")
  })
  
  x_loc <- eventReactive(input$line_click, {
    input$line_click$x
  })
  
  output$linePlot <- renderPlot({
    
    line_data() %>%
      ggplot(aes(x = Ref_Date, y = Value, 
                 colour = GEO, linetype = SUMMARY)) +
      geom_line() +
      scale_x_continuous("Year") +
      scale_y_continuous("Dollars")
    
  })
  
}
