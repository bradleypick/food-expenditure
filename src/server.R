# Server R script for food expenditure app
#
# Bradley Pick January 17, 2018
#

server <- function(input, output) {
  
  observeEvent(input$line_click, {})
  
  x_loc <- eventReactive(input$line_click, {
    input$line_click$x
  })
  
  observeEvent(input$foodgroupID, {})
  
  group <- eventReactive(input$foodgroupID, {
    input$foodgroupID
  })
  
  observeEvent(input$geoInput, {})
  
  geo <- eventReactive(input$geoInput, {
    input$geoInput
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
    
    bar_data <- data %>% 
      filter(SUMMARY %in% summary_filter) %>% 
      filter(GEO %in% geo())
    
    return(bar_data)
    
  })
  
  output$linePlot <- renderPlot({
    
    line_data() %>%
      ggplot(aes(x = Ref_Date, y = Value, 
                 colour = fct_relevel(GEO, c("Canada", geographies)))) +
      geom_line() +
      geom_point() +
      scale_colour_manual("Geography", values = cbbPalette) +
      scale_x_continuous("Year", breaks = 2010:2016) +
      scale_y_continuous("Dollars", labels = dollar_format()) +
      theme_bw()
    
  })
  
  output$info <- renderText({
    
    if (!is.null(input$line_click)) {
      loc <- input$line_click
      fill <- round(loc$x, 0)
    } else {
      fill <- ""
    }
    paste0("Click line plot for detailed expenditure\n breakdown of year: ", fill)
  })
  
  output$barPlot <- renderPlot({
    
    #input$action
    
    click <- x_loc()
    
    if(is.null(bar_data())) {
      #print("Click somewhere")
    } else {
      
      bar_data() %>%
        filter(Ref_Date - click < 0.1) %>%
        ggplot(aes(x = SUMMARY, y = Value, 
                   fill = fct_relevel(GEO, c("Canada", geographies)))) +
        geom_bar(position="dodge", stat="identity") +
        scale_fill_manual("Geography", values = cbbPalette) +
        scale_x_discrete("Group") +
        scale_y_continuous("Dollars", labels = dollar_format()) +
        ggtitle(paste0("Detailed expenditure breakdown for ", round(click, 0))) + 
        theme_bw() +
        theme(axis.text.x = element_text(angle = 35, hjust = 1, size=10))
    }
    
  })
  
}
