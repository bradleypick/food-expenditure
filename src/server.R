# Server R script for food expenditure app
#
# Bradley Pick January 17, 2018
#

server <- function(input, output) {
  
  filtered_data <- reactive({
    
    data %>% 
      filter(Ref_Date >= min(input$yearInput)) %>% 
      filter(Ref_Date <= max(input$yearInput)) %>%
      filter(GEO %in% input$geoInput) %>% 
      filter(SUMMARY %in% input$foodgroupID)  
      
    
  })
  
  output$barPlot <- renderPlot({
    
    filtered_data() %>% 
      ggplot(aes(x = SUMMARY, y = Value)) + 
      geom_bar(aes(fill = as.factor(GEO)), position="dodge", stat="identity") + 
      scale_fill_brewer("Geography", palette = "Dark2") +
      scale_x_discrete("Group") + 
      scale_y_continuous("Dollars", limits=c(0, 1500)) +
      theme(axis.text.x = element_text(angle = 35, hjust = 1, size=10))
    
  },
  width = 800,
  height = 600)
  
  # output$linePlot <- renderPlot({
  #   data %>% 
  #     filter(GEO %in% c("British Columbia")) %>% 
  #     filter(SUMMARY %in% food_groups) %>% 
  #     mutate(Value = as.numeric(Value)) %>% 
  #     ggplot(aes(x = Ref_Date, y = Value, group = SUMMARY)) + 
  #     geom_line(aes(colour = SUMMARY)) + 
  #     scale_x_continuous("Date") + 
  #     scale_y_continuous("Dollars", limits=c(0, 1500)) 
  # })
  
}
