# Server R script for food expenditure app
#
# Bradley Pick January 17, 2018
#

server <- function(input, output) {
  
  observeEvent(input$line_click, {
    #cat("Showing", input$line_click$x, "rows\n")
  })
  
  x_loc <- eventReactive(input$line_click, {
    input$line_click$x
  })
  
  observeEvent(input$foodgroupID, {})
  
  group <- eventReactive(input$foodgroupID, {
    input$foodgroupID
  })
  
  line_data <- reactive({
    
    line_data <- data %>% 
      filter(Ref_Date >= min(input$yearInput)) %>% 
      filter(Ref_Date <= max(input$yearInput)) %>%
      filter(SUMMARY %in% input$foodgroupID) %>% 
      filter(GEO %in% input$geoInput)
        
    return(line_data)
    
  })
  
  bar_data <- reactive({
    
    if (group() == "Food purchased from restaurants") {
      summary_filter <- times
    } else {
      summary_filter <- food_groups
    }
    
    if (is.null(x_loc())) {
      bar_data <- NULL
    } else {
      bar_data <- data %>% 
        filter(Ref_Date - x_loc() < 0.1) %>% 
        filter(SUMMARY %in% summary_filter) %>% 
        filter(GEO %in% geographies)
    }
    
    return(bar_data)
    
  })
  
  output$linePlot <- renderPlot({
    
    line_data() %>%
      ggplot(aes(x = Ref_Date, y = Value, 
                 colour = GEO)) +
      geom_line() +
      geom_point() +
      scale_colour_brewer("Geography", palette = "Dark2") +
      scale_x_continuous("Year") +
      scale_y_continuous("Dollars")
    
  })
  
  output$info <- renderText({
    
    if (!is.null(input$line_click)) {
      loc <- input$line_click
      paste0(loc$x, " ", round(loc$y, 2))
    } else {
      paste0("NULL")
    }
    
  })
  
  output$barPlot <- renderPlot({
    
    if(is.null(bar_data())) {
      #print("Click somewhere")
    } else {
      
      bar_data() %>%
        ggplot(aes(x = SUMMARY, y = Value)) +
        geom_bar(aes(fill = GEO), position="dodge", stat="identity") +
        scale_fill_brewer("Geography", palette = "Dark2") +
        scale_x_discrete("Group") +
        scale_y_continuous("Dollars") +
        theme_bw() +
        theme(axis.text.x = element_text(angle = 35, hjust = 1, size=10))
      
    }
    
  })
  
}
