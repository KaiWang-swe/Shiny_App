function(input, output) {
    output$trend <- renderPlot(
        vgsales %>%
            filter(Genre == input$Genre &
                       Platform == input$Platform) %>%
            select(Year, 'sales' = starts_with(input$Region, ignore.case = F)) %>%
            group_by(Year) %>%
            summarise(n = sum(sales)) %>%
            ggplot(aes(x = Year, y = n)) +
            geom_line(group = 1,color='lightblue') +
            ggtitle('Year over year trend ') +
            theme_bw() +
            ylab('Sales in millions')
    )
    
    
    output$top5 <- renderPlot(
        vgsales %>%
            filter(Genre == input$Genre &
                       Platform == input$Platform)
        %>% select(
            Name,
            Platform,
            Year,
            Genre,
            Publisher,
            'sales' = starts_with(input$Region, ignore.case = F)
        ) %>%
            top_n(5, sales) %>%
            group_by(Publisher) %>%
            summarise(Name = Name, Sales = as.numeric(sales)) %>%
            arrange(desc(Sales)) %>%
            
            ggplot(aes(
                x = reorder(Name, Sales), y = Sales
            )) +
            geom_col(fill = "lightblue") +
            ggtitle("Top 5 bestselling games") +
            coord_flip() +
            theme_bw() +
            xlab("Games") +
            ylab('Sales in millions')
    )
    output$table <- renderDataTable(vgsales)
    
    output$mymap <- renderLeaflet({
        v <- vgsales %>%
            filter(Genre == input$Genre &
                       Platform == input$Platform) %>%
            select(Year, 'sales' = starts_with(input$Region, ignore.case = F)) %>%
              summarise(n = sum(sales))
        if (input$Region=='NA'){
        leaflet() %>% addTiles(attribution = 'Number of games sold in NA') %>% 
            addMarkers(lng=-74.0059, lat=40.7128, popup=paste(as.character(v$n),'million copies sold!'))
        } else if (input$Region=='EU'){
            leaflet() %>% addTiles(attribution = 'Number of games sold in EU') %>% 
                addMarkers(lng=2.352222, lat=48.856613, popup=paste(as.character(v$n),'million copies sold!'))
        } else if (input$Region=='JP'){
            leaflet() %>% addTiles(attribution = 'Number of games sold in JP') %>% 
                addMarkers(lng=141.237656, lat=40.592312, popup=paste(as.character(v$n),'million copies sold!'))
        }else {
            leaflet() %>% addTiles(attribution = 'Number of games sold in the World') %>% 
                addMarkers(lng=-79.383186, lat=43.653225, popup=paste(as.character(v$n),'million copies sold!'))
        }
    })
    
}

